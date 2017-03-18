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
    public class WorkingHourController : Controller
    {
        private readonly ISiteService _siteService;
        private readonly IAuthorizationService _authorizationService;
        private readonly IRepository<WorkingHourRecord> _workingHourRecords;

        public IOrchardServices Services { get; set; }
        public WorkingHourController(IOrchardServices orchardService
                        ,ISiteService siteService
                        ,IShapeFactory shapeFactory
                        ,IAuthorizationService authorizationService
                        ,IRepository<WorkingHourRecord> workingHourRecords)
        {
            Services = orchardService;
            _siteService = siteService;
            _authorizationService = authorizationService;
            _workingHourRecords = workingHourRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            Shape = shapeFactory;
        }

        dynamic Shape { get; set; }
        public Localizer T { get; set; }
        public ILogger Logger { get; set; }


        // GET: WorkingHour
        public ActionResult Index(WorkingHourIndexOptions options, PagerParameters pagerParameters)
        {
            if (!Services.Authorizer.Authorize(Faurecia.ADL.Permissions.MaintainWorkingHour, T("Not authorized to maintain working hour")))
                return new HttpUnauthorizedResult();
            return Filter(options, pagerParameters);
        }

        [HttpPost, ActionName("Index")]
        [Orchard.Mvc.FormValueRequired("submit.Filter")]
        public ActionResult Filter(WorkingHourIndexOptions options, PagerParameters pagerParameters)
        {
            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);

            // default options
            if (options == null)
                options = new WorkingHourIndexOptions();

            var queries = _workingHourRecords.Table;
            if (!string.IsNullOrWhiteSpace(options.Search))
            {
                queries = queries.Where(w => w.Year.ToString().Contains(options.Search));
            }
            switch (options.Filter)
            {
                case WorkingHourFilter.LastestVersion:
                    queries = queries.Where(o => o.IsUsed==true);
                    break;
            }

            var pagerShape = Shape.Pager(pager).TotalItemCount(queries.Count());

            switch (options.Order)
            {
                case WorkingHourOrder.Year:
                    queries = queries.OrderBy(o =>o.Year).OrderBy(o=>o.EditTime);
                    break;
                case WorkingHourOrder.YearDesc:
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

            var model = new WorkingHourIndexViewModel
            {
                WorkingHours = results
                    .Select(x => new WorkingHoursEntry { WorkingHour = x })
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
                return PartialView("_WorkingHours", model);
            }
            return View("Index",model);
        }

        public ActionResult Create()
        {
            WorkingHourRecord record = _workingHourRecords.Table.OrderByDescending(o => o.Year).FirstOrDefault();
            if (record == null)
            {
                record = new WorkingHourRecord()
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

            WorkingHourCreateViewModel viewModel = new WorkingHourCreateViewModel();
            viewModel.Action = WorkingHourAction.Create;
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
            WorkingHourRecord record = null;
            if (id != 0)
            {
                record = _workingHourRecords.Get(id);
            }
            if (record == null)
            {
                return Create();
            }

            WorkingHourCreateViewModel viewModel = new WorkingHourCreateViewModel();
            viewModel.Action = WorkingHourAction.Edit;
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
            WorkingHourRecord record = null;
            if (id != 0)
            {
                record = _workingHourRecords.Get(id);
            }
            if (record != null)
            {
                record.Editor = User.Identity.Name;
                record.EditTime = DateTime.Now;
                record.IsUsed = false;
                _workingHourRecords.Update(record);
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
                    WorkingHourRecord record = null;
                    if (id != 0)
                    {
                        record = _workingHourRecords.Get(id);
                    }
                    if (record != null)
                    {
                        record.Editor = User.Identity.Name;
                        record.EditTime = DateTime.Now;
                        record.IsUsed = false;
                        _workingHourRecords.Update(record);
                    }
                }
                return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
            }
            else if(actionName.Equals("BulkEdit", StringComparison.InvariantCultureIgnoreCase))
            {
                WorkingHourCreateViewModel viewModel = new WorkingHourCreateViewModel();
                viewModel.Action = WorkingHourAction.BulkEdit;
                WorkingHourRecord record = null;
                if (ids != null)
                {
                    foreach (var id in ids)
                    {
                        viewModel.Ids.Add(id);
                    }
                    if (ids.Count > 0 && ids[0] != 0)
                    {
                        record = _workingHourRecords.Get(ids[0]);
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
                WorkingHourCreateViewModel viewModel = new WorkingHourCreateViewModel();
                TryUpdateModel(viewModel);

                foreach (var id in viewModel.Ids)
                {
                    WorkingHourRecord record = null;
                    int year = DateTime.Now.Year;
                    if (id != 0)
                    {
                        record = _workingHourRecords.Get(id);
                        record.IsUsed = false;
                        record.EditTime = DateTime.Now;
                        record.Editor = User.Identity.Name;
                        year = record.Year;
                        _workingHourRecords.Update(record);
                    }
                    else if (id==0 && viewModel.Year!=0)
                    {
                        int recordCount = _workingHourRecords.Table.Where(w => w.Year == viewModel.Year && w.Id != id).Count();
                        if (recordCount > 0)
                        {
                            throw new Exception(T("Year({0})'s record have been existed.", viewModel.Year).Text);
                        }
                        year = viewModel.Year;
                    }
                    record = new WorkingHourRecord();
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
                    _workingHourRecords.Create(record);
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