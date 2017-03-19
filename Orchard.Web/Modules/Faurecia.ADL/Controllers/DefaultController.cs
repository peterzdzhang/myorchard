using Faurecia.ADL.Models;
using Faurecia.ADL.ViewModels;
using Newtonsoft.Json;
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
using System.Linq;
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
            string currentProjectNo = string.Format("{0}{1}", name, currentSeqenceNo.ToString("0000"));
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