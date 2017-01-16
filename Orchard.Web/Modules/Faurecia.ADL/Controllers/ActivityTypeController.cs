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
    public class ActivityTypeController : Controller
    {
        private readonly ISiteService _siteService;
        private readonly IAuthorizationService _authorizationService;
        private readonly IRepository<ActivityTypeRecord> _activityTypeRecords;
        private readonly IRepository<HourRatioRecord> _hourRatioRecords;
        public IOrchardServices Services { get; set; }
        public ActivityTypeController(IOrchardServices orchardService
                        ,ISiteService siteService
                        ,IShapeFactory shapeFactory
                        ,IAuthorizationService authorizationService
                        ,IRepository<ActivityTypeRecord> activityTypeRecords
                        ,IRepository<HourRatioRecord> hourRatioRecords)
        {
            Services = orchardService;
            _siteService = siteService;
            _authorizationService = authorizationService;
            _activityTypeRecords = activityTypeRecords;
            _hourRatioRecords = hourRatioRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            Shape = shapeFactory;
        }

        dynamic Shape { get; set; }
        public Localizer T { get; set; }
        public ILogger Logger { get; set; }


        // GET: ActivityType
        public ActionResult Index(ActivityTypeIndexOptions options, PagerParameters pagerParameters)
        {
            //if (!Services.Authorizer.Authorize(Faurecia.ADL.Permissions.MaintainActivityType, T("Not authorized to list working hours")))
            //    return new HttpUnauthorizedResult();

            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);

            // default options
            if (options == null)
                options = new ActivityTypeIndexOptions();

            var queries = _activityTypeRecords.Table.Where(w=>w.DisplayGroup==ActivityTypeDisplayGroup.DD);
            if (!string.IsNullOrWhiteSpace(options.Search))
            {
                queries = queries.Where(w => w.CostCenter.Contains(options.Search)
                                            || w.ActivityType.Contains(options.Search)
                                            || w.RMBHour.Contains(options.Search)
                                            || w.Comment.Contains(options.Search));
            }

            var pagerShape = Shape.Pager(pager).TotalItemCount(queries.Count());

            switch (options.Order)
            {
                case ActivityTypeOrder.CostCenter:
                    queries = queries.OrderBy(o =>o.CostCenter);
                    break;
                case ActivityTypeOrder.CostCenterDesc:
                    queries = queries.OrderByDescending(o => o.CostCenter);
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

            var model = new ActivityTypeIndexViewModel
            {
                ActivityTypes = results
                    .Select(x => new ActivityTypesEntry { ActivityType = x })
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
                return PartialView("_ActivityTypes", model);
            }
            return View("Index",model);
        }
        public ActionResult Create()
        {
            var viewModel = new ActivityTypeCreateViewModel();
            viewModel.HourRatios = new List<HourRatioCreateEntry>();
            var startYear = DateTime.Now.Year;
            var endYear = startYear + 10;
            for(int i = startYear; i < endYear; i++)
            {
                viewModel.HourRatios.Add(new HourRatioCreateEntry()
                {
                    IsChecked = false,
                    HourRatio = new HourRatioRecord()
                    {
                        Year = i
                    }
                });
            }
            return View("Create", viewModel);
        }

        public ActionResult Edit(int id)
        {
            var activityTypeRecord= _activityTypeRecords.Table.Where(w => w.Id ==id).FirstOrDefault();
            if (activityTypeRecord == null)
            {
                return Create();
            }
            var viewModel = new ActivityTypeCreateViewModel()
            {
                ActivityType=activityTypeRecord.ActivityType,
                Comment= activityTypeRecord.Comment,
                CostCenter= activityTypeRecord.CostCenter,
                DisplayGroup=activityTypeRecord.DisplayGroup,
                Id= activityTypeRecord.Id,
                IsUsed= activityTypeRecord.IsUsed,
                RMBHour= activityTypeRecord.RMBHour,
                TotalGroup= activityTypeRecord.TotalGroup
            };

            var queries = _hourRatioRecords.Table.Where(w => w.ActivityTypeRecord.Id == id).OrderBy(o=>o.Year);


            viewModel.HourRatios = new List<HourRatioCreateEntry>();
            foreach(var item in queries)
            {
                viewModel.HourRatios.Add(new HourRatioCreateEntry()
                {
                    HourRatio=item,
                    IsChecked=false
                });
            }

            var startYear = DateTime.Now.Year;
            var endYear = startYear + 10;
            for (int i = startYear; i < endYear; i++)
            {
                var tempQueries= viewModel.HourRatios.Where(w => w.HourRatio.Year == i);
                if (tempQueries.Count() == 0)
                {
                    viewModel.HourRatios.Add(new HourRatioCreateEntry()
                    {
                        IsChecked = false,
                        HourRatio = new HourRatioRecord()
                        {
                            Year = i
                        }
                    });
                }
            }
            return View("Create", viewModel);
        }

        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Save")]
        public ActionResult SavePost()
        {
            ActivityTypeCreateViewModel viewModel = new ActivityTypeCreateViewModel();
            TryUpdateModel(viewModel);

            var record = new ActivityTypeRecord()
            {
                ActivityType=viewModel.ActivityType,
                CostCenter=viewModel.CostCenter,
                Comment=viewModel.Comment,
                DisplayGroup= ActivityTypeDisplayGroup.DD,
                IsUsed=viewModel.IsUsed,
                RMBHour=viewModel.RMBHour,
                TotalGroup=ActivityTypeTotalGroup.DD
            };

            _activityTypeRecords.Create(record);

            return Json(new { Code = 0, Message = "" },JsonRequestBehavior.AllowGet);
        }
    }
}