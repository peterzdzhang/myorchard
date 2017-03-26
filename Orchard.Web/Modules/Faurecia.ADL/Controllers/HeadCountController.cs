using Faurecia.ADL.ViewModels;
using Orchard;
using Orchard.DisplayManagement;
using Orchard.Localization;
using Orchard.Logging;
using Orchard.Security;
using Orchard.Settings;
using Orchard.Themes;
using Orchard.UI.Navigation;
using Orchard.Users.Models;
using Orchard.Users.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Orchard.ContentManagement;
using Orchard.Roles.ViewModels;
using Orchard.Roles.Services;
using Orchard.Data;
using Faurecia.ADL.Models;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class HeadCountController : Controller
    {
        private readonly ISiteService _siteService;
        private readonly IAuthorizationService _authorizationService;
        private readonly IRepository<HeadCountRecord> _headCountRecords;

        public IOrchardServices Services { get; set; }
        public HeadCountController(IOrchardServices orchardService
                        ,ISiteService siteService
                        ,IShapeFactory shapeFactory
                        ,IAuthorizationService authorizationService
                        ,IRepository<HeadCountRecord> headCountRecords)
        {
            Services = orchardService;
            _siteService = siteService;
            _authorizationService = authorizationService;
            _headCountRecords = headCountRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            Shape = shapeFactory;
        }

        dynamic Shape { get; set; }
        public Localizer T { get; set; }
        public ILogger Logger { get; set; }


        // GET: HeadCount
        public ActionResult Index(HeadCountIndexOptions options, PagerParameters pagerParameters)
        {
            if (!Services.Authorizer.Authorize(Faurecia.ADL.Permissions.MaintainHeadCount, T("Not authorized to maintain head count")))
                return new HttpUnauthorizedResult();
            return Filter(options, pagerParameters);
        }

        [HttpPost, ActionName("Index")]
        [Orchard.Mvc.FormValueRequired("submit.Filter")]
        public ActionResult Filter(HeadCountIndexOptions options, PagerParameters pagerParameters)
        {
            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);

            // default options
            if (options == null)
                options = new HeadCountIndexOptions();

            var queries = _headCountRecords.Table;
            if (!string.IsNullOrWhiteSpace(options.Search))
            {
                queries = queries.Where(w => w.Year.ToString().Contains(options.Search));
            }
            switch (options.Filter)
            {
                case HeadCountFilter.LastestVersion:
                    queries = queries.Where(o => o.IsUsed==true);
                    break;
            }

            var pagerShape = Shape.Pager(pager).TotalItemCount(queries.Count());

            switch (options.Order)
            {
                case HeadCountOrder.Year:
                    queries = queries.OrderBy(o =>o.Year).OrderBy(o=>o.EditTime);
                    break;
                case HeadCountOrder.YearDesc:
                    queries = queries.OrderByDescending(o => o.Year).OrderBy(o => o.EditTime);
                    break;
            }
           

            if (pager.GetStartIndex() > 0)
            {
                queries = queries.Skip(pager.GetStartIndex());
            }
            if (pager.PageSize > 0)
            {
                queries = queries.Take(pager.PageSize);
            }
            var results = queries.ToList();

            var model = new HeadCountIndexViewModel
            {
                HeadCounts = results
                    .Select(x => new HeadCountsEntry { HeadCount = x })
                    .ToList(),
                Options = options,
                Pager = pagerShape
            };

            // maintain previous route data when generating page links
            var routeData = new RouteData();
            routeData.Values.Add("Options.Filter", options.Filter);
            routeData.Values.Add("Options.Search", options.Search);
            routeData.Values.Add("Options.Order", options.Order);
            pagerShape.RouteData(routeData);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_HeadCounts", model);
            }
            return View("Index",model);
        }

        public ActionResult Create()
        {
            HeadCountRecord record = _headCountRecords.Table.Where(w => w.IsUsed == true).OrderByDescending(o => o.Year).FirstOrDefault();
            if (record == null)
            {
                record = new HeadCountRecord()
                {
                    Year=DateTime.Now.Year-1,
                    Jan = 22 * 8,
                    Feb = 20 * 8,
                    Mar = 22 * 8,
                    Apr = 21 * 8,
                    May = 22 * 8,
                    Jun = 21 * 8,
                    Jul = 22 * 8,
                    Aug = 22 * 8,
                    Sep = 21 * 8,
                    Oct = 22 * 8,
                    Nov = 21 * 8,
                    Dev = 22 * 8,
                    IsUsed=true,
                    CreateTime=DateTime.Now,
                    Creator=User.Identity.Name,
                    Editor=User.Identity.Name,
                    EditTime=DateTime.Now
                };
            }

            HeadCountCreateViewModel viewModel = new HeadCountCreateViewModel();
            viewModel.Action = HeadCountAction.Create;
            viewModel.Ids.Add(0);
            viewModel.Year = record.Year+1;
            viewModel.Jan = record.Jan ?? 0;
            viewModel.Feb = record.Feb ?? 0;
            viewModel.Mar = record.Mar ?? 0;
            viewModel.Apr = record.Apr ?? 0;
            viewModel.May = record.May ?? 0;
            viewModel.Jun = record.Jun ?? 0;
            viewModel.Jul = record.Jul ?? 0;
            viewModel.Aug = record.Aug ?? 0;
            viewModel.Sep = record.Sep ?? 0;
            viewModel.Oct = record.Oct ?? 0;
            viewModel.Nov = record.Nov ?? 0;
            viewModel.Dev = record.Dev ?? 0;
            return PartialView("_Create", viewModel);
        }
        public ActionResult Edit(int id)
        {
            HeadCountRecord record = null;
            if (id != 0)
            {
                record = _headCountRecords.Get(id);
            }
            if (record == null)
            {
                return Create();
            }

            HeadCountCreateViewModel viewModel = new HeadCountCreateViewModel();
            viewModel.Action = HeadCountAction.Edit;
            viewModel.Ids.Add(record.Id);
            viewModel.Year = record.Year;
            viewModel.Jan = record.Jan ?? 0;
            viewModel.Feb = record.Feb ?? 0;
            viewModel.Mar = record.Mar ?? 0;
            viewModel.Apr = record.Apr ?? 0;
            viewModel.May = record.May ?? 0;
            viewModel.Jun = record.Jun ?? 0;
            viewModel.Jul = record.Jul ?? 0;
            viewModel.Aug = record.Aug ?? 0;
            viewModel.Sep = record.Sep ?? 0;
            viewModel.Oct = record.Oct ?? 0;
            viewModel.Nov = record.Nov ?? 0;
            viewModel.Dev = record.Dev ?? 0;
            return PartialView("_Create", viewModel);
        }

        public ActionResult Delete(int id)
        {
            HeadCountRecord record = null;
            if (id != 0)
            {
                record = _headCountRecords.Get(id);
            }
            if (record != null)
            {
                record.Editor = User.Identity.Name;
                record.EditTime = DateTime.Now;
                record.IsUsed = false;
                _headCountRecords.Update(record);
            }
            return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
        }
        
        public ActionResult BulkAction(IList<int> ids, string actionName)
        {
            actionName = actionName == null ? string.Empty : actionName.Trim();
            if (actionName.Equals("BulkDelete",StringComparison.InvariantCultureIgnoreCase))
            {
                foreach (var id in ids)
                {
                    HeadCountRecord record = null;
                    if (id != 0)
                    {
                        record = _headCountRecords.Get(id);
                    }
                    if (record != null)
                    {
                        record.Editor = User.Identity.Name;
                        record.EditTime = DateTime.Now;
                        record.IsUsed = false;
                        _headCountRecords.Update(record);
                    }
                }
                return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
            }
            else if(actionName.Equals("BulkEdit", StringComparison.InvariantCultureIgnoreCase))
            {
                HeadCountCreateViewModel viewModel = new HeadCountCreateViewModel();
                viewModel.Action = HeadCountAction.BulkEdit;
                HeadCountRecord record = null;
                if (ids != null)
                {
                    foreach (var id in ids)
                    {
                        viewModel.Ids.Add(id);
                    }
                    if (ids.Count > 0 && ids[0] != 0)
                    {
                        record = _headCountRecords.Get(ids[0]);
                    }
                }
                if (record != null)
                {
                    viewModel.Year = record.Year;
                    viewModel.Jan = record.Jan ?? 0;
                    viewModel.Feb = record.Feb ?? 0;
                    viewModel.Mar = record.Mar ?? 0;
                    viewModel.Apr = record.Apr ?? 0;
                    viewModel.May = record.May ?? 0;
                    viewModel.Jun = record.Jun ?? 0;
                    viewModel.Jul = record.Jul ?? 0;
                    viewModel.Aug = record.Aug ?? 0;
                    viewModel.Sep = record.Sep ?? 0;
                    viewModel.Oct = record.Oct ?? 0;
                    viewModel.Nov = record.Nov ?? 0;
                    viewModel.Dev = record.Dev ?? 0;
                }
                return PartialView("_Create", viewModel);
            }

            return Json(new { Code = 0, Message = T("success.").Text }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Save()
        {
            try
            {
                HeadCountCreateViewModel viewModel = new HeadCountCreateViewModel();
                TryUpdateModel(viewModel);

                foreach (var id in viewModel.Ids)
                {
                    HeadCountRecord record = null;
                    int year = DateTime.Now.Year;
                    if (id != 0)
                    {
                        record = _headCountRecords.Get(id);
                        record.IsUsed = false;
                        record.EditTime = DateTime.Now;
                        record.Editor = User.Identity.Name;
                        year = record.Year;
                        _headCountRecords.Update(record);
                    }
                    else if (id==0 && viewModel.Year!=0)
                    {
                        int recordCount = _headCountRecords.Table
                                                           .Where(w => w.Year == viewModel.Year && w.Id != id && w.IsUsed==true)
                                                           .Count();
                        if (recordCount > 0)
                        {
                            throw new Exception(T("Year({0})'s record have been existed.", viewModel.Year).Text);
                        }
                        year = viewModel.Year;
                    }
                    record = new HeadCountRecord();
                    record.Year = year;
                    record.Jan = viewModel.Jan;
                    record.Feb = viewModel.Feb;
                    record.Mar = viewModel.Mar;
                    record.Apr = viewModel.Apr;
                    record.May = viewModel.May;
                    record.Jun = viewModel.Jun;
                    record.Jul = viewModel.Jul;
                    record.Aug = viewModel.Aug;
                    record.Sep = viewModel.Sep;
                    record.Oct = viewModel.Oct;
                    record.Nov = viewModel.Nov;
                    record.Dev = viewModel.Dev;
                    record.IsUsed = true;
                    record.Editor = User.Identity.Name;
                    record.EditTime = DateTime.Now;
                    record.CreateTime = DateTime.Now;
                    record.Creator = User.Identity.Name;
                    _headCountRecords.Create(record);
                }
            }
            catch(Exception e)
            {
                Logger.Error(e, e.Message);
                return Json(new { Code = 1000, Message = e.Message }, JsonRequestBehavior.AllowGet);
            }

            return Json(new { Code = 0, Message = T("Save success.").Text },JsonRequestBehavior.AllowGet);
        }

        
    }
}