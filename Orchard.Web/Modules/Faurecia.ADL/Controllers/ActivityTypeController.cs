﻿using Faurecia.ADL.ViewModels;
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
            if (!Services.Authorizer.Authorize(Faurecia.ADL.Permissions.MaintainHourRateBaseline, T("Not authorized to maintain hour rate baseline")))
                return new HttpUnauthorizedResult();

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
            switch (options.VersionFilter)
            {
                case ActivityTypeVersionFilter.LastestVersion:
                    queries = queries.Where(o => o.IsUsed == true);
                    break;
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
            queries = queries.OrderBy(o => o.ActivityType).OrderBy(o => o.RMBHour).OrderBy(o => o.VersionNo).OrderBy(o => o.EditTime);
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
            viewModel.Action = ActivityTypeBulkAction.Create;
            viewModel.Ids.Add(0);
            viewModel.HourRatios = new List<HourRatioCreateEntry>();
            var startYear = DateTime.Now.Year-3;
            var endYear = startYear + 20;
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
                IsUsed= activityTypeRecord.IsUsed,
                RMBHour= activityTypeRecord.RMBHour,
                TotalGroup= activityTypeRecord.TotalGroup
            };
            viewModel.Action = ActivityTypeBulkAction.Edit;
            viewModel.Ids.Add(activityTypeRecord.Id);
            SetViewModelHourRatios(id, viewModel);
            return View("Create", viewModel);
        }
        public ActionResult View(int id)
        {
            var activityTypeRecord = _activityTypeRecords.Table.Where(w => w.Id == id).FirstOrDefault();
            if (activityTypeRecord == null)
            {
                return Create();
            }
            var viewModel = new ActivityTypeCreateViewModel()
            {
                ActivityType = activityTypeRecord.ActivityType,
                Comment = activityTypeRecord.Comment,
                CostCenter = activityTypeRecord.CostCenter,
                DisplayGroup = activityTypeRecord.DisplayGroup,
                IsUsed = activityTypeRecord.IsUsed,
                RMBHour = activityTypeRecord.RMBHour,
                TotalGroup = activityTypeRecord.TotalGroup
            };
            viewModel.Action = ActivityTypeBulkAction.View;
            viewModel.Ids.Add(activityTypeRecord.Id);
            SetViewModelHourRatios(id, viewModel);
            return View("Create", viewModel);
        }

        private void SetViewModelHourRatios(int id, ActivityTypeCreateViewModel viewModel)
        {
            var queries = _hourRatioRecords.Table.Where(w => w.ActivityTypeRecord.Id == id).OrderBy(o => o.Year);
            viewModel.HourRatios = new List<HourRatioCreateEntry>();
            foreach (var item in queries)
            {
                viewModel.HourRatios.Add(new HourRatioCreateEntry()
                {
                    HourRatio = item,
                    IsChecked = false
                });
            }
            var startYear = DateTime.Now.Year - 3;
            var endYear = startYear + 20;
            for (int i = startYear; i < endYear; i++)
            {
                var tempQueries = viewModel.HourRatios.Where(w => w.HourRatio.Year == i);
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
            viewModel.HourRatios = viewModel.HourRatios.OrderBy(o => o.HourRatio.Year).ToList();
        }

        public ActionResult Delete(int id)
        {
            ActivityTypeRecord record = null;
            if (id != 0)
            {
                record = _activityTypeRecords.Get(id);
            }
            if (record != null)
            {
                record.EditTime = DateTime.Now;
                record.Editor = User.Identity.Name;
                record.IsUsed = false;
                _activityTypeRecords.Update(record);
            }

            //var queries = _hourRatioRecords.Table.Where(w => w.ActivityTypeRecord.Id == id);
            //foreach(var item in queries)
            //{
            //    _hourRatioRecords.Delete(item);
            //}

            return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Disabled(int id)
        {
            ActivityTypeRecord record = null;
            if (id != 0)
            {
                record = _activityTypeRecords.Get(id);
            }
            if (record != null)
            {
                record.EditTime = DateTime.Now;
                record.Editor = User.Identity.Name;
                record.IsUsed = false;
                _activityTypeRecords.Update(record);
            }
            return Json(new { Code = 0, Message = T("Disabled success.").Text }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Enabled(int id)
        {
            ActivityTypeRecord record = null;
            if (id != 0)
            {
                record = _activityTypeRecords.Get(id);
            }
            if (record != null)
            {
                record.EditTime = DateTime.Now;
                record.Editor = User.Identity.Name;
                record.IsUsed = true;
                _activityTypeRecords.Update(record);
            }
            return Json(new { Code = 0, Message = T("Enabled success.").Text }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult BulkAction(IList<int> ids, string actionName)
        {
            actionName = actionName == null ? string.Empty : actionName.Trim();
            if (actionName.Equals("BulkDelete", StringComparison.InvariantCultureIgnoreCase))
            {
                foreach (var id in ids)
                {
                    Delete(id);
                }
                return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
            }
            else if(actionName.Equals("BulkDisabled", StringComparison.InvariantCultureIgnoreCase))
            {
                foreach (var id in ids)
                {
                    Disabled(id);
                }
                return Json(new { Code = 0, Message = T("Disabled success.").Text }, JsonRequestBehavior.AllowGet);
            }
            else if(actionName.Equals("BulkEnabled", StringComparison.InvariantCultureIgnoreCase))
            {
                foreach (var id in ids)
                {
                    Enabled(id);
                }
                return Json(new { Code = 0, Message = T("Enabled success.").Text }, JsonRequestBehavior.AllowGet);
            }
            else if (actionName.Equals("BulkEdit", StringComparison.InvariantCultureIgnoreCase))
            {
                ActivityTypeCreateViewModel viewModel = new ActivityTypeCreateViewModel();
                viewModel.Action = ActivityTypeBulkAction.BulkEdit;
                ActivityTypeRecord record = null;
                if (ids != null)
                {
                    foreach (var id in ids)
                    {
                        viewModel.Ids.Add(id);
                    }
                    if (ids.Count > 0 && ids[0] != 0)
                    {
                        record = _activityTypeRecords.Get(ids[0]);
                    }
                }
                if (record != null)
                {
                    viewModel.Comment = record.Comment;
                    SetViewModelHourRatios(record.Id, viewModel);
                }
                return View("Create", viewModel);
            }

            return Json(new { Code = 0, Message = T("success.").Text }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Save")]
        public ActionResult SavePost()
        {
            try
            {
                ActivityTypeCreateViewModel viewModel = new ActivityTypeCreateViewModel();
                TryUpdateModel(viewModel);

                foreach (var id in viewModel.Ids)
                {
                    ActivityTypeRecord record;
                    if (id != 0)
                    {
                        record = _activityTypeRecords.Get(id);
                        SaveHistory(record);
                        record.EditTime = DateTime.Now;
                        record.Editor = User.Identity.Name;
                    }
                    else
                    {
                        record = new ActivityTypeRecord()
                        {
                            CreateTime = DateTime.Now,
                            Creator = User.Identity.Name,
                            IsUsed = true,
                            Editor = User.Identity.Name,
                            EditTime = DateTime.Now
                        };
                    }
                    if (viewModel.Action == ActivityTypeBulkAction.Create)
                    {
                        record.ActivityType = viewModel.ActivityType;
                        record.CostCenter = viewModel.CostCenter;
                        record.Comment = viewModel.Comment;
                        record.DisplayGroup = ActivityTypeDisplayGroup.DD;
                        record.IsUsed = viewModel.IsUsed;
                        record.RMBHour = viewModel.RMBHour;
                        record.TotalGroup = ActivityTypeTotalGroup.DD;
                    }
                    else  if (viewModel.Action == ActivityTypeBulkAction.Edit)
                    {
                        record.ActivityType = viewModel.ActivityType;
                        record.CostCenter = viewModel.CostCenter;
                        record.Comment = viewModel.Comment;
                        record.RMBHour = viewModel.RMBHour;
                    }
                    else if (viewModel.Action == ActivityTypeBulkAction.BulkEdit)
                    {
                        record.Comment = viewModel.Comment;
                    }
                    record.VersionNo = record.VersionNo + 1;
                    if (id != 0)
                    {
                        _activityTypeRecords.Update(record);
                    }
                    else
                    {
                        _activityTypeRecords.Create(record);
                    }

                    foreach (var item in viewModel.HourRatios)
                    {
                        HourRatioRecord hrRecord = null;
                        if (item.HourRatio.Id != 0)
                        {
                            hrRecord = _hourRatioRecords.Table.Where(w=>w.Year==item.HourRatio.Year && w.ActivityTypeRecord.Id==record.Id).SingleOrDefault();
                        }
                        if (hrRecord == null)
                        {
                            hrRecord = new HourRatioRecord()
                            {
                                ActivityTypeRecord=record
                            };
                        }
                        hrRecord.Year = item.HourRatio.Year;
                        hrRecord.Jan = item.HourRatio.Jan;
                        hrRecord.Feb = item.HourRatio.Jan;
                        hrRecord.Mar = item.HourRatio.Jan;
                        hrRecord.Apr = item.HourRatio.Jan;
                        hrRecord.May = item.HourRatio.Jan;
                        hrRecord.Jun = item.HourRatio.Jan;
                        hrRecord.Jul = item.HourRatio.Jan;
                        hrRecord.Aug = item.HourRatio.Jan;
                        hrRecord.Sep = item.HourRatio.Jan;
                        hrRecord.Oct = item.HourRatio.Jan;
                        hrRecord.Nov = item.HourRatio.Jan;
                        hrRecord.Dev = item.HourRatio.Jan;
                        if (item.HourRatio.Id != 0)
                        {
                            _hourRatioRecords.Update(hrRecord);
                        }
                        else
                        {
                            _hourRatioRecords.Create(hrRecord);
                        }
                    }
                }


            }
            catch (Exception e)
            {
                return Json(new { Code = 1000, Message = e.Message }, JsonRequestBehavior.AllowGet);
            }

            return Json(new { Code = 0, Message = T("Save success.").Text }, JsonRequestBehavior.AllowGet);
        }

        private void SaveHistory(ActivityTypeRecord record)
        {
            ActivityTypeRecord newRecord=new ActivityTypeRecord()
            {
                ActivityType=record.ActivityType,
                CreateTime=record.CreateTime,
                Comment=record.Comment,
                CostCenter=record.CostCenter,
                Creator=record.Creator,
                DisplayGroup=record.DisplayGroup,
                Editor = User.Identity.Name,
                EditTime = DateTime.Now,
                IsUsed =false,
                OriginalRecordId=record.Id,
                RMBHour=record.RMBHour,
                TotalGroup=record.TotalGroup,
                VersionNo=record.VersionNo
            };
            _activityTypeRecords.Create(newRecord);

            var queries = _hourRatioRecords.Table.Where(w =>w.ActivityTypeRecord.Id == record.Id);
            foreach (var item in queries)
            {
                HourRatioRecord hrRecord = hrRecord = new HourRatioRecord()
                {
                    ActivityTypeRecord = newRecord
                };
                hrRecord.Year = item.Year;
                hrRecord.Jan = item.Jan;
                hrRecord.Feb = item.Feb;
                hrRecord.Mar = item.Mar;
                hrRecord.Apr = item.Apr;
                hrRecord.May = item.May;
                hrRecord.Jun = item.Jun;
                hrRecord.Jul = item.Jul;
                hrRecord.Aug = item.Aug;
                hrRecord.Sep = item.Sep;
                hrRecord.Oct = item.Oct;
                hrRecord.Nov = item.Nov;
                hrRecord.Dev = item.Dev;
                _hourRatioRecords.Create(hrRecord);
            }
        }
    }
}