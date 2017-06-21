using Faurecia.ADL.Models;
using Faurecia.ADL.ViewModels;
using Newtonsoft.Json;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using Orchard;
using Orchard.Data;
using Orchard.DisplayManagement;
using Orchard.Localization;
using Orchard.Logging;
using Orchard.Mvc;
using Orchard.Mvc.Extensions;
using Orchard.Settings;
using Orchard.Themes;
using Orchard.UI.Navigation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class DefaultController : Controller
    {
        private readonly IOrchardServices _orchardService;
        private readonly ISiteService _siteService;
        private readonly IRepository<ADLRecord> _adlRecords;
        private readonly IRepository<ADLWorkingHourRecord> _adlWorkingHourRecords;
        private readonly IRepository<ADLHeadCountRecord> _adlHeadCountRecords;
        private readonly IRepository<ADLHourRatioRecord> _adlHourRatioRecords;
        private readonly IRepository<ADLCostRecord> _adlCostRecords;
        private readonly IRepository<ActivityTypeRecord> _activityTypeRecords;
        private readonly IRepository<WorkingHourRecord> _workingHourRecords;
        private readonly IRepository<HourRatioRecord> _hourRatioRecords;
        private readonly IRepository<ADLKickOffRecord> _adlKickOffRecords;

        public DefaultController(IOrchardServices orchardService,
            ISiteService siteService,
            IShapeFactory shapeFactory,
            IRepository<ADLRecord> adlRecords,
            IRepository<ADLWorkingHourRecord> adlWorkingHourRecords,
            IRepository<ADLHeadCountRecord> adlHeadCountRecords,
            IRepository<ADLHourRatioRecord> adlHourRatioRecords,
            IRepository<ADLCostRecord> adlCostRecords,
            IRepository<ActivityTypeRecord> activityTypeRecords,
            IRepository<WorkingHourRecord> workingHourRecords,
            IRepository<HourRatioRecord> hourRatioRecords,
            IRepository<ADLKickOffRecord> adlKickOffRecords)
        {
            
            _siteService = siteService;
            _orchardService = orchardService;
            _adlRecords = adlRecords;
            _adlWorkingHourRecords = adlWorkingHourRecords;
            _adlHeadCountRecords = adlHeadCountRecords;
            _adlHourRatioRecords = adlHourRatioRecords;
            _adlCostRecords = adlCostRecords;
            _adlRecords = adlRecords;
            _activityTypeRecords = activityTypeRecords;
            _workingHourRecords = workingHourRecords;
            _hourRatioRecords=hourRatioRecords;
            _adlKickOffRecords = adlKickOffRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            New = shapeFactory;
        }

        dynamic New { get; set; }
        public ILogger Logger { get; set; }
        public Localizer T { get; set; }
        // GET: Default
        public ActionResult Index(ADLIndexOptions options, PagerParameters pagerParameters)
        {
            if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetHome, T("Not authorized to show budget home.")))
                return new HttpUnauthorizedResult();

            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);
            pager.UpdateTargetId = "indexQueryResults";
            if (options == null)
            {
                options = new ADLIndexOptions();
            }
            var queries = _adlRecords.Table;

            if(!string.IsNullOrWhiteSpace(options.ProjectNo))
            {
                queries = queries.Where(w => w.ProjectNo.Contains(options.ProjectNo));
            }
            if (!string.IsNullOrWhiteSpace(options.Customer))
            {
                queries = queries.Where(w => w.Customer.Contains(options.Customer));
            }
            if (!string.IsNullOrWhiteSpace(options.ProgramManager))
            {
                queries = queries.Where(w => w.ProgramManager.Contains(options.ProgramManager));
            }
            if (options.StartDate1!=null)
            {
                queries = queries.Where(w => w.StartDate>=options.StartDate1);
            }
            if (options.StartDate2 != null)
            {
                queries = queries.Where(w => w.StartDate <= options.StartDate2);
            }
            switch (options.Filter)
            {
                case ADLFilter.LastestVersion:
                    queries = queries.Where(w => w.IsLastest == true);
                    break;
            }
            var pagerShape = New.Pager(pager).TotalItemCount(queries.Count());

            switch (options.Order)
            {
                case ADLOrder.ProjectNo:
                    queries = queries.OrderBy(u => u.ProjectNo);
                    break;
                case ADLOrder.Customer:
                    queries = queries.OrderBy(u => u.Customer);
                    break;
                case ADLOrder.ProgramManager:
                    queries = queries.OrderBy(u => u.ProgramManager);
                    break;
                case ADLOrder.StartDate:
                    queries = queries.OrderBy(u => u.StartDate);
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
            var model = new ADLIndexViewModel
            {
                ADLs = results.Select(x => new ADLIndexEntry
                {
                    ADLRecord = x,
                    Id = x.Id
                }).ToList(),
                Options = options,
                Pager = pagerShape
            };
            // maintain previous route data when generating page links
            var routeData = new RouteData();
            routeData.Values.Add("Options.Filter", options.Filter);
            routeData.Values.Add("Options.ProjectNo", options.ProjectNo);
            routeData.Values.Add("Options.Customer", options.Customer);
            routeData.Values.Add("Options.Order", options.Order);
            routeData.Values.Add("Page", pager.Page);
            pagerShape.RouteData(routeData);

           
            if (Request.IsAjaxRequest())
            {
                return PartialView("_IndexQueryResult", model);
            }
            model.IsDisplayCompareCost = _orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetCompareCost);
            model.IsDisplayCompareHeadCount = _orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetCompareHeadCount);
            return View(model);
        }
        // GET: Create
        public ActionResult Create(int Id = 0)
        {
            ViewBag.Title = T("Create New Budget").Text;
            var viewModel = new ADLCreateViewModel()
            {
                Action = EnumActions.New,
                Head=new ADLHeadViewModel(),
                Detail=new ADLDetailViewModel(),
                Message=string.Empty
            };
            SetQuotations(viewModel);
            var record = _adlRecords.Get(Id);
            if (record != null)
            {
                if (record.IsLastest)
                {
                    if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetCreateNew, T("Not authorized to create new on the budget module.")))
                    {
                        viewModel.Action = EnumActions.View;
                        ViewBag.Title = T("Budget View").Text;
                    }
                    else
                    {
                        viewModel.Action = EnumActions.Modify;
                        ViewBag.Title = T("Budget Create Modify").Text;
                    }
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("Budget View").Text;
                }
            }
            else
            {
                if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetCreateNew, T("Not authorized to create new on the budget module.")))
                {
                    return new HttpUnauthorizedResult();
                }
                record = new ADLRecord() { VersionNo=1,Currency= "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            return View("Quotation",viewModel);
        }

        public ActionResult CopyTo(int Id = 0)
        {
            if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetCopyTo, T("Not authorized to create new by copy on the budget module.")))
            {
                return new HttpUnauthorizedResult();
            }

            ViewBag.Title = T("Budget Copy from {0}", Id).Text;
            var viewModel = new ADLCreateViewModel()
            {
                Action = EnumActions.New,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };

            SetQuotations(viewModel);
            var record = _adlRecords.Get(Id);
            if (record != null)
            {
                ViewBag.Title = T("Budget Copy from {0}.{1}",record.ProjectNo,record.VersionNo).Text;
            }
            else
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);

            viewModel.Head.ProjectNo = string.Empty;
            viewModel.Head.Name = string.Empty;
            viewModel.Head.Id = 0;
            viewModel.Head.Status = EnumStatus.Inwork;
            viewModel.Head.Phase = EnumPhase.Creating;

            return View("Quotation", viewModel);
        }
        public ActionResult Quotation(int Id=0)
        {

            ViewBag.Title = T("Budget Quotation").Text;
            var viewModel = new ADLQuotationViewModel()
            {
                Action = EnumActions.New,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };
           
            SetQuotations(viewModel);
            var record = _adlRecords.Get(Id);
            if (record != null)
            {
                if (record.IsLastest)
                {
                    if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetQuotation, T("Not authorized to quotation on the budget module.")))
                    {
                        viewModel.Action = EnumActions.View;
                    }
                    else
                    {
                        viewModel.Action = EnumActions.Modify;
                    }
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("Budget View").Text;
                }
            }
            else
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            SetHeadViewModel(viewModel, record);
            return View("Quotation", viewModel);
        }
        public ActionResult IBP(int Id = 0)
        {
           

            ViewBag.Title = T("Budget IBP").Text;
            var viewModel = new ADLIBPViewModel()
            {
                Action = EnumActions.New,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };
            //SetIBPs(viewModel);
            //SetActivityTypes(viewModel);
            var record = _adlRecords.Get(Id);
            if (record != null)
            {
                if (record.IsLastest)
                {
                    if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetIBP, T("Not authorized to IBP on the budget module.")))
                    {
                        viewModel.Action = EnumActions.View;
                        ViewBag.Title = T("Budget View").Text;
                    }
                    else
                    {
                        viewModel.Action = EnumActions.Modify;
                    }
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("Budget View").Text;
                }
            }
            else
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            SetHeadViewModel(viewModel, record);
            return View("Quotation", viewModel);
        }
        public ActionResult ECR(int Id = 0)
        {
            ViewBag.Title = T("Budget ECR").Text;
            var viewModel = new ADLECRViewModel()
            {
                Action = EnumActions.New,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };
            SetIBPs(viewModel);
            //SetActivityTypes(viewModel);
            var record = _adlRecords.Get(Id);
            if (record != null)
            {
                if (record.IsLastest)
                {
                    if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetECR, T("Not authorized to ECR on the budget module.")))
                    {
                        viewModel.Action = EnumActions.View;
                        ViewBag.Title = T("Budget View").Text;
                    }
                    else
                    {
                        viewModel.Action = EnumActions.Modify;
                    }
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("Budget View").Text;
                }
            }
            else
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            SetHeadViewModel(viewModel, record);
            return View("Quotation", viewModel);
        }
        public ActionResult View(int Id = 0)
        {
            if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetView, T("Not authorized to view on the budget module.")))
                return new HttpUnauthorizedResult();

            ViewBag.Title = T("Budget View").Text;
            var viewModel = new ADLQuotationViewModel()
            {
                Action = EnumActions.New,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };
            viewModel.Action = EnumActions.View;
            ViewBag.Title = T("ADL View").Text;
            SetIBPs(viewModel);
            //SetActivityTypes(viewModel);
            var record = _adlRecords.Get(Id);
            if (record == null)
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            SetHeadViewModel(viewModel, record);
            return View("Quotation", viewModel);
        }
        
        public ActionResult Delete()
        {
            if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetDelete))
            {
                return Json(new { Code = 1, Message = T("Not authorized to delete on the budget module.").Text }, JsonRequestBehavior.AllowGet);
            }

            string ids = Request["ids"];
            if (!string.IsNullOrEmpty(ids))
            {
                try
                {
                    foreach (string id in ids.Split(','))
                    {
                        int nId = 0;
                        if (int.TryParse(id, out nId))
                        {
                            _adlRecords.Delete(new ADLRecord() { Id = nId });
                            foreach(ADLCostRecord item in  _adlCostRecords.Table.Where(w => w.ADLRecord.Id == nId))
                            {
                                _adlCostRecords.Delete(item);
                            }
                            foreach (ADLHeadCountRecord item in _adlHeadCountRecords.Table.Where(w => w.ADLRecord.Id == nId))
                            {
                                _adlHeadCountRecords.Delete(item);
                            }
                            foreach (ADLHourRatioRecord item in _adlHourRatioRecords.Table.Where(w => w.ADLRecord.Id == nId))
                            {
                                _adlHourRatioRecords.Delete(item);
                            }
                            foreach (ADLKickOffRecord item in _adlKickOffRecords.Table.Where(w => w.ADLRecord.Id == nId))
                            {
                                _adlKickOffRecords.Delete(item);
                            }
                            foreach (ADLWorkingHourRecord item in _adlWorkingHourRecords.Table.Where(w => w.ADLRecord.Id == nId))
                            {
                                _adlWorkingHourRecords.Delete(item);
                            }
                        }

                    }
                }
                catch(Exception ex)
                {
                    return Json(new { Code = 1, Message = T("Delete Failed: ")+ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            return Json(new {Code=0, Message=T("Delete Success.") },JsonRequestBehavior.AllowGet);
        }

        public ActionResult Diff()
        {
            if (!_orchardService.Authorizer.Authorize(Faurecia.ADL.Permissions.BudgetCompare, T("Not authorized to compare on the budget module.")))
                return new HttpUnauthorizedResult();


            ADLDiffViewModel viewModel = new ADLDiffViewModel();
            string ids = Request["ids"];
            if (!string.IsNullOrEmpty(ids))
            {
                foreach (string id in ids.Split(','))
                {
                    int nId = 0;
                    int.TryParse(id, out nId);
                    ADLViewModel vm = GetADLViewModel(nId);
                    viewModel.ViewModels.Add(vm);
                }
            }
            return View("Diff",viewModel);
        }

        private ADLViewModel GetADLViewModel(int id)
        {
            var viewModel = new ADLViewModel()
            {
                Action = EnumActions.View,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };
            //SetIBPs(viewModel);
            //SetActivityTypes(viewModel);
            var record = _adlRecords.Get(id);
            if (record == null)
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            SetHeadViewModel(viewModel, record);
            return viewModel;
        }

        private void SetQuotations(ADLViewModel viewModel)
        {
            viewModel.Quotations = new List<SelectListItem>()
            {
                new SelectListItem() { Text=T("Any Quotation Person").Text,Value="" }
            };
        }
        private void SetIBPs(ADLViewModel viewModel)
        {
            viewModel.IBPs = new List<SelectListItem>()
            {
                new SelectListItem() { Text=T("Any IBP Person").Text,Value="" }
            };
        }
        private void SetYears(ADLViewModel viewModel)
        {
            int startYear = DateTime.Now.Date.Year;
            int endYear = DateTime.Now.Date.Year;

            if (viewModel.Head.StartDate != null)
            {
                if (viewModel.Head.StartDate.Value.Year < startYear)
                {
                    startYear = viewModel.Head.StartDate.Value.Year;
                }
                if (viewModel.Head.StartDate.Value.Year > endYear)
                {
                    endYear = viewModel.Head.StartDate.Value.Year;
                }
            }
            if (viewModel.Head.SOPDate != null)
            {
                if (viewModel.Head.SOPDate.Value.Year < startYear)
                {
                    startYear = viewModel.Head.SOPDate.Value.Year;
                }
                if (viewModel.Head.SOPDate.Value.Year > endYear)
                {
                    endYear = viewModel.Head.SOPDate.Value.Year;
                }
            }
            if (viewModel.Head.PTRDate != null)
            {
                if (viewModel.Head.PTRDate.Value.Year < startYear)
                {
                    startYear = viewModel.Head.PTRDate.Value.Year;
                }
                if (viewModel.Head.PTRDate.Value.Year > endYear)
                {
                    endYear = viewModel.Head.PTRDate.Value.Year;
                }
            }
            if (viewModel.Head.ProtoDate != null)
            {
                if (viewModel.Head.ProtoDate.Value.Year < startYear)
                {
                    startYear = viewModel.Head.ProtoDate.Value.Year;
                }
                if (viewModel.Head.ProtoDate.Value.Year > endYear)
                {
                    endYear = viewModel.Head.ProtoDate.Value.Year;
                }
            }
            if (viewModel.Head.OfferDate != null)
            {
                if (viewModel.Head.OfferDate.Value.Year < startYear)
                {
                    startYear = viewModel.Head.OfferDate.Value.Year;
                }
                if (viewModel.Head.OfferDate.Value.Year > endYear)
                {
                    endYear = viewModel.Head.OfferDate.Value.Year;
                }
            }
            if (endYear < startYear + 4) endYear = startYear + 4;
            for (int year = startYear; year <= endYear; year++)
            {
                viewModel.Years.Add(year);
                ADLDetailEntry entry = new ADLDetailEntry();
                entry.Year = year;
                viewModel.Detail.Entries.Add(entry);
            }
        }
        private IList<ActivityTypeEntry> GetActivityTypes()
        {
            var queries = _activityTypeRecords.Table.Where(w => w.IsUsed == true)
                                                    .OrderBy(w=>w.ActivityType)
                                                    .OrderBy(w=>w.CostCenter)
                                                    .OrderBy(w=>w.Id);
            List<ActivityTypeEntry> lst= new List<ActivityTypeEntry>();
            foreach(var item in queries)
            {
                lst.Add(new ActivityTypeEntry()
                {
                    Id=item.Id,
                    VersionNo=item.VersionNo,
                    ActivityType=item.ActivityType,
                    CostCenter=item.CostCenter,
                    RMBHour=item.RMBHour,
                    Comment=item.Comment,
                    TotalGroup=item.TotalGroup,
                    DisplayGroup=item.DisplayGroup
                });
            }
            return lst;
        }
        private void SetHeadViewModel(ADLViewModel viewModel,ADLRecord adl)
        {
            if (adl == null) return;
            viewModel.Head.Id = adl.Id;
            viewModel.Head.Award = adl.Award;
            viewModel.Head.Ballfix = adl.Ballfix;
            viewModel.Head.Currency = adl.Currency;
            viewModel.Head.Customer = adl.Customer;
            viewModel.Head.FrameMaturity = adl.FrameMaturity;
            viewModel.Head.HA = adl.HA;
            viewModel.Head.KEZE = adl.KEZE;
            viewModel.Head.MileStoneComments = adl.MileStoneComments;
            viewModel.Head.Mockup = adl.MockUp;
            viewModel.Head.Name = adl.Name;
            viewModel.Head.OfferDate = adl.OfferDate;
            viewModel.Head.Phase = adl.Phase;
            viewModel.Head.ProgramController = adl.ProgramController;
            viewModel.Head.ProgramManager = adl.ProgramManager;
            viewModel.Head.ProjectNo = adl.ProjectNo;
            viewModel.Head.ProtoDate = adl.ProtoDate;
            viewModel.Head.PTRDate = adl.PTRDate;
            viewModel.Head.Quotation = adl.Quotation;
            viewModel.Head.Recliner = adl.Recliner;
            viewModel.Head.SOPDate = adl.SOPDate;
            viewModel.Head.StartDate = adl.StartDate;
            viewModel.Head.Status = adl.Status;
            viewModel.Head.Tracks = adl.Tracks;
            viewModel.Head.Type = adl.Type;
            viewModel.Head.Variant1 = adl.Variant1;
            viewModel.Head.Variant2 = adl.Variant2;
            viewModel.Head.Variant3 = adl.Variant3;
            viewModel.Head.VehicelComments = adl.VehicelComments;
            viewModel.Head.QuotationComments = adl.QuotationComments;
            viewModel.Head.IBPComments = adl.IBPComments;
            viewModel.Head.VersionNo = adl.VersionNo;
            viewModel.Head.Creator = adl.Creator;
            viewModel.Head.QuotationTime = adl.QuotationTime;
            viewModel.Head.IBP = adl.IBP;
            viewModel.Head.IBPTime = adl.IBPTime;
            viewModel.Head.WBSID = adl.WBSID;
            viewModel.Head.PV= adl.PV;
            viewModel.Head.DV=adl.DV;
            viewModel.Head.ProgramKickOff=adl.ProgramKickOff;
            viewModel.Head.ToolingKickOff = adl.ToolingKickOff;
        }
        private void SetDetailViewModel(ADLViewModel viewModel,ADLRecord adl)
        {
            foreach (int year in viewModel.Years)
            {
                ADLDetailEntry entry = viewModel.Detail.Entries.SingleOrDefault(w => w.Year == year);
                if(entry==null) { continue; }
                var queries= _adlHeadCountRecords.Table.Where(w => w.ADLRecord.Id == adl.Id && w.Year == year).Select(w=>w.ActivityTypeRecord);

                foreach (var item in queries)
                {
                    var activityTypeEntry = new ActivityTypeEntry()
                    {
                        Id = item.Id,
                        ActivityType = item.ActivityType,
                        VersionNo=item.VersionNo,
                        CostCenter = item.CostCenter,
                        RMBHour = item.RMBHour,
                        Comment = item.Comment,
                        DisplayGroup=item.DisplayGroup,
                        TotalGroup=item.TotalGroup
                    };
                    //HeadCounts
                    HeadCountEntry headCount = GetHeadCountEntry(adl, activityTypeEntry, year);
                    entry.HeadCounts.Add(headCount);
                    //HourRatios
                    HourRatioEntry hourRatio= GetHourRatioEntry(adl, activityTypeEntry, year);
                    entry.HourRatios.Add(hourRatio);
                    //Costs
                    CostEntry cost = GetCostEntry(adl, activityTypeEntry, year);
                    entry.Costs.Add(cost);
                }
                //WorkingHours
                WorkingHourEntry workingHourEntry = GetWorkingHourEntry(adl, year);
                entry.WorkingHours.Add(workingHourEntry);
                //Travels
                var  travelsRecord = _activityTypeRecords.Table.Where(w => w.IsUsed == true 
                                                                      && w.DisplayGroup == ActivityTypeDisplayGroup.Travel);
                foreach(var item in travelsRecord)
                {
                    var activityTypeEntry = new ActivityTypeEntry()
                    {
                        Id = item.Id,
                        VersionNo=item.VersionNo,
                        ActivityType = item.ActivityType,
                        CostCenter = item.CostCenter,
                        RMBHour = item.RMBHour,
                        Comment = item.Comment,
                        DisplayGroup = item.DisplayGroup,
                        TotalGroup = item.TotalGroup
                    };
                    CostEntry cost = GetCostEntry(adl, activityTypeEntry, year);
                    entry.Travels.Add(cost);
                }
                //DVs
                var dvsRecord = _activityTypeRecords.Table.Where(w => w.IsUsed == true
                                                                     && w.DisplayGroup == ActivityTypeDisplayGroup.DV);
                foreach (var item in dvsRecord)
                {
                    var activityTypeEntry = new ActivityTypeEntry()
                    {
                        Id = item.Id,
                         VersionNo=item.VersionNo,
                        ActivityType = item.ActivityType,
                        CostCenter = item.CostCenter,
                        RMBHour = item.RMBHour,
                        Comment = item.Comment,
                        DisplayGroup = item.DisplayGroup,
                        TotalGroup = item.TotalGroup
                    };
                    CostEntry cost = GetCostEntry(adl, activityTypeEntry, year);
                    entry.DVs.Add(cost);
                }
                //DVs
                var pvsRecord = _activityTypeRecords.Table.Where(w => w.IsUsed == true
                                                                     && w.DisplayGroup == ActivityTypeDisplayGroup.PV);
                foreach (var item in pvsRecord)
                {
                    var activityTypeEntry = new ActivityTypeEntry()
                    {
                        Id = item.Id,
                        ActivityType = item.ActivityType,
                        VersionNo=item.VersionNo,
                        CostCenter = item.CostCenter,
                        RMBHour = item.RMBHour,
                        Comment = item.Comment,
                        DisplayGroup = item.DisplayGroup,
                        TotalGroup = item.TotalGroup
                    };
                    CostEntry cost = GetCostEntry(adl, activityTypeEntry, year);
                    entry.PVs.Add(cost);
                }
                //External
                var externalsRecord = _activityTypeRecords.Table.Where(w => w.IsUsed == true
                                                                     && w.DisplayGroup == ActivityTypeDisplayGroup.ExternalSupport);
                foreach (var item in externalsRecord)
                {
                    var activityTypeEntry = new ActivityTypeEntry()
                    {
                        Id = item.Id,
                        ActivityType = item.ActivityType,
                        VersionNo = item.VersionNo,
                        CostCenter = item.CostCenter,
                        RMBHour = item.RMBHour,
                        Comment = item.Comment,
                        DisplayGroup = item.DisplayGroup,
                        TotalGroup = item.TotalGroup
                    };
                    CostEntry cost = GetCostEntry(adl, activityTypeEntry, year);
                    entry.Externals.Add(cost);
                }
                //Capitalized
                var capitalizedsRecord = _activityTypeRecords.Table.Where(w => w.IsUsed == true
                                                                     && w.DisplayGroup == ActivityTypeDisplayGroup.Capitalized);
                foreach (var item in capitalizedsRecord)
                {
                    var activityTypeEntry = new ActivityTypeEntry()
                    {
                        Id = item.Id,
                        ActivityType = item.ActivityType,
                        VersionNo = item.VersionNo,
                        CostCenter = item.CostCenter,
                        RMBHour = item.RMBHour,
                        Comment = item.Comment,
                        DisplayGroup = item.DisplayGroup,
                        TotalGroup = item.TotalGroup
                    };
                    CostEntry cost = GetCostEntry(adl, activityTypeEntry, year);
                    entry.Capitalizeds.Add(cost);
                }
            }
        }
        private HeadCountEntry GetHeadCountEntry(ADLRecord adl, ActivityTypeEntry activityType, int year)
        {
            HeadCountEntry entry = new HeadCountEntry() { Year = year };
            entry.ActivityType = new ActivityTypeEntry()
            {
                Id = activityType.Id,
                ActivityType = activityType.ActivityType,
                Comment = activityType.Comment,
                CostCenter = activityType.CostCenter,
                RMBHour = activityType.RMBHour,
                DisplayGroup=activityType.DisplayGroup,
                TotalGroup=activityType.TotalGroup
            };
            ADLHeadCountRecord record = _adlHeadCountRecords.Table.FirstOrDefault(w => w.ADLRecord.Id == adl.Id
                                                                    && w.ActivityTypeRecord.Id == activityType.Id
                                                                    && w.Year==year);
            if (record != null)
            {
                entry.Id = record.Id;
                entry.Jan = record.Jan;
                entry.Jul = record.Jul;
                entry.Jun = record.Jun;
                entry.Mar = record.Mar;
                entry.May = record.May;
                entry.Nov = record.Nov;
                entry.Oct = record.Oct;
                entry.Sep = record.Sep;
                entry.Apr = record.Apr;
                entry.Aug = record.Aug;
                entry.Dev = record.Dev;
                entry.Feb = record.Feb;
                entry.Year = record.Year;
                entry.Y1 = (record.Jan ?? 0)
                            + (record.Jul ?? 0)
                            + (record.Jun ?? 0)
                            + (record.Mar ?? 0)
                            + (record.May ?? 0)
                            + (record.Nov ?? 0)
                            + (record.Oct ?? 0)
                            + (record.Sep ?? 0)
                            + (record.Apr ?? 0)
                            + (record.Aug ?? 0)
                            + (record.Dev ?? 0)
                            + (record.Feb ?? 0);
            }
            return entry;
        }
        private HourRatioEntry GetHourRatioEntry(ADLRecord adl, ActivityTypeEntry activityType,int year)
        {
            HourRatioEntry entry = new HourRatioEntry() { Year = year };
            entry.ActivityType = new ActivityTypeEntry()
            {
                Id = activityType.Id,
                ActivityType = activityType.ActivityType,
                VersionNo = activityType.VersionNo,
                Comment = activityType.Comment,
                CostCenter = activityType.CostCenter,
                RMBHour = activityType.RMBHour,
                DisplayGroup = activityType.DisplayGroup,
                TotalGroup = activityType.TotalGroup
            };
            ADLHourRatioRecord record = _adlHourRatioRecords.Table.FirstOrDefault(w => w.ADLRecord.Id == adl.Id
                                         && w.ActivityTypeRecord.Id == activityType.Id
                                         && w.Year == year);
            if (record != null)
            {
                entry.Id = record.Id;
                entry.Jan = record.Jan;
                entry.Jul = record.Jul;
                entry.Jun = record.Jun;
                entry.Mar = record.Mar;
                entry.May = record.May;
                entry.Nov = record.Nov;
                entry.Oct = record.Oct;
                entry.Sep = record.Sep;
                entry.Apr = record.Apr;
                entry.Aug = record.Aug;
                entry.Dev = record.Dev;
                entry.Feb = record.Feb;
                entry.Year = record.Year;
                entry.Y1 = (record.Jan ?? 0)
                            + (record.Jul ?? 0)
                            + (record.Jun ?? 0)
                            + (record.Mar ?? 0)
                            + (record.May ?? 0)
                            + (record.Nov ?? 0)
                            + (record.Oct ?? 0)
                            + (record.Sep ?? 0)
                            + (record.Apr ?? 0)
                            + (record.Aug ?? 0)
                            + (record.Dev ?? 0)
                            + (record.Feb ?? 0);
            }

            var queries = _hourRatioRecords.Table.Where(w => w.Year == year && w.ActivityTypeRecord.Id == activityType.Id && w.ActivityTypeRecord.IsUsed == true);
            var hrrecord = queries.FirstOrDefault();
            if (hrrecord != null && adl.Status == EnumStatus.Inwork) //处于工作中的就更新工作时间。
            {
                entry.Jan = hrrecord.Jan;
                entry.Jul = hrrecord.Jul;
                entry.Jun = hrrecord.Jun;
                entry.Mar = hrrecord.Mar;
                entry.May = hrrecord.May;
                entry.Nov = hrrecord.Nov;
                entry.Oct = hrrecord.Oct;
                entry.Sep = hrrecord.Sep;
                entry.Apr = hrrecord.Apr;
                entry.Aug = hrrecord.Aug;
                entry.Dev = hrrecord.Dev;
                entry.Feb = hrrecord.Feb;
                entry.Year = hrrecord.Year;
                entry.Y1 = (hrrecord.Jan ?? 0)
                            + (hrrecord.Jul ?? 0)
                            + (hrrecord.Jun ?? 0)
                            + (hrrecord.Mar ?? 0)
                            + (hrrecord.May ?? 0)
                            + (hrrecord.Nov ?? 0)
                            + (hrrecord.Oct ?? 0)
                            + (hrrecord.Sep ?? 0)
                            + (hrrecord.Apr ?? 0)
                            + (hrrecord.Aug ?? 0)
                            + (hrrecord.Dev ?? 0)
                            + (hrrecord.Feb ?? 0);
            }
            
            return entry;
        }
        private CostEntry GetCostEntry(ADLRecord adl, ActivityTypeEntry activityType, int year)
        {
            CostEntry entry = new CostEntry() { Year = year };
            entry.ActivityType = new ActivityTypeEntry()
            {
                Id = activityType.Id,
                ActivityType = activityType.ActivityType,
                Comment = activityType.Comment,
                CostCenter = activityType.CostCenter,
                RMBHour = activityType.RMBHour,
                DisplayGroup = activityType.DisplayGroup,
                TotalGroup = activityType.TotalGroup
            };
            ADLCostRecord record = _adlCostRecords.Table.FirstOrDefault(w => w.ADLRecord.Id == adl.Id 
                                            && w.ActivityTypeRecord.Id == activityType.Id
                                            && w.Year == year);
            if (record != null)
            {
                entry.Id = record.Id;
                entry.Jan = record.Jan;
                entry.Jul = record.Jul;
                entry.Jun = record.Jun;
                entry.Mar = record.Mar;
                entry.May = record.May;
                entry.Nov = record.Nov;
                entry.Oct = record.Oct;
                entry.Sep = record.Sep;
                entry.Apr = record.Apr;
                entry.Aug = record.Aug;
                entry.Dev = record.Dev;
                entry.Feb = record.Feb;
                entry.Year = record.Year;
                entry.Y1 = (record.Jan ?? 0)
                            + (record.Jul ?? 0)
                            + (record.Jun ?? 0)
                            + (record.Mar ?? 0)
                            + (record.May ?? 0)
                            + (record.Nov ?? 0)
                            + (record.Oct ?? 0)
                            + (record.Sep ?? 0)
                            + (record.Apr ?? 0)
                            + (record.Aug ?? 0)
                            + (record.Dev ?? 0)
                            + (record.Feb ?? 0);
            }
            return entry;
        }
        private WorkingHourEntry GetWorkingHourEntry(ADLRecord adl,int year)
        {
            WorkingHourEntry entry = new WorkingHourEntry()
            {
                Year=year
            };
            WorkingHourRecord record = _workingHourRecords.Table.SingleOrDefault(w => w.Year == year && w.IsUsed == true);
            if (record != null && adl.Status == EnumStatus.Inwork) //处于工作中的就更新工作时间。
            {
                entry.Jan = record.Jan;
                entry.Jul = record.Jul;
                entry.Jun = record.Jun;
                entry.Mar = record.Mar;
                entry.May = record.May;
                entry.Nov = record.Nov;
                entry.Oct = record.Oct;
                entry.Sep = record.Sep;
                entry.Apr = record.Apr;
                entry.Aug = record.Aug;
                entry.Dev = record.Dev;
                entry.Feb = record.Feb;
                entry.Year = record.Year;
                entry.Y1 = (record.Jan ?? 0)
                        + (record.Jul ?? 0)
                        + (record.Jun ?? 0)
                        + (record.Mar ?? 0)
                        + (record.May ?? 0)
                        + (record.Nov ?? 0)
                        + (record.Oct ?? 0)
                        + (record.Sep ?? 0)
                        + (record.Apr ?? 0)
                        + (record.Aug ?? 0)
                        + (record.Dev ?? 0)
                        + (record.Feb ?? 0);
            }
            else
            {
                ADLWorkingHourRecord whrecord = _adlWorkingHourRecords.Table
                                                                .FirstOrDefault(w => w.ADLRecord.Id == adl.Id && w.Year == year);
                if (whrecord != null)
                {
                    entry.Id = whrecord.Id;
                    entry.Jan = whrecord.Jan;
                    entry.Jul = whrecord.Jul;
                    entry.Jun = whrecord.Jun;
                    entry.Mar = whrecord.Mar;
                    entry.May = whrecord.May;
                    entry.Nov = whrecord.Nov;
                    entry.Oct = whrecord.Oct;
                    entry.Sep = whrecord.Sep;
                    entry.Apr = whrecord.Apr;
                    entry.Aug = whrecord.Aug;
                    entry.Dev = whrecord.Dev;
                    entry.Feb = whrecord.Feb;
                    entry.Year = whrecord.Year;
                    entry.Y1 = (whrecord.Jan ?? 0)
                                + (whrecord.Jul ?? 0)
                                + (whrecord.Jun ?? 0)
                                + (whrecord.Mar ?? 0)
                                + (whrecord.May ?? 0)
                                + (whrecord.Nov ?? 0)
                                + (whrecord.Oct ?? 0)
                                + (whrecord.Sep ?? 0)
                                + (whrecord.Apr ?? 0)
                                + (whrecord.Aug ?? 0)
                                + (whrecord.Dev ?? 0)
                                + (whrecord.Feb ?? 0);
                }
            }
            return entry;
        }
        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Save")]
        public ActionResult SavePost()
        {
            var viewModel = new ADLViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {
                viewModel.Head.Status = EnumStatus.Inwork;
                viewModel.Head.NextPhase = viewModel.Head.Phase;
                if (viewModel.Action == EnumActions.New)
                {
                    Common_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Save budget({0}) success.", viewModel.Head.ProjectNo).Text;
                SetRedirectUrl(viewModel);
            }
            else
            {
                viewModel.Code = 1;
                foreach (var item in  ModelState.Where(w => w.Value.Errors.Count > 0)
                                                .Select(item=>item.Value.Errors.FirstOrDefault()))
                {
                    viewModel.Message += item.ErrorMessage+"<br/>";
                }
                viewModel.Message=viewModel.Message.Substring(0, viewModel.Message.Length - 5);
            }
            return Json(JsonConvert.SerializeObject(viewModel));
        }
        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Confirm")]
        public ActionResult ConfirmPost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {

                viewModel.Head.Status = EnumStatus.Frozen;
                viewModel.Head.NextPhase = viewModel.Head.Phase;
                
                if (viewModel.Action == EnumActions.New)
                {
                    Common_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Confirm budget({0}) success.", viewModel.Head.ProjectNo).Text;
                SetRedirectUrl(viewModel);
            }
            else
            {
                viewModel.Code = 1;
                foreach (var item in ModelState.Where(w => w.Value.Errors.Count > 0)
                                                .Select(item => item.Value.Errors.FirstOrDefault()))
                {
                    viewModel.Message += item.ErrorMessage + "<br/>";
                }
                viewModel.Message = viewModel.Message.Substring(0, viewModel.Message.Length - 5);
            }
            return Json(JsonConvert.SerializeObject(viewModel));
        }
        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Submit")]
        public ActionResult SubmitPost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {
                viewModel.Head.Status = EnumStatus.Inwork;
                if (viewModel.Head.Phase == EnumPhase.Creating)
                {
                    viewModel.Head.NextPhase = EnumPhase.Quotation;
                }
                else if (viewModel.Head.Phase == EnumPhase.Quotation
                        || viewModel.Head.Phase == EnumPhase.ECR)
                {
                    viewModel.Head.NextPhase = EnumPhase.IBP;
                }
                else if (viewModel.Head.Phase == EnumPhase.IBP)
                {
                    viewModel.Head.Status = EnumStatus.Frozen;
                    viewModel.Head.NextPhase = EnumPhase.IBP;
                }

                if (viewModel.Action == EnumActions.New)
                {
                    Common_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Submit budget({0}) success.", viewModel.Head.ProjectNo).Text;
                SetRedirectUrl(viewModel);
            }
            else
            {
                viewModel.Code = 1;
                foreach (var item in ModelState.Where(w => w.Value.Errors.Count > 0)
                                                .Select(item => item.Value.Errors.FirstOrDefault()))
                {
                    viewModel.Message += item.ErrorMessage + "<br/>";
                }
                viewModel.Message = viewModel.Message.Substring(0, viewModel.Message.Length - 5);
            }
            return Json(JsonConvert.SerializeObject(viewModel));
        }
        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Reject")]
        public ActionResult RejectPost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {
                viewModel.Head.Status = EnumStatus.Inwork;
                if (viewModel.Head.Phase == EnumPhase.Quotation)
                {
                    viewModel.Head.NextPhase = EnumPhase.Creating;
                    viewModel.Head.Status = EnumStatus.Frozen;
                }
                else if (viewModel.Head.Phase == EnumPhase.IBP)
                {
                    viewModel.Head.Status = EnumStatus.Frozen;
                    viewModel.Head.NextPhase = EnumPhase.Quotation;
                }
                if (viewModel.Action == EnumActions.New)
                {
                    Common_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Reject budget({0}) success.", viewModel.Head.ProjectNo).Text;
                SetRedirectUrl(viewModel);
            }
            else
            {
                viewModel.Code = 1;
                foreach (var item in ModelState.Where(w => w.Value.Errors.Count > 0)
                                                .Select(item => item.Value.Errors.FirstOrDefault()))
                {
                    viewModel.Message += item.ErrorMessage + "<br/>";
                }
                viewModel.Message = viewModel.Message.Substring(0, viewModel.Message.Length - 5);
            }
            return Json(JsonConvert.SerializeObject(viewModel));
        }

        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.ECR")]
        public ActionResult ECRPost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {

                viewModel.Head.Status = EnumStatus.Inwork;
                if (viewModel.Head.Phase == EnumPhase.IBP)
                {
                    viewModel.Head.NextPhase = EnumPhase.ECR;
                }

                if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Start budget({0}) ECR success.", viewModel.Head.ProjectNo).Text;
                SetRedirectUrl(viewModel);
            }
            else
            {
                viewModel.Code = 1;
                foreach (var item in ModelState.Where(w => w.Value.Errors.Count > 0)
                                                .Select(item => item.Value.Errors.FirstOrDefault()))
                {
                    viewModel.Message += item.ErrorMessage + "<br/>";
                }
                viewModel.Message = viewModel.Message.Substring(0, viewModel.Message.Length - 5);
            }
            return Json(JsonConvert.SerializeObject(viewModel));
        }
        private ADLRecord Common_CreateNew(ADLViewModel viewModel,int previousId=0)
        {
            var adl = _adlRecords.Get(viewModel.Head.Id);
            if (adl != null)
            {
                viewModel.Head.ProjectNo = GetProjectNo(viewModel.Head.Name);
                viewModel.Head.VersionNo = 1;
            }
            adl = new Models.ADLRecord()
            {
                CreateTime = DateTime.Now,
                Creator = _orchardService.WorkContext.CurrentUser.UserName
            };


            SetADLRecord(adl, viewModel);
            _adlRecords.Create(adl);

            if (previousId > 0)
            {
                var adlKickOffQuery = from item in _adlKickOffRecords.Table
                                      where item.ADLRecord.Id == previousId
                                      select item;
                foreach (var ko in adlKickOffQuery)
                {
                    ADLKickOffRecord item = new ADLKickOffRecord()
                    {
                        Id = 0,
                        ADLRecord = adl,
                        Content = ko.Content,
                        CreateTime = DateTime.Now,
                        Creator = adl.Creator,
                        Month = ko.Month,
                        Name = ko.Name,
                        Year = ko.Year
                    };
                    if (item.Name == null)
                    {
                        item.Name = string.Empty;
                    }
                    item.Id = 0;
                    item.ADLRecord.Id = adl.Id;
                    if (item.Name.EndsWith("_StartDate") && adl.StartDate != null)
                    {
                        item.Year = adl.StartDate.Value.Year;
                        item.Month = adl.StartDate.Value.Month;
                    }
                    else if (item.Name.EndsWith("_Mockup") && adl.MockUp != null)
                    {
                        item.Year = adl.MockUp.Value.Year;
                        item.Month = adl.MockUp.Value.Month;
                    }
                    else if (item.Name.EndsWith("_OfferDate") && adl.OfferDate != null)
                    {
                        item.Year = adl.OfferDate.Value.Year;
                        item.Month = adl.OfferDate.Value.Month;
                    }
                    else if (item.Name.EndsWith("_ProtoDate") && adl.ProtoDate != null)
                    {
                        item.Year = adl.ProtoDate.Value.Year;
                        item.Month = adl.ProtoDate.Value.Month;
                    }
                    else if (item.Name.EndsWith("_Award") && adl.Award != null)
                    {
                        item.Year = adl.Award.Value.Year;
                        item.Month = adl.Award.Value.Month;
                    }
                    else if (item.Name.EndsWith("_SOPDate") && adl.SOPDate != null)
                    {
                        item.Year = adl.SOPDate.Value.Year;
                        item.Month = adl.SOPDate.Value.Month;
                    }
                    else if (item.Name.EndsWith("_PTRDate") && adl.PTRDate != null)
                    {
                        item.Year = adl.PTRDate.Value.Year;
                        item.Month = adl.PTRDate.Value.Month;
                    }
                    if (item.Year < 0)
                    {
                        item.Year = 0;
                        item.Month = 0;
                    }
                    _adlKickOffRecords.Create(item);
                }
            }

            if (viewModel.Detail!=null)
            {
                foreach (ADLDetailEntry entry in viewModel.Detail.Entries)
                {
                    //创建新的Working Hours
                    foreach(WorkingHourEntry whEntry in entry.WorkingHours)
                    {
                        ADLWorkingHourRecord record = GetWorkingHourRecord(adl, whEntry, true);
                        _adlWorkingHourRecords.Create(record);
                    }
                    //创建新的Hour Ratio
                    foreach (HourRatioEntry hrEntry in entry.HourRatios)
                    {
                        ADLHourRatioRecord record = GetHourRatioRecord(adl, hrEntry, true);
                        _adlHourRatioRecords.Create(record);
                    }
                    //创建新的Head Count
                    foreach (HeadCountEntry hcEntry in entry.HeadCounts)
                    {
                        ADLHeadCountRecord record = GetHeadCountRecord(adl, hcEntry, true);
                        _adlHeadCountRecords.Create(record);
                    }
                    //创建新的Cost
                    foreach (CostEntry costEntry in entry.Costs)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry,true);
                        _adlCostRecords.Create(record);
                    }
                    //创建新的DVs
                    foreach (CostEntry costEntry in entry.DVs)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, true);
                        _adlCostRecords.Create(record);
                    }
                    //创建新的PVs
                    foreach (CostEntry costEntry in entry.PVs)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, true);
                        _adlCostRecords.Create(record);
                    }
                    //创建新的Travels
                    foreach (CostEntry costEntry in entry.Travels)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, true);
                        _adlCostRecords.Create(record);
                    }
                    //创建新的Externals
                    foreach (CostEntry costEntry in entry.Externals)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, true);
                        _adlCostRecords.Create(record);
                    }
                    //创建新的Capitalizeds
                    foreach (CostEntry costEntry in entry.Capitalizeds)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, true);
                        _adlCostRecords.Create(record);
                    }
                }
            }
            viewModel.Head.Id = adl.Id;
            return adl;
        }
        private ADLRecord Common_Modify(ADLViewModel viewModel)
        {
            var adl = _adlRecords.Get(viewModel.Head.Id);
            if (adl == null)
            {
                return Common_CreateNew(viewModel);
            }
            bool isGenerateNewVersion = false;
            //当前阶段是Creating、Quotation
            if (viewModel.Head.Phase==EnumPhase.Creating || viewModel.Head.Phase==EnumPhase.Quotation)
            {
                //如果阶段相同且状态是冻结，表示已Confirm，需要重新生成新的版本。
                if (adl.Phase == viewModel.Head.Phase && adl.Status == EnumStatus.Frozen)
                {
                    isGenerateNewVersion = true;
                }
            }
            else if (viewModel.Head.Phase == EnumPhase.IBP)
            {
                //如果状态是冻结，表示已Confirm/Submit，需要重新生成新的版本。
                if (adl.Status == EnumStatus.Frozen)
                {
                    isGenerateNewVersion = true;
                }
            }
            //重新生成新的版本。
            if (isGenerateNewVersion)
            {
                //获取最新版本号的项目,并更新为非最新版本号。
                adl = _adlRecords.Get(item => item.ProjectNo == viewModel.Head.ProjectNo
                                               && item.IsLastest == true);
                adl.IsLastest = false;
                adl.EditTime = DateTime.Now;
                adl.Editor = _orchardService.WorkContext.CurrentUser.UserName;
                _adlRecords.Update(adl);
                //获取最大版本号，创建一个新的版本号。
                var queries = _adlRecords.Table.Where(w => w.ProjectNo == viewModel.Head.ProjectNo);
                var maxVersionNo = queries.Max(item => item.VersionNo);
                viewModel.Head.VersionNo = maxVersionNo + 1;
                viewModel.Head.Id = 0;
                return Common_CreateNew(viewModel,adl.Id);
            }
            if (adl != null)
            {
                if (adl.Phase == EnumPhase.IBP)
                {
                    adl.IBPTime = viewModel.Head.IBPTime;
                    adl.IBPComments = viewModel.Head.IBPComments;
                    adl.IBP = viewModel.Head.IBP;
                }
                else if (adl.Phase == EnumPhase.Quotation)
                {
                    adl.QuotationTime = viewModel.Head.QuotationTime;
                    adl.QuotationComments = viewModel.Head.QuotationComments;
                    adl.Quotation = viewModel.Head.Quotation;
                }
                SetADLRecord(adl, viewModel);
            };
            _adlRecords.Update(adl);
            var adlKickOffQuery = from item in _adlKickOffRecords.Table
                          where item.ADLRecord.Id == viewModel.Head.Id
                          select item;
            foreach(var item in adlKickOffQuery)
            {
                if(item.Name==null)
                {
                    item.Name = string.Empty;
                }
                item.ADLRecord.Id = adl.Id;
                if (item.Name.EndsWith("_StartDate") && adl.StartDate!=null)
                {
                    item.Year = adl.StartDate.Value.Year;
                    item.Month = adl.StartDate.Value.Month;
                }
                else if (item.Name.EndsWith("_Mockup") && adl.MockUp != null)
                {
                    item.Year = adl.MockUp.Value.Year;
                    item.Month = adl.MockUp.Value.Month;
                }
                else if (item.Name.EndsWith("_OfferDate") && adl.OfferDate != null)
                {
                    item.Year = adl.OfferDate.Value.Year;
                    item.Month = adl.OfferDate.Value.Month;
                }
                else if (item.Name.EndsWith("_ProtoDate") && adl.ProtoDate != null)
                {
                    item.Year = adl.ProtoDate.Value.Year;
                    item.Month = adl.ProtoDate.Value.Month;
                }
                else if (item.Name.EndsWith("_Award") && adl.Award != null)
                {
                    item.Year = adl.Award.Value.Year;
                    item.Month = adl.Award.Value.Month;
                }
                else if (item.Name.EndsWith("_SOPDate") && adl.SOPDate != null)
                {
                    item.Year = adl.SOPDate.Value.Year;
                    item.Month = adl.SOPDate.Value.Month;
                }
                else if (item.Name.EndsWith("_PTRDate") && adl.PTRDate != null)
                {
                    item.Year = adl.PTRDate.Value.Year;
                    item.Month = adl.PTRDate.Value.Month;
                }
                if (item.Year < 0)
                {
                    item.Year = 0;
                    item.Month = 0;
                }
                _adlKickOffRecords.Update(item);
            }

            if (viewModel.Detail != null)
            {
                foreach (ADLDetailEntry entry in viewModel.Detail.Entries)
                {
                    //创建/更新新的Working Hours
                    foreach (WorkingHourEntry whEntry in entry.WorkingHours)
                    {
                        ADLWorkingHourRecord record = GetWorkingHourRecord(adl, whEntry, false);
                        if (record.Id == 0)
                        {
                            _adlWorkingHourRecords.Create(record);
                        }
                        else
                        {
                            _adlWorkingHourRecords.Update(record);
                        }
                    }
                    //创建新的Hour Ratio
                    foreach (HourRatioEntry hrEntry in entry.HourRatios)
                    {
                        ADLHourRatioRecord record = GetHourRatioRecord(adl, hrEntry, false);
                        if (record.Id == 0)
                        {
                            _adlHourRatioRecords.Create(record);
                        }
                        else
                        {
                            _adlHourRatioRecords.Update(record);
                        }
                    }
                    //创建新的Head Count
                    foreach (HeadCountEntry hcEntry in entry.HeadCounts)
                    {
                        ADLHeadCountRecord record = GetHeadCountRecord(adl, hcEntry,false);
                        if (record.Id == 0)
                        {
                            _adlHeadCountRecords.Create(record);
                        }
                        else
                        {
                            _adlHeadCountRecords.Update(record);
                        }
                    }
                    //创建新的Cost
                    foreach (CostEntry costEntry in entry.Costs)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, false);
                        if (record.Id == 0)
                        {
                            _adlCostRecords.Create(record);
                        }
                        else
                        {
                            _adlCostRecords.Update(record);
                        }
                    }
                    //创建新的DVs
                    foreach (CostEntry costEntry in entry.DVs)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, false);
                        if (record.Id == 0)
                        {
                            _adlCostRecords.Create(record);
                        }
                        else
                        {
                            _adlCostRecords.Update(record);
                        }
                    }
                    //创建新的PVs
                    foreach (CostEntry costEntry in entry.PVs)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, false);
                        if (record.Id == 0)
                        {
                            _adlCostRecords.Create(record);
                        }
                        else
                        {
                            _adlCostRecords.Update(record);
                        }
                    }
                    //创建新的Travels
                    foreach (CostEntry costEntry in entry.Travels)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, false);
                        if (record.Id == 0)
                        {
                            _adlCostRecords.Create(record);
                        }
                        else
                        {
                            _adlCostRecords.Update(record);
                        }
                    }
                    //创建新的Externals
                    foreach (CostEntry costEntry in entry.Externals)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, false);
                        if (record.Id == 0)
                        {
                            _adlCostRecords.Create(record);
                        }
                        else
                        {
                            _adlCostRecords.Update(record);
                        }
                    }
                    //创建新的Capitalizeds
                    foreach (CostEntry costEntry in entry.Capitalizeds)
                    {
                        ADLCostRecord record = GetCostRecord(adl, costEntry, false);
                        if (record.Id == 0)
                        {
                            _adlCostRecords.Create(record);
                        }
                        else
                        {
                            _adlCostRecords.Update(record);
                        }
                    }
                }
            }
            return adl;
        }
        private void SetADLRecord(ADLRecord adl,ADLViewModel viewModel)
        {
            adl.ProjectNo = viewModel.Head.ProjectNo;
            adl.VersionNo = viewModel.Head.VersionNo;
            adl.Award = viewModel.Head.Award;
            adl.Ballfix = viewModel.Head.Ballfix;
            adl.Currency = viewModel.Head.Currency;
            adl.Customer = viewModel.Head.Customer;
            adl.FrameMaturity = viewModel.Head.FrameMaturity;
            adl.HA = viewModel.Head.HA;
            adl.KEZE = viewModel.Head.KEZE;
            adl.MileStoneComments = viewModel.Head.MileStoneComments;
            adl.MockUp = viewModel.Head.Mockup;
            adl.PV = viewModel.Head.PV;
            adl.DV = viewModel.Head.DV;
            adl.ProgramKickOff = viewModel.Head.ProgramKickOff;
            adl.ToolingKickOff = viewModel.Head.ToolingKickOff;
            adl.OfferDate = viewModel.Head.OfferDate;
            adl.ProgramController = viewModel.Head.ProgramController;
            adl.ProgramManager = viewModel.Head.ProgramManager;
            adl.ProtoDate = viewModel.Head.ProtoDate;
            adl.PTRDate = viewModel.Head.PTRDate;
            adl.Recliner = viewModel.Head.Recliner;
            adl.SOPDate = viewModel.Head.SOPDate;
            adl.StartDate = viewModel.Head.StartDate;
            adl.Type = viewModel.Head.Type;
            adl.Tracks = viewModel.Head.Tracks;
            adl.Variant1 = viewModel.Head.Variant1;
            adl.Variant2 = viewModel.Head.Variant2;
            adl.Variant3 = viewModel.Head.Variant3;
            adl.VehicelComments = viewModel.Head.VehicelComments;
            adl.Name = viewModel.Head.Name;
            adl.WBSID = viewModel.Head.WBSID;
            if (viewModel.Head.Phase == EnumPhase.IBP)
            {
                adl.IBPTime = DateTime.Now;
                adl.IBPComments = viewModel.Head.IBPComments;
                adl.IBP = _orchardService.WorkContext.CurrentUser.UserName;
            }
            else if (viewModel.Head.Phase == EnumPhase.Quotation)
            {
                adl.QuotationTime = DateTime.Now;
                adl.QuotationComments = viewModel.Head.QuotationComments;
                adl.Quotation = _orchardService.WorkContext.CurrentUser.UserName;
            }

            adl.Phase = viewModel.Head.NextPhase;
            adl.Status = viewModel.Head.Status;
            adl.EditTime = DateTime.Now;
            adl.Editor = _orchardService.WorkContext.CurrentUser.UserName;
            adl.IsLastest = true;
        }

        private void SetRedirectUrl(ADLViewModel viewModel)
        {
            if (viewModel.Head.Phase == EnumPhase.Creating)
            {
                viewModel.RedirectToHref = Url.Action("Create", "Default", new { Area = "Faurecia.ADL", returnurl = Request["ReturnUrl"], Id = viewModel.Head.Id });
            }
            else if (viewModel.Head.Phase == EnumPhase.Quotation)
            {
                viewModel.RedirectToHref = Url.Action("Quotation", "Default", new { Area = "Faurecia.ADL", returnurl = Request["ReturnUrl"], Id = viewModel.Head.Id });
            }
            else if (viewModel.Head.Phase == EnumPhase.IBP)
            {
                if (viewModel.Head.NextPhase == EnumPhase.ECR)
                {
                    viewModel.RedirectToHref = Url.Action("ECR", "Default", new { Area = "Faurecia.ADL", returnurl = Request["ReturnUrl"], Id = viewModel.Head.Id });
                }
                else
                {
                    viewModel.RedirectToHref = Url.Action("IBP", "Default", new { Area = "Faurecia.ADL", returnurl = Request["ReturnUrl"], Id = viewModel.Head.Id });
                }
            }
            else if (viewModel.Head.Phase == EnumPhase.ECR)
            {
                viewModel.RedirectToHref = Url.Action("ECR", "Default", new { Area = "Faurecia.ADL", returnurl = Request["ReturnUrl"], Id = viewModel.Head.Id });
            }
        }
        private ADLWorkingHourRecord GetWorkingHourRecord(ADLRecord adl,WorkingHourEntry entry,bool isCreateNew)
        {
            ADLWorkingHourRecord record =null;
            if (!isCreateNew)
            {
                record= _adlWorkingHourRecords.Table.Where(w => w.Year == entry.Year && w.ADLRecord.Id == adl.Id).FirstOrDefault();
                //record = _adlWorkingHourRecords.Get(entry.Id);
            }

            if (record == null)
            {
                record = new ADLWorkingHourRecord();
            }
            record.ADLRecord = adl;
            record.Apr = entry.Apr;
            record.Aug = entry.Aug;
            record.Dev = entry.Dev;
            record.Feb = entry.Feb;
            record.Jan = entry.Jan;
            record.Jul = entry.Jul;
            record.Jun = entry.Jun;
            record.Mar = entry.Mar;
            record.May = entry.May;
            record.Nov = entry.Nov;
            record.Oct = entry.Oct;
            record.Sep = entry.Sep;
            record.Year = entry.Year;
            return record;
        }
        private ADLHourRatioRecord GetHourRatioRecord(ADLRecord adl, HourRatioEntry entry, bool isCreateNew)
        {
            ADLHourRatioRecord record = null;
            if (!isCreateNew)
            {
                record = _adlHourRatioRecords.Get(entry.Id);
            }
            if (record == null)
            {
                record = new ADLHourRatioRecord();
            }
            record.ActivityTypeRecord = new ActivityTypeRecord()
            {
                Id=entry.ActivityType.Id
            };
            record.VersionNo = entry.ActivityType.VersionNo;
            record.ADLRecord = adl;
            record.Apr = entry.Apr;
            record.Aug = entry.Aug;
            record.Dev = entry.Dev;
            record.Feb = entry.Feb;
            record.Jan = entry.Jan;
            record.Jul = entry.Jul;
            record.Jun = entry.Jun;
            record.Mar = entry.Mar;
            record.May = entry.May;
            record.Nov = entry.Nov;
            record.Oct = entry.Oct;
            record.Sep = entry.Sep;
            record.Year = entry.Year;
            return record;
        }
        private ADLCostRecord GetCostRecord(ADLRecord adl, CostEntry entry, bool isCreateNew)
        {
            ADLCostRecord record = null;
            if (!isCreateNew)
            {
                record = _adlCostRecords.Get(entry.Id);
            }
            
            if (record == null)
            {
                record = new ADLCostRecord();
            }
            record.ActivityTypeRecord = new ActivityTypeRecord()
            {
                Id = entry.ActivityType.Id
            };
            record.ADLRecord = adl;
            record.Apr = entry.Apr;
            record.Aug = entry.Aug;
            record.Dev = entry.Dev;
            record.Feb = entry.Feb;
            record.Jan = entry.Jan;
            record.Jul = entry.Jul;
            record.Jun = entry.Jun;
            record.Mar = entry.Mar;
            record.May = entry.May;
            record.Nov = entry.Nov;
            record.Oct = entry.Oct;
            record.Sep = entry.Sep;
            record.Year = entry.Year;
            return record;
        }
        private ADLHeadCountRecord GetHeadCountRecord(ADLRecord adl, HeadCountEntry entry, bool isCreateNew)
        {
            ADLHeadCountRecord record = null;
            if (!isCreateNew)
            {
                record = _adlHeadCountRecords.Get(entry.Id);
            }
            
            if (record == null)
            {
                record = new ADLHeadCountRecord();
            }
            record.ActivityTypeRecord = new ActivityTypeRecord()
            {
                Id = entry.ActivityType.Id
            };
            record.ADLRecord = adl;
            record.Apr = entry.Apr;
            record.Aug = entry.Aug;
            record.Dev = entry.Dev;
            record.Feb = entry.Feb;
            record.Jan = entry.Jan;
            record.Jul = entry.Jul;
            record.Jun = entry.Jun;
            record.Mar = entry.Mar;
            record.May = entry.May;
            record.Nov = entry.Nov;
            record.Oct = entry.Oct;
            record.Sep = entry.Sep;
            record.Year = entry.Year;
            return record;
        }

        //GET ShowActivityTypeList
        public ActionResult ShowActivityTypeList(int ADLRecordId,ShowActivityTypeOptions options, PagerParameters pagerParameters)
        {
            var model = GetShowActivityTypeViewModel(ADLRecordId, options, pagerParameters);
            if (pagerParameters!=null && pagerParameters.Page!=null)
            {
                return PartialView("_ActivityTypeQueryResults", model);
            }
            return PartialView("_ActivityTypeList", model);
        }

        public ActionResult QueryActivityTypeResult(int ADLRecordId, ShowActivityTypeOptions options, PagerParameters pagerParameters)
        {
            var model = GetShowActivityTypeViewModel(ADLRecordId, options, pagerParameters);
            return PartialView("_ActivityTypeQueryResults", model);
        }

        public ShowActivityTypeViewModel GetShowActivityTypeViewModel(int ADLRecordId, ShowActivityTypeOptions options, PagerParameters pagerParameters)
        {
            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);
            pager.UpdateTargetId = "activityTypeQueryResults";
            var queries = _activityTypeRecords.Table.Where(w => w.IsUsed == true && w.DisplayGroup==ActivityTypeDisplayGroup.DD);
            if (!string.IsNullOrWhiteSpace(options.SearchText))
            {
                switch (options.Column)
                {
                    case ActivityTypeColumnType.Id:
                        queries = queries.Where(w => w.Id.ToString().Contains(options.SearchText));
                        break;
                    case ActivityTypeColumnType.ActivityType:
                        queries = queries.Where(w => w.ActivityType.Contains(options.SearchText));
                        break;
                    case ActivityTypeColumnType.CostCenter:
                        queries = queries.Where(w => w.CostCenter.Contains(options.SearchText));
                        break;
                    case ActivityTypeColumnType.RMBHour:
                        queries = queries.Where(w => w.RMBHour.Contains(options.SearchText));
                        break;
                    case ActivityTypeColumnType.Comment:
                        queries = queries.Where(w => w.Comment.Contains(options.SearchText));
                        break;
                }
            }
            var pagerShape = New.Pager(pager).TotalItemCount(queries.Count());
            switch (options.Order)
            {
                case ActivityTypeColumnType.Id:
                    queries = queries.OrderBy(u => u.Id);
                    break;
                case ActivityTypeColumnType.ActivityType:
                    queries = queries.OrderBy(u => u.ActivityType);
                    break;
                case ActivityTypeColumnType.CostCenter:
                    queries = queries.OrderBy(u => u.CostCenter);
                    break;
                case ActivityTypeColumnType.RMBHour:
                    queries = queries.OrderBy(u => u.RMBHour);
                    break;
                case ActivityTypeColumnType.Comment:
                    queries = queries.OrderBy(u => u.Comment);
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
            var model = new ShowActivityTypeViewModel()
            {
                ADLRecordId = ADLRecordId,
                ActivityTypes = results.Select(x => new ActivityTypeEntry
                {
                    Id = x.Id,
                    ActivityType = x.ActivityType,
                    RMBHour = x.RMBHour,
                    CostCenter = x.CostCenter,
                    Comment = x.Comment,
                    DisplayGroup=x.DisplayGroup,
                    TotalGroup=x.TotalGroup
                }).ToList(),
                Options = options,
                Pager = pagerShape
            };
            return model;
        }
        
        public ActionResult DeleteDetailRecord(int ADLRecordId,int entryIndex,int year,int activityTypeId)
        {
            var message = string.Empty;
            try
            {
                //删除Head Count Record
                var queriesHC = _adlHeadCountRecords.Table.Where(w =>w.ADLRecord.Id==ADLRecordId && w.ActivityTypeRecord.Id == activityTypeId);
                foreach (var item in queriesHC)
                {
                    _adlHeadCountRecords.Delete(item);
                }
                //删除Hour Ratio Record
                var queriesHR = _adlHourRatioRecords.Table.Where(w => w.ADLRecord.Id == ADLRecordId && w.ActivityTypeRecord.Id == activityTypeId);
                foreach (var item in queriesHR)
                {
                    _adlHourRatioRecords.Delete(item);
                }
                //删除Cost Record
                var queriesCT = _adlCostRecords.Table.Where(w => w.ADLRecord.Id == ADLRecordId && w.ActivityTypeRecord.Id == activityTypeId);
                foreach (var item in queriesCT)
                {
                    _adlCostRecords.Delete(item);
                }
            }
            catch(Exception ex)
            {
                message = ex.Message;
            }
            return Json(new { EntryIndex= entryIndex,Year = year, ActivityTypeId= activityTypeId, Message = message }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetHourRatioRecord(string year,string activityTypeId)
        {
            int nYear = 0;
            int nActivityTypeId = 0;
            int.TryParse(year, out nYear);
            int.TryParse(activityTypeId, out nActivityTypeId);
            var queries = _hourRatioRecords.Table.Where(w => w.Year == nYear && w.ActivityTypeRecord.Id == nActivityTypeId && w.ActivityTypeRecord.IsUsed==true);
            var item = queries.FirstOrDefault();
            if (item == null)
            {
                item = new HourRatioRecord();
            }
            return Json(item,JsonRequestBehavior.AllowGet);
        }

        public string GetProjectNo(string name)
        {
            int currentSeqenceNo = 1;
            var queries = _adlRecords.Table;
            queries = queries.Where(w => w.ProjectNo.StartsWith(name));
            string maxProjectNo = queries.Max(item => item.ProjectNo);
            if (!string.IsNullOrEmpty(maxProjectNo))
            {
                string maxProjectNoSeqenceNo = maxProjectNo.Substring(name.Length, maxProjectNo.Length - name.Length);
                int maxSeqenceNo = 0;
                if (int.TryParse(maxProjectNoSeqenceNo, out maxSeqenceNo))
                {
                    currentSeqenceNo = maxSeqenceNo + 1;
                }
            }
            string currentProjectNo = string.Format("{0}{1}", name, currentSeqenceNo.ToString("00"));
            return currentProjectNo;
        }
        /// <summary>
        /// Add kick off
        /// </summary>
        /// <param name="adlRecordId"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="content"></param>
        public ActionResult AddKickOff(string name,int adlRecordId,int year,int month,string content)
        {
            ADLRecord adl = _adlRecords.Get(adlRecordId);
            if(adl!=null)
            {
                ADLKickOffRecord record = new ADLKickOffRecord()
                {
                    Name=name,
                    ADLRecord=adl,
                    Content=content,
                    Year=year,
                    Month=month,
                    CreateTime=DateTime.Now,
                    Creator=User.Identity.Name
                };
                _adlKickOffRecords.Create(record);
                return  Json(record, JsonRequestBehavior.AllowGet);
            }
            return Json(new ADLKickOffRecord(),JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteKickOff(int recordId)
        {
            ADLKickOffRecord record = _adlKickOffRecords.Get(recordId);
            if (record != null)
            {
                _adlKickOffRecords.Delete(record);
                return Json(new { Id = recordId }, JsonRequestBehavior.AllowGet);
            }
            return Json(new {Id= recordId }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetKickOffs(int adlRecordId, string name,int year, int month)
        {
            var queries = _adlKickOffRecords.Table.Where(w => w.ADLRecord.Id == adlRecordId && w.Name==name && w.Year == year && w.Month == month);
            return Json(queries.ToList(), JsonRequestBehavior.AllowGet);
        }

       
        public ActionResult ExportToExcel(int id)
        {
            var viewModel = new ADLQuotationViewModel()
            {
                Action = EnumActions.New,
                Head = new ADLHeadViewModel(),
                Detail = new ADLDetailViewModel(),
                Message = string.Empty
            };
            var record = _adlRecords.Get(id);
            if (record == null)
            {
                record = new ADLRecord() { VersionNo = 1, Currency = "RMB" };
            }
            SetHeadViewModel(viewModel, record);
            SetYears(viewModel);
            SetDetailViewModel(viewModel, record);
            SetHeadViewModel(viewModel, record);

            //获取所有版本记录。
            var lstRecords = _adlRecords.Table.Where(w => w.ProjectNo == record.ProjectNo).OrderBy(o=>o.VersionNo);


            //创建工作薄。
            IWorkbook wb = new HSSFWorkbook();
            //设置EXCEL格式
            ICellStyle style = wb.CreateCellStyle();
            style.FillForegroundColor = 10;
            //有边框
            style.BorderBottom = BorderStyle.THIN;
            style.BorderLeft = BorderStyle.THIN;
            style.BorderRight = BorderStyle.THIN;
            style.BorderTop = BorderStyle.THIN;
            IFont font = wb.CreateFont();
            font.Boldweight = 10;
            style.SetFont(font);
            ISheet wsVersionHistory = wb.CreateSheet("Version History");
            wsVersionHistory.SetColumnWidth(0, 15 * 256);
            wsVersionHistory.SetColumnWidth(1, 15 * 256);
            wsVersionHistory.SetColumnWidth(2, 20 * 256);
            wsVersionHistory.SetColumnWidth(3, 120 * 256);
            ICellStyle versionHistoryCaptionCellStyle = wb.CreateCellStyle();
            IFont versionHistoryCaptionCellFont = wb.CreateFont();
            versionHistoryCaptionCellFont.FontHeightInPoints = 11;
            versionHistoryCaptionCellFont.FontName = "Arial";
            versionHistoryCaptionCellFont.Underline = 0;
            versionHistoryCaptionCellFont.Boldweight = (short)FontBoldWeight.BOLD;
            versionHistoryCaptionCellStyle.SetFont(versionHistoryCaptionCellFont);
            versionHistoryCaptionCellStyle.FillForegroundColor = IndexedColors.GREY_40_PERCENT.Index;
            versionHistoryCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            versionHistoryCaptionCellStyle.Alignment = HorizontalAlignment.CENTER;
            versionHistoryCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            versionHistoryCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            versionHistoryCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            versionHistoryCaptionCellStyle.BorderRight = BorderStyle.THIN;
            versionHistoryCaptionCellStyle.BorderTop = BorderStyle.THIN;
            versionHistoryCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            versionHistoryCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            versionHistoryCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            versionHistoryCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle versionHistoryRowCellStyle = wb.CreateCellStyle();
            IFont versionHistoryRowCellFont = wb.CreateFont();
            versionHistoryRowCellFont.FontHeightInPoints = 11;
            versionHistoryRowCellFont.FontName = "Arial";
            versionHistoryRowCellFont.Underline = 0;
            versionHistoryRowCellFont.Boldweight = (short)FontBoldWeight.None;
            versionHistoryRowCellStyle.SetFont(versionHistoryRowCellFont);
            versionHistoryRowCellStyle.FillPattern = FillPatternType.NO_FILL;
            versionHistoryRowCellStyle.WrapText = true;
            versionHistoryRowCellStyle.Alignment = HorizontalAlignment.LEFT;
            versionHistoryRowCellStyle.VerticalAlignment = VerticalAlignment.TOP;
            versionHistoryRowCellStyle.BorderBottom = BorderStyle.THIN;
            versionHistoryRowCellStyle.BorderLeft = BorderStyle.THIN;
            versionHistoryRowCellStyle.BorderRight = BorderStyle.THIN;
            versionHistoryRowCellStyle.BorderTop = BorderStyle.THIN;
            versionHistoryRowCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            versionHistoryRowCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            versionHistoryRowCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            versionHistoryRowCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            //版本历史记录
            IRow versionRowHead = wsVersionHistory.CreateRow(0);
            ICell versionCellHeadVersionNo = versionRowHead.CreateCell(0);
            versionCellHeadVersionNo.CellStyle = versionHistoryCaptionCellStyle;
            versionCellHeadVersionNo.SetCellValue("Version");

            ICell versionCellHeadDate = versionRowHead.CreateCell(1);
            versionCellHeadDate.CellStyle = versionHistoryCaptionCellStyle;
            versionCellHeadDate.SetCellValue("Date");

            ICell versionCellHeadOwner = versionRowHead.CreateCell(2);
            versionCellHeadOwner.CellStyle = versionHistoryCaptionCellStyle;
            versionCellHeadOwner.SetCellValue("Owner");

            ICell versionCellHeadComment = versionRowHead.CreateCell(3);
            versionCellHeadComment.CellStyle = versionHistoryCaptionCellStyle;
            versionCellHeadComment.SetCellValue("Comments");

            int versionRowCount = 1;
            foreach(var versionRecord in lstRecords)
            {
                IRow versionRow = wsVersionHistory.CreateRow(versionRowCount);
                ICell versionCellVersionNo = versionRow.CreateCell(0);
                versionCellVersionNo.CellStyle = versionHistoryRowCellStyle;
                versionCellVersionNo.SetCellValue(string.Format("V{0}",versionRecord.VersionNo));

                ICell versionCellDate = versionRow.CreateCell(1);
                versionCellDate.CellStyle = versionHistoryRowCellStyle;
                versionCellDate.SetCellValue(string.Format("{0:yyyy-MM-dd}", versionRecord.CreateTime));

                ICell versionCellOwner = versionRow.CreateCell(2);
                versionCellOwner.CellStyle = versionHistoryRowCellStyle;
                versionCellOwner.SetCellValue(string.Format("{0}", versionRecord.Creator));

                ICell versionCellComment = versionRow.CreateCell(3);
                versionCellComment.CellStyle = versionHistoryRowCellStyle;
                StringBuilder sbComments = new StringBuilder();
                if (!string.IsNullOrEmpty(versionRecord.MileStoneComments))
                {
                    sbComments.Append(versionRecord.MileStoneComments);
                    sbComments.AppendLine();
                }
                if (!string.IsNullOrEmpty(versionRecord.VehicelComments))
                {
                    sbComments.Append(versionRecord.VehicelComments);
                    sbComments.AppendLine();
                }
                if (!string.IsNullOrEmpty(versionRecord.QuotationComments))
                {
                    sbComments.Append(versionRecord.QuotationComments);
                    sbComments.AppendLine();
                }
                if (!string.IsNullOrEmpty(versionRecord.IBPComments))
                {
                    sbComments.Append(versionRecord.IBPComments);
                }
                versionCellComment.SetCellValue(sbComments.ToString());

                versionRowCount++;
            }
            //导出的项目内容。
            ISheet ws = wb.CreateSheet("CONTENT");
            ws.SetColumnWidth(0, 25 * 256);
            ws.SetColumnWidth(1, 25 * 256);
            ws.SetColumnWidth(2, 20 * 256);
            ws.SetColumnWidth(3, 20 * 256);
            ws.SetColumnWidth(4, 5 * 256);
            //ws.SetColumnWidth(5, 15 * 256);
            //ws.SetColumnWidth(6, 15 * 256);
            //ws.SetColumnWidth(7, 15 * 256);
            //TITLE
            IRow titleRow = ws.CreateRow(0);
            ICellStyle titleRowCellStyle = wb.CreateCellStyle();
            IFont titleRowCellFont = wb.CreateFont();
            titleRowCellFont.FontHeightInPoints = 20;
            titleRowCellFont.FontName = "Arial";
            titleRowCellFont.Underline = 1;
            titleRowCellFont.Boldweight = 700;
            titleRowCellStyle.SetFont(titleRowCellFont);
            ICell titleCell= titleRow.CreateCell(0);
            titleCell.CellStyle = titleRowCellStyle;
            titleCell.SetCellValue("FAS PROGRAM GROSS COST MONTHLY REPORT");
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(0, 1, 0, 9));
            //HEAD
            ICellStyle headRowLabelCellStyle = wb.CreateCellStyle();
            IFont headRowLabelCellFont = wb.CreateFont();
            headRowLabelCellFont.FontHeightInPoints = 16;
            headRowLabelCellFont.FontName = "Arial";
            headRowLabelCellFont.Underline = 0;
            headRowLabelCellFont.Boldweight = 700;
            headRowLabelCellStyle.SetFont(headRowLabelCellFont);
            headRowLabelCellStyle.FillForegroundColor = IndexedColors.LIGHT_YELLOW.Index;
            headRowLabelCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            headRowLabelCellStyle.Alignment = HorizontalAlignment.CENTER;
            headRowLabelCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            headRowLabelCellStyle.BorderBottom = BorderStyle.THIN;
            headRowLabelCellStyle.BorderLeft = BorderStyle.THIN;
            headRowLabelCellStyle.BorderRight = BorderStyle.THIN;
            headRowLabelCellStyle.BorderTop = BorderStyle.THIN;
            headRowLabelCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headRowLabelCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headRowLabelCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headRowLabelCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle headRowValueCellStyle = wb.CreateCellStyle();
            IFont headRowValueCellFont = wb.CreateFont();
            headRowValueCellFont.FontHeightInPoints = 12;
            headRowValueCellFont.FontName = "Arial";
            headRowValueCellFont.Underline = 0;
            headRowValueCellFont.Boldweight = 700;
            headRowValueCellStyle.SetFont(headRowValueCellFont);
            headRowValueCellStyle.FillForegroundColor = IndexedColors.BRIGHT_GREEN.Index;
            headRowValueCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            headRowValueCellStyle.Alignment = HorizontalAlignment.CENTER;
            headRowValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            headRowValueCellStyle.BorderBottom = BorderStyle.THIN;
            headRowValueCellStyle.BorderLeft = BorderStyle.THIN;
            headRowValueCellStyle.BorderRight = BorderStyle.THIN;
            headRowValueCellStyle.BorderTop = BorderStyle.THIN;
            headRowValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headRowValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headRowValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headRowValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            int rowNumber = 3;
            int cellNumber = 0;
            IRow headRow = ws.CreateRow(rowNumber);
            ICell cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowLabelCellStyle;
            cell.SetCellValue("Program Name:");
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber+1));

            cellNumber = 2;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowValueCellStyle;
            cell.SetCellValue(string.Format("{0}", viewModel.Head.Name));
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowValueCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 1));

            cellNumber = 4;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowLabelCellStyle;
            cell.SetCellValue("Awarded Date:");
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowLabelCellStyle;
            cell = headRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headRowLabelCellStyle;
            cell = headRow.CreateCell(cellNumber + 3);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            cellNumber = 8;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowValueCellStyle;
            if(viewModel.Head.Award==null)
            {
                cell.SetCellValue(string.Format("{0:yyyy-MM-dd}", viewModel.Head.Award));
            }
            else
            {
                cell.SetCellValue("");
            }
            cell = headRow.CreateCell(cellNumber+1);
            cell.CellStyle = headRowValueCellStyle;
            cell = headRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 2));

            rowNumber = 4;
            cellNumber = 0;
            headRow = ws.CreateRow(rowNumber);
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowLabelCellStyle;
            cell.SetCellValue("Program/Acquisition Manager:");
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 1));

            cellNumber = 2;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowValueCellStyle;
            cell.SetCellValue(string.Format("{0}", viewModel.Head.ProgramManager));
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowValueCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 1));

            cellNumber = 4;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowLabelCellStyle;
            cell.SetCellValue("SOP Date :");
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowLabelCellStyle;
            cell = headRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headRowLabelCellStyle;
            cell = headRow.CreateCell(cellNumber + 3);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            cellNumber = 8;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowValueCellStyle;
            if (viewModel.Head.SOPDate == null)
            {
                cell.SetCellValue(string.Format("{0:yyyy-MM-dd}", viewModel.Head.SOPDate));
            }
            else
            {
                cell.SetCellValue("");
            }
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowValueCellStyle;
            cell = headRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 2));

            rowNumber =5;
            cellNumber = 0;
            headRow = ws.CreateRow(rowNumber);
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowLabelCellStyle;
            cell.SetCellValue("Program Controller:");
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 1));

            cellNumber = 2;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowValueCellStyle;
            cell.SetCellValue(string.Format("{0}", viewModel.Head.ProgramController));
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowValueCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 1));

            cellNumber = 4;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowLabelCellStyle;
            cell.SetCellValue("Currency:");
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowLabelCellStyle;
            cell = headRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headRowLabelCellStyle;
            cell = headRow.CreateCell(cellNumber + 3);
            cell.CellStyle = headRowLabelCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            cellNumber = 8;
            cell = headRow.CreateCell(cellNumber);
            cell.CellStyle = headRowValueCellStyle;
            cell.SetCellValue(string.Format("{0}", viewModel.Head.Currency));
            cell = headRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headRowValueCellStyle;
            cell = headRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headRowValueCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 2));
            //KEY Milestones
            ICellStyle keyMilestonesLabelCellStyle = wb.CreateCellStyle();
            IFont keyMilestonesLabelCellFont = wb.CreateFont();
            keyMilestonesLabelCellFont.FontHeightInPoints = 12;
            keyMilestonesLabelCellFont.FontName = "Arial";
            keyMilestonesLabelCellFont.Underline = 0;
            keyMilestonesLabelCellFont.Boldweight = (short)FontBoldWeight.None;
            keyMilestonesLabelCellStyle.SetFont(keyMilestonesLabelCellFont);
            keyMilestonesLabelCellStyle.FillForegroundColor = IndexedColors.LIGHT_GREEN.Index;
            keyMilestonesLabelCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            keyMilestonesLabelCellStyle.Alignment = HorizontalAlignment.CENTER;
            keyMilestonesLabelCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            keyMilestonesLabelCellStyle.BorderBottom = BorderStyle.THIN;
            keyMilestonesLabelCellStyle.BorderLeft = BorderStyle.THIN;
            keyMilestonesLabelCellStyle.BorderRight = BorderStyle.THIN;
            keyMilestonesLabelCellStyle.BorderTop = BorderStyle.THIN;
            keyMilestonesLabelCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesLabelCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesLabelCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesLabelCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle keyMilestonesValueCellStyle = wb.CreateCellStyle();
            IFont keyMilestonesValueCellFont = wb.CreateFont();
            keyMilestonesValueCellFont.FontHeightInPoints = 10;
            keyMilestonesValueCellFont.FontName = "Arial";
            keyMilestonesValueCellFont.Color = IndexedColors.WHITE.Index;
            keyMilestonesValueCellFont.Underline = 0;
            keyMilestonesValueCellFont.Boldweight = (short)FontBoldWeight.None;
            keyMilestonesValueCellStyle.SetFont(keyMilestonesValueCellFont);
            keyMilestonesValueCellStyle.FillForegroundColor = IndexedColors.GREEN.Index;
            keyMilestonesValueCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            keyMilestonesValueCellStyle.Alignment = HorizontalAlignment.CENTER;
            keyMilestonesValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            keyMilestonesValueCellStyle.BorderBottom = BorderStyle.THIN;
            keyMilestonesValueCellStyle.BorderLeft = BorderStyle.THIN;
            keyMilestonesValueCellStyle.BorderRight = BorderStyle.THIN;
            keyMilestonesValueCellStyle.BorderTop = BorderStyle.THIN;
            keyMilestonesValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            keyMilestonesValueCellStyle.WrapText = true;
            rowNumber = 7;
            cellNumber = 0;
            IRow keyMilestonesRow = ws.CreateRow(rowNumber);
            cell = keyMilestonesRow.CreateCell(cellNumber);
            cell.CellStyle = keyMilestonesLabelCellStyle;
            cell.SetCellValue("KEY Milestones");
            cell = keyMilestonesRow.CreateCell(cellNumber + 1);
            cell.CellStyle = keyMilestonesLabelCellStyle;
            cell = keyMilestonesRow.CreateCell(cellNumber + 2);
            cell.CellStyle = keyMilestonesLabelCellStyle;
            cell = keyMilestonesRow.CreateCell(cellNumber + 3);
            cell.CellStyle = keyMilestonesLabelCellStyle;

            IRow keyMilestonesRow1 = ws.CreateRow(rowNumber+1);
            cell = keyMilestonesRow1.CreateCell(cellNumber);
            cell.CellStyle = keyMilestonesLabelCellStyle;
            cell = keyMilestonesRow1.CreateCell(cellNumber + 1);
            cell.CellStyle = keyMilestonesLabelCellStyle;
            cell = keyMilestonesRow1.CreateCell(cellNumber + 2);
            cell.CellStyle = keyMilestonesLabelCellStyle;
            cell = keyMilestonesRow1.CreateCell(cellNumber + 3);
            cell.CellStyle = keyMilestonesLabelCellStyle;

            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber+1, cellNumber, cellNumber + 3));

            var startYear = viewModel.Years.Min();
            var endYear = viewModel.Years.Max();
            Dictionary<string, string> dicKickOff = new Dictionary<string, string>();
            
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                for (int i = 0; i < 13; i++)
                {
                    dicKickOff.Clear();
                    bool isStartDate = (viewModel.Head.StartDate != null 
                                        && viewModel.Head.StartDate.Value.Year == year 
                                        && viewModel.Head.StartDate.Value.Month == i+1);
                    if (isStartDate)
                    {
                        dicKickOff.Add("Start", T("Start-{0}", viewModel.Head.StartDate.Value.Day).Text);
                    }
                    bool isPTRDate = (viewModel.Head.PTRDate != null 
                        && viewModel.Head.PTRDate.Value.Year == year 
                        && viewModel.Head.PTRDate.Value.Month == i+1);
                    if (isPTRDate)
                    {
                        dicKickOff.Add("PTR", T("PTR-{0}", viewModel.Head.PTRDate.Value.Day).Text);
                    }
                    bool isMockup = (viewModel.Head.Mockup != null 
                        && viewModel.Head.Mockup.Value.Year == year
                        && viewModel.Head.Mockup.Value.Month == i+1);
                    if (isMockup)
                    {
                        dicKickOff.Add("Mockup", T("Mockup-{0}", viewModel.Head.Mockup.Value.Day).Text);
                    }
                    bool isOfferDate = (viewModel.Head.OfferDate != null 
                        && viewModel.Head.OfferDate.Value.Year == year
                        && viewModel.Head.OfferDate.Value.Month == i+1);
                    if (isOfferDate)
                    {
                        dicKickOff.Add("Offer", T("Offer-{0}", viewModel.Head.OfferDate.Value.Day).Text);
                    }
                    bool isAward = (viewModel.Head.Award != null 
                        && viewModel.Head.Award.Value.Year == year
                        && viewModel.Head.Award.Value.Month == i + 1);
                    if (isAward)
                    {
                        dicKickOff.Add("Award", T("Award-{0}", viewModel.Head.Award.Value.Day).Text);
                    }
                    bool isProgramKickOff = (viewModel.Head.ProgramKickOff != null 
                        && viewModel.Head.ProgramKickOff.Value.Year == year
                        && viewModel.Head.ProgramKickOff.Value.Month == i + 1);
                    if (isProgramKickOff)
                    {
                        dicKickOff.Add("Program", T("ProgramKickoff-{0}", viewModel.Head.ProgramKickOff.Value.Day).Text);
                    }
                    bool isProtoDate = (viewModel.Head.ProtoDate != null 
                        && viewModel.Head.ProtoDate.Value.Year == year
                        && viewModel.Head.ProtoDate.Value.Month == i + 1);
                    if (isProtoDate)
                    {
                        dicKickOff.Add("Proto", T("Proto-{0}", viewModel.Head.ProtoDate.Value.Day).Text);
                    }
                    bool isDV = (viewModel.Head.DV != null 
                        && viewModel.Head.DV.Value.Year == year
                        && viewModel.Head.DV.Value.Month == i + 1);
                    if (isDV)
                    {
                        dicKickOff.Add("DV", T("DV-{0}", viewModel.Head.DV.Value.Day).Text);
                    }
                    bool isToolingKickOff = (viewModel.Head.ToolingKickOff != null 
                        && viewModel.Head.ToolingKickOff.Value.Year == year
                        && viewModel.Head.ToolingKickOff.Value.Month == i + 1);
                    if (isToolingKickOff)
                    {
                        dicKickOff.Add("Tooling", T("ToolingKickoff-{0}", viewModel.Head.ToolingKickOff.Value.Day).Text);
                    }
                    bool isPV = (viewModel.Head.PV != null 
                        && viewModel.Head.PV.Value.Year == year
                        && viewModel.Head.PV.Value.Month == i + 1);
                    if (isPV)
                    {
                        dicKickOff.Add("PV", T("PV-{0}", viewModel.Head.PV.Value.Day).Text);
                    }
                    bool isSOPDate = (viewModel.Head.SOPDate != null 
                        && viewModel.Head.SOPDate.Value.Year == year
                        && viewModel.Head.SOPDate.Value.Month == i + 1);
                    if (isSOPDate)
                    {
                        dicKickOff.Add("SOP", T("SOP-{0}", viewModel.Head.SOPDate.Value.Day).Text);
                    }
                    var kickOffCount = 0;
                    StringBuilder kickOffContent = new StringBuilder();
                    foreach(var kickOffKey in dicKickOff.Keys)
                    {
                        kickOffCount++;
                        if (kickOffCount > 3) { break; }
                        kickOffContent.Append(dicKickOff[kickOffKey]);
                        kickOffContent.AppendLine();
                    }
                    cell = keyMilestonesRow.CreateCell(startCol + i);
                    ICell cell1 = keyMilestonesRow1.CreateCell(startCol + i);
                    if (kickOffContent.Length > 0)
                    {
                        kickOffContent.Remove(kickOffContent.Length-1, 1);
                        cell.CellStyle = keyMilestonesValueCellStyle;
                        cell1.CellStyle = keyMilestonesValueCellStyle;
                    }
                    else
                    {
                        cell.CellStyle = keyMilestonesLabelCellStyle;
                        cell1.CellStyle = keyMilestonesLabelCellStyle;
                    }
                    cell.SetCellValue(kickOffContent.ToString());
                    ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, startCol + i, startCol + i));
                }
            }
            //HEAD COUNT
            ICellStyle headCountCaptionCellStyle = wb.CreateCellStyle();
            IFont headCountCaptionCellFont = wb.CreateFont();
            headCountCaptionCellFont.FontHeightInPoints = 11;
            headCountCaptionCellFont.FontName = "Arial";
            headCountCaptionCellFont.Underline = 0;
            headCountCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            headCountCaptionCellStyle.SetFont(headCountCaptionCellFont);
            headCountCaptionCellStyle.FillForegroundColor = IndexedColors.GREY_40_PERCENT.Index;
            headCountCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            headCountCaptionCellStyle.Alignment = HorizontalAlignment.CENTER;
            headCountCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            headCountCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            headCountCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            headCountCaptionCellStyle.BorderRight = BorderStyle.THIN;
            headCountCaptionCellStyle.BorderTop = BorderStyle.THIN;
            headCountCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headCountCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headCountCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headCountCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle headCountValueCellStyle = wb.CreateCellStyle();
            IFont headCountValueCellFont = wb.CreateFont();
            headCountValueCellFont.FontHeightInPoints = 11;
            headCountValueCellFont.FontName = "Arial";
            headCountValueCellFont.Underline = 0;
            headCountValueCellFont.Boldweight = (short)FontBoldWeight.None;
            headCountValueCellStyle.SetFont(headCountValueCellFont);
            headCountValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            headCountValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            headCountValueCellStyle.Alignment = HorizontalAlignment.CENTER;
            headCountValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            headCountValueCellStyle.BorderBottom = BorderStyle.THIN;
            headCountValueCellStyle.BorderLeft = BorderStyle.THIN;
            headCountValueCellStyle.BorderRight = BorderStyle.THIN;
            headCountValueCellStyle.BorderTop = BorderStyle.THIN;
            headCountValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headCountValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headCountValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            headCountValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            rowNumber = 11;
            cellNumber = 0;
            IRow headCountCaptionRow = ws.CreateRow(rowNumber);

            cell = headCountCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = headCountCaptionCellStyle;
            cell.SetCellValue("Comment");

            cell = headCountCaptionRow.CreateCell(cellNumber + 1);
            cell.CellStyle = headCountCaptionCellStyle;
            cell.SetCellValue("RMB/Hour");

            cell = headCountCaptionRow.CreateCell(cellNumber + 2);
            cell.CellStyle = headCountCaptionCellStyle;
            cell.SetCellValue("SAP Cost Center");

            cell = headCountCaptionRow.CreateCell(cellNumber + 3);
            cell.CellStyle = headCountCaptionCellStyle;
            cell.SetCellValue("SAP Activity Type");

            IRow headCountCaptionRow1 = ws.CreateRow(rowNumber + 1);
            cell = headCountCaptionRow1.CreateCell(cellNumber);
            cell.CellStyle = headCountCaptionCellStyle;
            cell = headCountCaptionRow1.CreateCell(cellNumber + 1);
            cell.CellStyle = headCountCaptionCellStyle;
            cell = headCountCaptionRow1.CreateCell(cellNumber + 2);
            cell.CellStyle = headCountCaptionCellStyle;
            cell = headCountCaptionRow1.CreateCell(cellNumber + 3);
            cell.CellStyle = headCountCaptionCellStyle;

            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber, cellNumber));
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber + 1, cellNumber + 1));
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber + 2, cellNumber + 2));
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber + 3, cellNumber + 3));



            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;
                cell = headCountCaptionRow.CreateCell(startCol);
                cell.CellStyle = headCountCaptionCellStyle;
                cell.SetCellValue(string.Format("{0} - HEADCOUNT", year));
                ws.AddMergedRegion(new CellRangeAddress(rowNumber, rowNumber, startCol, endCol));

                for (int i = 0; i < 13; i++)
                {
                    cell = headCountCaptionRow1.CreateCell(startCol + i);
                    cell.CellStyle = headCountValueCellStyle;
                    cell.SetCellValue(GetMonthCaption(i + 1));
                }
            }
            rowNumber = 12;
            cellNumber = 0;
            int rowCount = 0;
            for (int i=0;i<viewModel.Detail.Entries.Count;i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    rowCount = viewModel.Detail.Entries[i].HeadCounts.Count;
                    for (int j=0;j < rowCount; j++)
                    {
                        var hc = viewModel.Detail.Entries[i].HeadCounts[j];

                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo+j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.ActivityType.Comment);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.ActivityType.RMBHour);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.ActivityType.CostCenter);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.ActivityType.ActivityType);

                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Jan??0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo+1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo+1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var hc = viewModel.Detail.Entries[i].HeadCounts[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        cell.SetCellValue(hc.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = headCountValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo+1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo+1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
            }
            var yearTotalFormualStartRowNo = rowNumber+1;
            var yearTotalFormualEndRowNo = yearTotalFormualStartRowNo + rowCount;
            rowNumber = yearTotalFormualEndRowNo + 1;
            IRow hcYearTotalRow = ws.CreateRow(rowNumber);
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;
                for (int i = 0; i < 13; i++)
                {
                    cell = hcYearTotalRow.CreateCell(startCol + i);
                    cell.CellStyle = headCountValueCellStyle;
                    string formual = string.Format("SUM({0}{1}:{2}{3})"
                                        , ToNumberSystem26(startCol + i + 1), yearTotalFormualStartRowNo + 1
                                        , ToNumberSystem26(startCol + i + 1), yearTotalFormualEndRowNo + 1);
                    cell.SetCellFormula(formual);
                }
            }
            //COST
            Dictionary<int, string> dicYearTotalDDFormula = new Dictionary<int, string>();
            Dictionary<int, string> dicYearTotalOtherCTFormula = new Dictionary<int, string>();
            Dictionary<int, string> dicYearTotalMEFormula = new Dictionary<int, string>();
            ICellStyle costCaptionCellStyle = wb.CreateCellStyle();
            IFont costCaptionCellFont = wb.CreateFont();
            costCaptionCellFont.FontHeightInPoints = 11;
            costCaptionCellFont.FontName = "Arial";
            costCaptionCellFont.Underline = 0;
            costCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            costCaptionCellStyle.SetFont(costCaptionCellFont);
            costCaptionCellStyle.FillForegroundColor = IndexedColors.GREY_40_PERCENT.Index;
            costCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            costCaptionCellStyle.Alignment = HorizontalAlignment.CENTER;
            costCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            costCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            costCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            costCaptionCellStyle.BorderRight = BorderStyle.THIN;
            costCaptionCellStyle.BorderTop = BorderStyle.THIN;
            costCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            costCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            costCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            costCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle costValueCellStyle = wb.CreateCellStyle();
            IFont costValueCellFont = wb.CreateFont();
            costValueCellFont.FontHeightInPoints = 11;
            costValueCellFont.FontName = "Arial";
            costValueCellFont.Underline = 0;
            costValueCellFont.Boldweight = (short)FontBoldWeight.None;
            costValueCellStyle.SetFont(costValueCellFont);
            costValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            costValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            costValueCellStyle.Alignment = HorizontalAlignment.CENTER;
            costValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            costValueCellStyle.BorderBottom = BorderStyle.THIN;
            costValueCellStyle.BorderLeft = BorderStyle.THIN;
            costValueCellStyle.BorderRight = BorderStyle.THIN;
            costValueCellStyle.BorderTop = BorderStyle.THIN;
            costValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            costValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            costValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            costValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;


            rowNumber = rowNumber + 2;
            cellNumber = 0;
            IRow costCaptionRow = ws.CreateRow(rowNumber);

            cell = costCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = costCaptionCellStyle;
            cell.SetCellValue("Comment");

            cell = costCaptionRow.CreateCell(cellNumber + 1);
            cell.CellStyle = costCaptionCellStyle;
            cell.SetCellValue("RMB/Hour");

            cell = costCaptionRow.CreateCell(cellNumber + 2);
            cell.CellStyle = costCaptionCellStyle;
            cell.SetCellValue("SAP Cost Center");

            cell = costCaptionRow.CreateCell(cellNumber + 3);
            cell.CellStyle = costCaptionCellStyle;
            cell.SetCellValue("SAP Activity Type");

            IRow costCaptionRow1 = ws.CreateRow(rowNumber + 1);
            cell = costCaptionRow1.CreateCell(cellNumber);
            cell.CellStyle = costCaptionCellStyle;
            cell = costCaptionRow1.CreateCell(cellNumber + 1);
            cell.CellStyle = costCaptionCellStyle;
            cell = costCaptionRow1.CreateCell(cellNumber + 2);
            cell.CellStyle = costCaptionCellStyle;
            cell = costCaptionRow1.CreateCell(cellNumber + 3);
            cell.CellStyle = costCaptionCellStyle;

            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber, cellNumber));
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber + 1, cellNumber + 1));
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber + 2, cellNumber + 2));
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber + 1, cellNumber + 3, cellNumber + 3));
            
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;
                cell = costCaptionRow.CreateCell(startCol);
                cell.CellStyle = costCaptionCellStyle;
                cell.SetCellValue(string.Format("{0} - COST", year));
                ws.AddMergedRegion(new CellRangeAddress(rowNumber, rowNumber, startCol, endCol));

                for (int i = 0; i < 13; i++)
                {
                    cell = costCaptionRow1.CreateCell(startCol + i);
                    cell.CellStyle = costValueCellStyle;
                    cell.SetCellValue(GetMonthCaption(i + 1));
                }
            }
            rowNumber = rowNumber + 1;
            cellNumber = 0;
            rowCount = 0;
            for (int i = 0; i < viewModel.Detail.Entries.Count; i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    rowCount = viewModel.Detail.Entries[i].Costs.Count;
                    for (int j = 0; j < rowCount; j++)
                    {
                        var cost = viewModel.Detail.Entries[i].Costs[j];

                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo + j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.ActivityType.Comment);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.ActivityType.RMBHour);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.ActivityType.CostCenter);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.ActivityType.ActivityType);

                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                        if(cost.ActivityType.TotalGroup==ActivityTypeTotalGroup.DD)
                        {
                            var yearTotalDDFormula = string.Empty;
                            if (dicYearTotalDDFormula.ContainsKey(cost.Year))
                            {
                                yearTotalDDFormula = dicYearTotalDDFormula[cost.Year];
                                yearTotalDDFormula = yearTotalDDFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalDDFormula[cost.Year] = yearTotalDDFormula;
                            }
                            else
                            {
                                yearTotalDDFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalDDFormula.Add(cost.Year, yearTotalDDFormula);
                            }
                        }
                        else if (cost.ActivityType.TotalGroup == ActivityTypeTotalGroup.ME)
                        {
                            var yearTotalMEFormula = string.Empty;
                            if (dicYearTotalMEFormula.ContainsKey(cost.Year))
                            {
                                yearTotalMEFormula = dicYearTotalMEFormula[cost.Year];
                                yearTotalMEFormula = yearTotalMEFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalMEFormula[cost.Year] = yearTotalMEFormula;
                            }
                            else
                            {
                                yearTotalMEFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalMEFormula.Add(cost.Year, yearTotalMEFormula);
                            }
                        }
                        else if (cost.ActivityType.TotalGroup == ActivityTypeTotalGroup.otherCT)
                        {
                            var yearTotalOtherCTFormula = string.Empty;
                            if (dicYearTotalOtherCTFormula.ContainsKey(cost.Year))
                            {
                                yearTotalOtherCTFormula = dicYearTotalOtherCTFormula[cost.Year];
                                yearTotalOtherCTFormula = yearTotalOtherCTFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalOtherCTFormula[cost.Year] = yearTotalOtherCTFormula;
                            }
                            else
                            {
                                yearTotalOtherCTFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalOtherCTFormula.Add(cost.Year, yearTotalOtherCTFormula);
                            }
                        }
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var cost = viewModel.Detail.Entries[i].Costs[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        cell.SetCellValue(cost.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = costValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);

                        if (cost.ActivityType.TotalGroup == ActivityTypeTotalGroup.DD)
                        {
                            var yearTotalDDFormula = string.Empty;
                            if (dicYearTotalDDFormula.ContainsKey(cost.Year))
                            {
                                yearTotalDDFormula = dicYearTotalDDFormula[cost.Year];
                                yearTotalDDFormula = yearTotalDDFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalDDFormula[cost.Year] = yearTotalDDFormula;
                            }
                            else
                            {
                                yearTotalDDFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalDDFormula.Add(cost.Year, yearTotalDDFormula);
                            }
                        }
                        else if (cost.ActivityType.TotalGroup == ActivityTypeTotalGroup.ME)
                        {
                            var yearTotalMEFormula = string.Empty;
                            if (dicYearTotalMEFormula.ContainsKey(cost.Year))
                            {
                                yearTotalMEFormula = dicYearTotalMEFormula[cost.Year];
                                yearTotalMEFormula = yearTotalMEFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalMEFormula[cost.Year] = yearTotalMEFormula;
                            }
                            else
                            {
                                yearTotalMEFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalMEFormula.Add(cost.Year, yearTotalMEFormula);
                            }
                        }
                        else if (cost.ActivityType.TotalGroup == ActivityTypeTotalGroup.otherCT)
                        {
                            var yearTotalOtherCTFormula = string.Empty;
                            if (dicYearTotalOtherCTFormula.ContainsKey(cost.Year))
                            {
                                yearTotalOtherCTFormula = dicYearTotalOtherCTFormula[cost.Year];
                                yearTotalOtherCTFormula = yearTotalOtherCTFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalOtherCTFormula[cost.Year] = yearTotalOtherCTFormula;
                            }
                            else
                            {
                                yearTotalOtherCTFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalOtherCTFormula.Add(cost.Year, yearTotalOtherCTFormula);
                            }
                        }
                    }
                }
            }
            yearTotalFormualStartRowNo = rowNumber + 1;
            yearTotalFormualEndRowNo = yearTotalFormualStartRowNo + rowCount;
            rowNumber = yearTotalFormualEndRowNo + 1;
            int totalCostRowNumber = rowNumber;
            IRow yearTotalRow = ws.CreateRow(rowNumber);
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;
                for (int i = 0; i < 13; i++)
                {
                    cell = yearTotalRow.CreateCell(startCol + i);
                    cell.CellStyle = costValueCellStyle;
                    string formual = string.Format("SUM({0}{1}:{2}{3})"
                                        , ToNumberSystem26(startCol + i + 1), yearTotalFormualStartRowNo + 1
                                        , ToNumberSystem26(startCol + i + 1), yearTotalFormualEndRowNo + 1);
                    cell.SetCellFormula(formual);
                }
            }
            //Total Travel
            ICellStyle travelCaptionCellStyle = wb.CreateCellStyle();
            IFont travelCaptionCellFont = wb.CreateFont();
            travelCaptionCellFont.FontHeightInPoints = 11;
            travelCaptionCellFont.FontName = "Arial";
            travelCaptionCellFont.Underline = 0;
            travelCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            travelCaptionCellStyle.SetFont(travelCaptionCellFont);
            travelCaptionCellStyle.FillForegroundColor = IndexedColors.SKY_BLUE.Index;
            travelCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            travelCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            travelCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            travelCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            travelCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            travelCaptionCellStyle.BorderRight = BorderStyle.THIN;
            travelCaptionCellStyle.BorderTop = BorderStyle.THIN;
            travelCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            travelCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            travelCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            travelCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle travelValueCellStyle = wb.CreateCellStyle();
            IFont travelValueCellFont = wb.CreateFont();
            travelValueCellFont.FontHeightInPoints = 11;
            travelValueCellFont.FontName = "Arial";
            travelValueCellFont.Underline = 0;
            travelValueCellFont.Boldweight = (short)FontBoldWeight.None;
            travelValueCellStyle.SetFont(travelValueCellFont);
            travelValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            travelValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            travelValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            travelValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            travelValueCellStyle.BorderBottom = BorderStyle.THIN;
            travelValueCellStyle.BorderLeft = BorderStyle.THIN;
            travelValueCellStyle.BorderRight = BorderStyle.THIN;
            travelValueCellStyle.BorderTop = BorderStyle.THIN;
            travelValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            travelValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            travelValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            travelValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;


            rowNumber = rowNumber + 2;
            int totalTravelsRowNumber = rowNumber;
            cellNumber = 0;
            Dictionary<int, string> dicYearTotalTravelFormula = new Dictionary<int, string>();
            IRow travelCaptionRow = ws.CreateRow(rowNumber);
            cell = travelCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = travelCaptionCellStyle;
            cell.SetCellValue("Total Travel");
            cell = travelCaptionRow.CreateCell(cellNumber + 1);
            cell.CellStyle = travelCaptionCellStyle;
            cell = travelCaptionRow.CreateCell(cellNumber + 2);
            cell.CellStyle = travelCaptionCellStyle;
            cell = travelCaptionRow.CreateCell(cellNumber + 3);
            cell.CellStyle = travelCaptionCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            rowCount = viewModel.Detail.Entries[0].Travels.Count;
            yearTotalFormualStartRowNo = rowNumber + 1;
            yearTotalFormualEndRowNo = rowNumber + rowCount;
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;

                for (int i = 0; i < 13; i++)
                {
                    cell = travelCaptionRow.CreateCell(startCol + i);
                    cell.CellStyle = travelCaptionCellStyle;
                    string formual = string.Format("SUM({0}{1}:{0}{2})"
                                                    , ToNumberSystem26(startCol + i + 1)
                                                    , yearTotalFormualStartRowNo + 1
                                                    , yearTotalFormualEndRowNo + 1);
                    cell.SetCellFormula(formual);
                }
                var yearTotalTravelFormula = string.Format("{0}{1}", ToNumberSystem26(endCol + 1), rowNumber + 1);
                dicYearTotalTravelFormula.Add(year, yearTotalTravelFormula);
            }
            cellNumber = 0;
            for (int i = 0; i < viewModel.Detail.Entries.Count; i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].Travels[j];

                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo + j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.ActivityType.RMBHour);
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNo + j, rowNo + j, cellNo-3, cellNo));


                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].Travels[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = travelValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
            }
            //DV
            ICellStyle dvCaptionCellStyle = wb.CreateCellStyle();
            IFont dvCaptionCellFont = wb.CreateFont();
            dvCaptionCellFont.FontHeightInPoints = 11;
            dvCaptionCellFont.FontName = "Arial";
            dvCaptionCellFont.Underline = 0;
            dvCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            dvCaptionCellStyle.SetFont(dvCaptionCellFont);
            dvCaptionCellStyle.FillForegroundColor = IndexedColors.SKY_BLUE.Index;
            dvCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            dvCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            dvCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            dvCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            dvCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            dvCaptionCellStyle.BorderRight = BorderStyle.THIN;
            dvCaptionCellStyle.BorderTop = BorderStyle.THIN;
            dvCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            dvCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            dvCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            dvCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle dvValueCellStyle = wb.CreateCellStyle();
            IFont dvValueCellFont = wb.CreateFont();
            dvValueCellFont.FontHeightInPoints = 11;
            dvValueCellFont.FontName = "Arial";
            dvValueCellFont.Underline = 0;
            dvValueCellFont.Boldweight = (short)FontBoldWeight.None;
            dvValueCellStyle.SetFont(dvValueCellFont);
            dvValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            dvValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            dvValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            dvValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            dvValueCellStyle.BorderBottom = BorderStyle.THIN;
            dvValueCellStyle.BorderLeft = BorderStyle.THIN;
            dvValueCellStyle.BorderRight = BorderStyle.THIN;
            dvValueCellStyle.BorderTop = BorderStyle.THIN;
            dvValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            dvValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            dvValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            dvValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;


            rowNumber = rowNumber + rowCount + 1;
            Dictionary<int, string> dicYearTotalDVFormula = new Dictionary<int, string>();
            int totalDVsRowNumber = rowNumber;
            cellNumber = 0;
            IRow dvCaptionRow = ws.CreateRow(rowNumber);
            cell = dvCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = dvCaptionCellStyle;
            cell.SetCellValue("DV");
            cell = dvCaptionRow.CreateCell(cellNumber + 1);
            cell.CellStyle = dvCaptionCellStyle;
            cell = dvCaptionRow.CreateCell(cellNumber + 2);
            cell.CellStyle = dvCaptionCellStyle;
            cell = dvCaptionRow.CreateCell(cellNumber + 3);
            cell.CellStyle = dvCaptionCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            rowCount = viewModel.Detail.Entries[0].DVs.Count;
            yearTotalFormualStartRowNo = rowNumber + 1;
            yearTotalFormualEndRowNo = rowNumber + rowCount;
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;

                for (int i = 0; i < 13; i++)
                {
                    cell = dvCaptionRow.CreateCell(startCol + i);
                    cell.CellStyle = dvCaptionCellStyle;
                    string formual = string.Format("SUM({0}{1}:{0}{2})"
                                                   , ToNumberSystem26(startCol + i + 1)
                                                   , yearTotalFormualStartRowNo + 1
                                                   , yearTotalFormualEndRowNo + 1);
                    cell.SetCellFormula(formual);
                }
                var yearTotalDVFormula = string.Format("{0}{1}", ToNumberSystem26(endCol + 1), rowNumber + 1);
                dicYearTotalDVFormula.Add(year, yearTotalDVFormula);
            }
            cellNumber = 0;
            for (int i = 0; i < viewModel.Detail.Entries.Count; i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].DVs[j];

                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo + j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.ActivityType.RMBHour);
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNo + j, rowNo + j, cellNo - 3, cellNo));


                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].DVs[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = dvValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
            }
            //PV
            ICellStyle pvCaptionCellStyle = wb.CreateCellStyle();
            IFont pvCaptionCellFont = wb.CreateFont();
            pvCaptionCellFont.FontHeightInPoints = 11;
            pvCaptionCellFont.FontName = "Arial";
            pvCaptionCellFont.Underline = 0;
            pvCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            pvCaptionCellStyle.SetFont(pvCaptionCellFont);
            pvCaptionCellStyle.FillForegroundColor = IndexedColors.SKY_BLUE.Index;
            pvCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            pvCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            pvCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            pvCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            pvCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            pvCaptionCellStyle.BorderRight = BorderStyle.THIN;
            pvCaptionCellStyle.BorderTop = BorderStyle.THIN;
            pvCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            pvCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            pvCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            pvCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle pvValueCellStyle = wb.CreateCellStyle();
            IFont pvValueCellFont = wb.CreateFont();
            pvValueCellFont.FontHeightInPoints = 11;
            pvValueCellFont.FontName = "Arial";
            pvValueCellFont.Underline = 0;
            pvValueCellFont.Boldweight = (short)FontBoldWeight.None;
            pvValueCellStyle.SetFont(pvValueCellFont);
            pvValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            pvValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            pvValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            pvValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            pvValueCellStyle.BorderBottom = BorderStyle.THIN;
            pvValueCellStyle.BorderLeft = BorderStyle.THIN;
            pvValueCellStyle.BorderRight = BorderStyle.THIN;
            pvValueCellStyle.BorderTop = BorderStyle.THIN;
            pvValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            pvValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            pvValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            pvValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;


            rowNumber = rowNumber + rowCount +1;
            int totalPVsRowNumber = rowNumber;
            cellNumber = 0;
            IRow pvCaptionRow = ws.CreateRow(rowNumber);
            cell = pvCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = pvCaptionCellStyle;
            cell.SetCellValue("PV");
            cell = pvCaptionRow.CreateCell(cellNumber + 1);
            cell.CellStyle = pvCaptionCellStyle;
            cell = pvCaptionRow.CreateCell(cellNumber + 2);
            cell.CellStyle = pvCaptionCellStyle;
            cell = pvCaptionRow.CreateCell(cellNumber + 3);
            cell.CellStyle = pvCaptionCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            rowCount = viewModel.Detail.Entries[0].PVs.Count;

            Dictionary<int, string> dicYearTotalPVFormula = new Dictionary<int, string>();
            yearTotalFormualStartRowNo = rowNumber + 1;
            yearTotalFormualEndRowNo = rowNumber + rowCount;
            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;

                for (int i = 0; i < 13; i++)
                {
                    cell = pvCaptionRow.CreateCell(startCol + i);
                    cell.CellStyle = pvCaptionCellStyle;
                    string formual = string.Format("SUM({0}{1}:{0}{2})"
                                                   , ToNumberSystem26(startCol + i + 1)
                                                   , yearTotalFormualStartRowNo + 1
                                                   , yearTotalFormualEndRowNo + 1);
                    cell.SetCellFormula(formual);
                }
                var yearTotalPVFormula = string.Format("{0}{1}", ToNumberSystem26(endCol + 1), rowNumber + 1);
                dicYearTotalPVFormula.Add(year, yearTotalPVFormula);
            }

            cellNumber = 0;
            for (int i = 0; i < viewModel.Detail.Entries.Count; i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].PVs[j];

                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo + j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.ActivityType.RMBHour);
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNo + j, rowNo + j, cellNo - 3, cellNo));


                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].PVs[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = pvValueCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
            }
            //External Support							
            ICellStyle externalCaptionCellStyle = wb.CreateCellStyle();
            IFont externalCaptionCellFont = wb.CreateFont();
            externalCaptionCellFont.FontHeightInPoints = 11;
            externalCaptionCellFont.FontName = "Arial";
            externalCaptionCellFont.Underline = 0;
            externalCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            externalCaptionCellStyle.SetFont(externalCaptionCellFont);
            externalCaptionCellStyle.FillForegroundColor = IndexedColors.SKY_BLUE.Index;
            externalCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            externalCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            externalCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            externalCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            externalCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            externalCaptionCellStyle.BorderRight = BorderStyle.THIN;
            externalCaptionCellStyle.BorderTop = BorderStyle.THIN;
            externalCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            externalCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            externalCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            externalCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle externalValueCellStyle = wb.CreateCellStyle();
            IFont externalValueCellFont = wb.CreateFont();
            externalValueCellFont.FontHeightInPoints = 11;
            externalValueCellFont.FontName = "Arial";
            externalValueCellFont.Underline = 0;
            externalValueCellFont.Boldweight = (short)FontBoldWeight.None;
            externalValueCellStyle.SetFont(externalValueCellFont);
            externalValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            externalValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            externalValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            externalValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            externalValueCellStyle.BorderBottom = BorderStyle.THIN;
            externalValueCellStyle.BorderLeft = BorderStyle.THIN;
            externalValueCellStyle.BorderRight = BorderStyle.THIN;
            externalValueCellStyle.BorderTop = BorderStyle.THIN;
            externalValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            externalValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            externalValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            externalValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;


            Dictionary<int, string> dicYearTotalFEAFormula = new Dictionary<int, string>();

            List<int> lstExternalRowNumber = new List<int>();
            rowNumber = rowNumber+rowCount;
            cellNumber = 0;
            rowCount = viewModel.Detail.Entries[0].Externals.Count;
            for (int i = 0; i < viewModel.Detail.Entries.Count; i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].Externals[j];
                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo + j);
                        lstExternalRowNumber.Add(rowNo + j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.ActivityType.RMBHour);
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNo + j, rowNo + j, cellNo - 3, cellNo));


                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);

                        if (item.ActivityType.TotalGroup == ActivityTypeTotalGroup.FEA)
                        {
                            var yearTotalFEAFormula = string.Empty;
                            if (dicYearTotalFEAFormula.ContainsKey(item.Year))
                            {
                                yearTotalFEAFormula = dicYearTotalFEAFormula[item.Year];
                                yearTotalFEAFormula = yearTotalFEAFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalFEAFormula[item.Year] = yearTotalFEAFormula;
                            }
                            else
                            {
                                yearTotalFEAFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalFEAFormula.Add(item.Year, yearTotalFEAFormula);
                            }
                        }
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].Externals[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = externalCaptionCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                        if (item.ActivityType.TotalGroup == ActivityTypeTotalGroup.FEA)
                        {
                            var yearTotalFEAFormula = string.Empty;
                            if (dicYearTotalFEAFormula.ContainsKey(item.Year))
                            {
                                yearTotalFEAFormula = dicYearTotalFEAFormula[item.Year];
                                yearTotalFEAFormula = yearTotalFEAFormula + string.Format("+{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalFEAFormula[item.Year] = yearTotalFEAFormula;
                            }
                            else
                            {
                                yearTotalFEAFormula = string.Format("{0}{1}", ToNumberSystem26(cellNo + 1), rowNo + j + 1);
                                dicYearTotalFEAFormula.Add(item.Year, yearTotalFEAFormula);
                            }
                        }
                    }
                }
            }
            //Gross Cost (R&D) SH						
            ICellStyle grossCaptionCellStyle = wb.CreateCellStyle();
            IFont grossCaptionCellFont = wb.CreateFont();
            grossCaptionCellFont.FontHeightInPoints = 11;
            grossCaptionCellFont.FontName = "Arial";
            grossCaptionCellFont.Underline = 0;
            grossCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            grossCaptionCellStyle.SetFont(grossCaptionCellFont);
            grossCaptionCellStyle.FillForegroundColor =IndexedColors.LIGHT_ORANGE.Index;
            grossCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            grossCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            grossCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            grossCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            grossCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            grossCaptionCellStyle.BorderRight = BorderStyle.THIN;
            grossCaptionCellStyle.BorderTop = BorderStyle.THIN;
            grossCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            grossCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            grossCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            grossCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle grossValueCellStyle = wb.CreateCellStyle();
            IFont grossValueCellFont = wb.CreateFont();
            grossValueCellFont.FontHeightInPoints = 11;
            grossValueCellFont.FontName = "Arial";
            grossValueCellFont.Underline = 0;
            grossValueCellFont.Boldweight = (short)FontBoldWeight.None;
            grossValueCellStyle.SetFont(grossValueCellFont);
            grossValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            grossValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            grossValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            grossValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            grossValueCellStyle.BorderBottom = BorderStyle.THIN;
            grossValueCellStyle.BorderLeft = BorderStyle.THIN;
            grossValueCellStyle.BorderRight = BorderStyle.THIN;
            grossValueCellStyle.BorderTop = BorderStyle.THIN;
            grossValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            grossValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            grossValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            grossValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;


            rowNumber = rowNumber+ rowCount + 1;
            cellNumber = 0;
            IRow grossCaptionRow = ws.CreateRow(rowNumber);
            cell = grossCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = grossCaptionCellStyle;
            cell.SetCellValue("Gross Cost (R&D) SH");
            cell = grossCaptionRow.CreateCell(cellNumber + 1);
            cell.CellStyle = grossCaptionCellStyle;
            cell = grossCaptionRow.CreateCell(cellNumber + 2);
            cell.CellStyle = grossCaptionCellStyle;
            cell = grossCaptionRow.CreateCell(cellNumber + 3);
            cell.CellStyle = grossCaptionCellStyle;
            ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNumber, rowNumber, cellNumber, cellNumber + 3));

            for (int year = startYear; year <= endYear; year++)
            {
                int startCol = cellNumber + 5 + (year - startYear) * 14;
                int endCol = startCol + 12;

                for (int i = 0; i < 13; i++)
                {

                    cell = grossCaptionRow.CreateCell(startCol + i);
                    cell.CellStyle = grossCaptionCellStyle;
                    string formual = string.Format("{0}{1}+", ToNumberSystem26(startCol + i + 1), totalCostRowNumber + 1);
                    formual += string.Format("{0}{1}+", ToNumberSystem26(startCol + i + 1),totalTravelsRowNumber + 1);
                    formual += string.Format("{0}{1}+", ToNumberSystem26(startCol + i + 1),totalPVsRowNumber + 1);
                    formual += string.Format("{0}{1}+", ToNumberSystem26(startCol + i + 1),totalDVsRowNumber + 1);
                    for (int k = 0; k < lstExternalRowNumber.Count; k++)
                    {
                        formual += string.Format("{0}{1}+", ToNumberSystem26(startCol + i + 1),lstExternalRowNumber[k] + 1);
                    }
                    formual = formual.TrimEnd('+');
                    cell.SetCellFormula(formual);
                }
            }
            //Capitalized
            ICellStyle capitalizedCaptionCellStyle = wb.CreateCellStyle();
            IFont capitalizedCaptionCellFont = wb.CreateFont();
            capitalizedCaptionCellFont.FontHeightInPoints = 11;
            capitalizedCaptionCellFont.FontName = "Arial";
            capitalizedCaptionCellFont.Underline = 0;
            capitalizedCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            capitalizedCaptionCellStyle.SetFont(capitalizedCaptionCellFont);
            capitalizedCaptionCellStyle.FillForegroundColor = IndexedColors.ROSE.Index; 
            capitalizedCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            capitalizedCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            capitalizedCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            capitalizedCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            capitalizedCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            capitalizedCaptionCellStyle.BorderRight = BorderStyle.THIN;
            capitalizedCaptionCellStyle.BorderTop = BorderStyle.THIN;
            capitalizedCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            capitalizedCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            capitalizedCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            capitalizedCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle capitalizedValueCellStyle = wb.CreateCellStyle();
            IFont capitalizedValueCellFont = wb.CreateFont();
            capitalizedValueCellFont.FontHeightInPoints = 11;
            capitalizedValueCellFont.FontName = "Arial";
            capitalizedValueCellFont.Underline = 0;
            capitalizedValueCellFont.Boldweight = (short)FontBoldWeight.None;
            capitalizedValueCellStyle.SetFont(capitalizedValueCellFont);
            capitalizedValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            capitalizedValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            capitalizedValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            capitalizedValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            capitalizedValueCellStyle.BorderBottom = BorderStyle.THIN;
            capitalizedValueCellStyle.BorderLeft = BorderStyle.THIN;
            capitalizedValueCellStyle.BorderRight = BorderStyle.THIN;
            capitalizedValueCellStyle.BorderTop = BorderStyle.THIN;
            capitalizedValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            capitalizedValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            capitalizedValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            capitalizedValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            rowCount = viewModel.Detail.Entries[0].Capitalizeds.Count;
            cellNumber = 0;
            for (int i = 0; i < viewModel.Detail.Entries.Count; i++)
            {
                int rowNo = rowNumber + 1;
                int rowCellNo = cellNumber + (i == 0 ? 0 : 5) + i * 14;

                int yearTotalFormualStartCellNo = 0;
                int yearTotalFormualEndCellNo = 0;
                if (i == 0)
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].Capitalizeds[j];

                        int cellNo = rowCellNo;
                        IRow row = ws.CreateRow(rowNo + j);
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.ActivityType.RMBHour);
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        ws.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(rowNo + j, rowNo + j, cellNo - 3, cellNo));


                        cellNo = cellNo + 2;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
                else
                {
                    for (int j = 0; j < rowCount; j++)
                    {
                        var item = viewModel.Detail.Entries[i].Capitalizeds[j];

                        IRow row = ws.GetRow(rowNo + j);
                        int cellNo = rowCellNo;
                        yearTotalFormualStartCellNo = cellNo;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Jan ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Feb ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Mar ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Apr ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.May ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Jun ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Jul ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Aug ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Sep ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Oct ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Nov ?? 0);

                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        cell.SetCellValue(item.Dev ?? 0);
                        yearTotalFormualEndCellNo = cellNo;
                        cellNo = cellNo + 1;
                        cell = row.CreateCell(cellNo);
                        cell.CellStyle = capitalizedCaptionCellStyle;
                        string formual = string.Format("SUM({0}{1}:{2}{3})"
                                            , ToNumberSystem26(yearTotalFormualStartCellNo + 1), rowNo + j + 1
                                            , ToNumberSystem26(yearTotalFormualEndCellNo + 1), rowNo + j + 1);
                        cell.SetCellFormula(formual);
                    }
                }
            }
            //Total Table
            ICellStyle totalCaptionCellStyle = wb.CreateCellStyle();
            IFont totalCaptionCellFont = wb.CreateFont();
            totalCaptionCellFont.FontHeightInPoints = 11;
            totalCaptionCellFont.FontName = "Arial";
            totalCaptionCellFont.Underline = 0;
            totalCaptionCellFont.Boldweight = (short)FontBoldWeight.None;
            totalCaptionCellStyle.SetFont(totalCaptionCellFont);
            totalCaptionCellStyle.FillForegroundColor = IndexedColors.PALE_BLUE.Index;
            totalCaptionCellStyle.FillPattern = FillPatternType.SOLID_FOREGROUND;
            totalCaptionCellStyle.Alignment = HorizontalAlignment.LEFT;
            totalCaptionCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            totalCaptionCellStyle.BorderBottom = BorderStyle.THIN;
            totalCaptionCellStyle.BorderLeft = BorderStyle.THIN;
            totalCaptionCellStyle.BorderRight = BorderStyle.THIN;
            totalCaptionCellStyle.BorderTop = BorderStyle.THIN;
            totalCaptionCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            totalCaptionCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            totalCaptionCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            totalCaptionCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;

            ICellStyle totalValueCellStyle = wb.CreateCellStyle();
            IFont totalValueCellFont = wb.CreateFont();
            totalValueCellFont.FontHeightInPoints = 11;
            totalValueCellFont.FontName = "Arial";
            totalValueCellFont.Underline = 0;
            totalValueCellFont.Boldweight = (short)FontBoldWeight.None;
            totalValueCellStyle.SetFont(totalValueCellFont);
            totalValueCellStyle.FillForegroundColor = IndexedColors.WHITE.Index;
            totalValueCellStyle.FillPattern = FillPatternType.NO_FILL;
            totalValueCellStyle.Alignment = HorizontalAlignment.LEFT;
            totalValueCellStyle.VerticalAlignment = VerticalAlignment.CENTER;
            totalValueCellStyle.BorderBottom = BorderStyle.THIN;
            totalValueCellStyle.BorderLeft = BorderStyle.THIN;
            totalValueCellStyle.BorderRight = BorderStyle.THIN;
            totalValueCellStyle.BorderTop = BorderStyle.THIN;
            totalValueCellStyle.LeftBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            totalValueCellStyle.RightBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            totalValueCellStyle.TopBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            totalValueCellStyle.BottomBorderColor = IndexedColors.GREY_50_PERCENT.Index;
            
            rowNumber = rowNumber + rowCount + 2;
            cellNumber = 3;
            //Actual H	Y2017	Y2018	Y2019	Y2020	Y2021	Total
            IRow totalCaptionRow = ws.CreateRow(rowNumber);
            cell = totalCaptionRow.CreateCell(cellNumber);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellValue("Actual H");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber +(year - startYear)+2;
                cell = totalCaptionRow.CreateCell(col);
                cell.CellStyle = totalCaptionCellStyle;
                cell.SetCellValue(string.Format("{0}",year));
            }
            var totalCol = cellNumber + (endYear - startYear) + 3;
            cell = totalCaptionRow.CreateCell(totalCol);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellValue("Total");

            //Total D&D    0   0   0   0   0   0
            
            rowNumber = rowNumber + 1;
            int yearTotalDDBPStartRow = rowNumber;
            IRow totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellValue("Total D&D");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalValueCellStyle;
                if (dicYearTotalDDFormula.ContainsKey(year))
                {
                    var formula = dicYearTotalDDFormula[year];
                    cell.SetCellFormula(formula);
                }
                else
                {
                    cell.SetCellValue(0);
                }
            }
            cell = totalValueRow.CreateCell(totalCol);
            string totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3),ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total FEA   84  0   0   0   0   84
            rowNumber = rowNumber + 1;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellValue("Total FEA");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalValueCellStyle;
                
                var formula = dicYearTotalFEAFormula[year];
                cell.SetCellFormula(formula);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total DV    42  0   0   0   0   42
            rowNumber = rowNumber + 1;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellValue("Total DV");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalValueCellStyle;
                var formula = dicYearTotalDVFormula[year];
                cell.SetCellFormula(formula);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber+3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total PV    118 0   0   0   0   118
            rowNumber = rowNumber + 1;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellValue("Total PV");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalValueCellStyle;
                var formula = dicYearTotalPVFormula[year];
                cell.SetCellFormula(formula);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total D&D(BP)  244 0   0   0   0   244
            rowNumber = rowNumber + 1;
            int yearTotalDDBPEndRow = rowNumber;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellValue("Total D&D(BP)");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalCaptionCellStyle;
                totalFormual = string.Format("SUM({0}{1}:{0}{2})", ToNumberSystem26(col+1), yearTotalDDBPStartRow+1, yearTotalDDBPEndRow);
                cell.SetCellFormula(totalFormual);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total other CT  0   0   0   0   0   0
            rowNumber = rowNumber + 1;
            int yearTotalCTBPStartRow = rowNumber;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellValue("Total other CT");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalValueCellStyle;
                if (dicYearTotalOtherCTFormula.ContainsKey(year))
                {
                    var formula = dicYearTotalOtherCTFormula[year];
                    cell.SetCellFormula(formula);
                }
                else
                {
                    cell.SetCellValue(0);
                }
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total ME    0   0   0   0   0   0
            rowNumber = rowNumber + 1;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellValue("Total ME");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalValueCellStyle;
                if (dicYearTotalMEFormula.ContainsKey(year))
                {
                    var formula = dicYearTotalMEFormula[year];
                    cell.SetCellFormula(formula);
                }
                else
                {
                    cell.SetCellValue(0);
                }
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalValueCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total CT (BP)0   0   0   0   0   0
            rowNumber = rowNumber + 1;
            int yearTotalCTBPEndRow = rowNumber;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellValue("Total CT (BP)");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalCaptionCellStyle;
                totalFormual = string.Format("SUM({0}{1}:{0}{2})", ToNumberSystem26(col + 1), yearTotalCTBPStartRow + 1, yearTotalCTBPEndRow);
                cell.SetCellFormula(totalFormual);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total travel    11725.95    0   0   0   0   11725.95
            rowNumber = rowNumber + 1;
            int yearTotalTravelEndRow = rowNumber;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellValue("Total travel");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalCaptionCellStyle;
                var yearTotalTravelFormula = dicYearTotalTravelFormula[year];
                cell.SetCellFormula(yearTotalTravelFormula);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellFormula(totalFormual);
            //Total   11969.95    0   0   0   0   11969.95
            rowNumber = rowNumber + 1;
            totalValueRow = ws.CreateRow(rowNumber);
            cell = totalValueRow.CreateCell(cellNumber);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellValue("Total");
            for (int year = startYear; year <= endYear; year++)
            {
                int col = cellNumber + (year - startYear) + 2;
                cell = totalValueRow.CreateCell(col);
                cell.CellStyle = totalCaptionCellStyle;
                totalFormual = string.Format("{0}{1}+{0}{2}+{0}{3}"
                    , ToNumberSystem26(col + 1)
                    , yearTotalDDBPEndRow+1
                    , yearTotalCTBPEndRow+1
                    , yearTotalTravelEndRow+1);
                cell.SetCellFormula(totalFormual);
            }
            cell = totalValueRow.CreateCell(totalCol);
            totalFormual = string.Format("SUM({0}{2}:{1}{2})", ToNumberSystem26(cellNumber + 3), ToNumberSystem26(totalCol), rowNumber+1);
            cell.CellStyle = totalCaptionCellStyle;
            cell.SetCellFormula(totalFormual);

            string fileName = string.Format("{0}{1}{2} D&D cost.xls", record.Customer.ToUpper(), record.ProjectNo, record.VersionNo);
            MemoryStream ms = new MemoryStream();
            wb.Write(ms);
            ms.Flush();
            ms.Position = 0;
            return File(ms, "application/vnd.ms-excel", fileName);
        }

        private string GetMonthCaption(int month)
        {
            //Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec Y1
            switch (month)
            {
                case 1:
                    return "Jan";
                case 2:
                    return "Feb";
                case 3:
                    return "Mar";
                case 4:
                    return "Apr";
                case 5:
                    return "May";
                case 6:
                    return "Jun";
                case 7:
                    return "Jul";
                case 8:
                    return "Aug";
                case 9:
                    return "Sep";
                case 10:
                    return "Oct";
                case 11:
                    return "Nov";
                case 12:
                    return "Dec";
            }
            return "Y1";
        }

        /// <summary>
        /// 将指定的自然数转换为26进制表示。映射关系：[1-26] ->[A-Z]。
        /// </summary>
        /// <param name="n">自然数（如果无效，则返回空字符串）。</param>
        /// <returns>26进制表示。</returns>
        private string ToNumberSystem26(int n)
        {
            string s = string.Empty;
            while (n > 0)
            {
                int m = n % 26;
                if (m == 0) m = 26;
                s = (char)(m + 64) + s;
                n = (n - m) / 26;
            }
            return s;
        }

        /// <summary>
        /// 将指定的26进制表示转换为自然数。映射关系：[A-Z] ->[1-26]。
        /// </summary>
        /// <param name="s">26进制表示（如果无效，则返回0）。</param>
        /// <returns>自然数。</returns>
        private int FromNumberSystem26(string s)
        {
            if (string.IsNullOrEmpty(s)) return 0;
            int n = 0;
            for (int i = s.Length - 1, j = 1; i >= 0; i--, j *= 26)
            {
                char c = Char.ToUpper(s[i]);
                if (c < 'A' || c > 'Z') return 0;
                n += ((int)c - 64) * j;
            }
            return n;
        }

        public ActionResult GetKickOffsByName(int adlRecordId, string name)
        {
            var queries = _adlKickOffRecords.Table.Where(w => w.ADLRecord.Id == adlRecordId && w.Name==name);
            return Json(queries.ToList(), JsonRequestBehavior.AllowGet);
        }

        public int GetKickOffCount(int adlRecordId, int year, int month)
        {
            int count = _adlKickOffRecords.Table.Where(w => w.ADLRecord.Id == adlRecordId && w.Year == year && w.Month == month).Count();
            return count;
        }

        public int GetKickOffCountByName(int adlRecordId, string name)
        {
            int count = _adlKickOffRecords.Table.Where(w => w.ADLRecord.Id == adlRecordId && w.Name==name).Count();
            return count;
        }
    }
}