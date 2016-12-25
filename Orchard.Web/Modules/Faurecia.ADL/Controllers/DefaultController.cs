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

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class DefaultController : Controller
    {
        private readonly IOrchardServices _orchardService;
        private readonly ISiteService _siteService;
        private readonly IRepository<ADLRecord> _adlRecords;
        public DefaultController(IOrchardServices orchardService,
            ISiteService siteService,
            IShapeFactory shapeFactory,
            IRepository<ADLRecord> adlRecords)
        {
            _siteService = siteService;
            _orchardService = orchardService;
            _adlRecords = adlRecords;
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
            var pager = new Pager(_siteService.GetSiteSettings(),pagerParameters);

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
            return View(model);
        }


        // GET: Create

        public ActionResult Create(int Id = 0)
        {
            ViewBag.Title = T("ADL Create New").Text;
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
                    viewModel.Action = EnumActions.Modify;
                    ViewBag.Title = T("ADL Create Modify").Text;
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("ADL View").Text;
                }
                SetHeadViewModel(viewModel, record);
            }
            return View(viewModel);
        }


        public ActionResult Quotation(int Id=0)
        {
            ViewBag.Title = T("ADL Quotation").Text;
            var viewModel = new ADLQuotationViewModel()
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
                    viewModel.Action = EnumActions.Modify;
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("ADL View").Text;
                }
                SetHeadViewModel(viewModel, record);

                SetYears(viewModel);
                SetActivityTypes(viewModel);
                SetDetailViewModel(viewModel, record);
            }
            return View(viewModel);
        }
        private void SetQuotations(ADLCreateViewModel viewModel)
        {
            viewModel.Quotations = new List<SelectListItem>()
            {
                new SelectListItem() { Text=T("Any Quotation Person").Text,Value="" }
            };
        }

        private void SetIBPs(ADLQuotationViewModel viewModel)
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
            for (int year = startYear; year <= endYear; year++)
            {
                viewModel.Years.Add(year);
                ADLDetailEntry entry = new ADLDetailEntry();
                entry.Year = year;
                viewModel.Detail.Entries.Add(entry);
            }
        }

        private void SetActivityTypes(ADLQuotationViewModel viewModel)
        {
            viewModel.ActivityTypes = new List<ActivityTypeEntry>();
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "Material", CostCenter = "SH13R001", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "Leader engineer", RMBHour = "Product Design Mech", CostCenter = "SH13R001", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "Product Design Mech", CostCenter = "", ActivityType = "HDEVB" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "Leader engineer", RMBHour = "ENG_SPG_Design_Mechanism", CostCenter = "Wuxi 1772R002", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ENG_SPG_Design_Mechanism", CostCenter = "Wuxi 1772R002", ActivityType = "HDEVB" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ENG_SPG_TESTING_Mechanism  Pilot", CostCenter = "Wuxi 1772R006", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ENG_SPG_TESTING_Mechanism", CostCenter = "Wuxi 1772R006", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "Machine", RMBHour = "ENG_SPG_TESTING_Mechanism", CostCenter = "Wuxi 1772R006", ActivityType = "HDEVC" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ENG_SPG_PROTOTYPE_Mechanism", CostCenter = "Wuxi 1772R007", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "Machine", RMBHour = "ENG_SPG_PROTOTYPE_Mechanism", CostCenter = "Wuxi 1772R007", ActivityType = "HDEVC" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ENG_SPG_FEA_Mechanism", CostCenter = "Wuxi 1772R008", ActivityType = "HDEVB" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "EU Support Eng hours", RMBHour = "EU rate", CostCenter = "No", ActivityType = "No" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "PML Mecha", CostCenter = "Wuxi 1772R003", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ME: Press", CostCenter = "Wuxi 1772R004", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ME: Pre-assy", CostCenter = "Wuxi 1772R005", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ME: Laser welding", CostCenter = "Wuxi 1772R006", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ME: Assy line", CostCenter = "Wuxi 1772R007", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "engineer", RMBHour = "ME: Post assy (HDM)", CostCenter = "Wuxi 1772R008", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "PC&L", CostCenter = "SH11A001", ActivityType = "HDEVB" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "Cost Engineering", CostCenter = "SH11F001", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "Program Controller", CostCenter = "SH11F001", ActivityType = "HDEVB" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "ASQ Engineer", CostCenter = "SH11P001", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "Buyer", CostCenter = "SH11P001", ActivityType = "HDEVB" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "Quality Engineer", CostCenter = "SH11Q001", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "Program Manager-Mech", CostCenter = "SH11R003", ActivityType = "HDEVA" });
            viewModel.ActivityTypes.Add(new ActivityTypeEntry() { Comment = "", RMBHour = "Acquisition Manager-Mech", CostCenter = "SH11S002", ActivityType = "HDEVA" });
        }

        private void SetHeadViewModel(ADLViewModel viewModel,ADLRecord adl)
        {
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
            viewModel.Head.VersionNo = adl.VersionNo;
        }

        private void SetDetailViewModel(ADLViewModel viewModel,ADLRecord adl)
        {
            foreach (int year in viewModel.Years)
            {
                ADLDetailEntry entry = viewModel.Detail.Entries.SingleOrDefault(w => w.Year == year);
                if(entry==null) { continue; }
                //HeadCounts

                //HourRatios
                //Costs
                //WorkingHours
                entry.WorkingHours.Add(new WorkingHourEntry()
                {
                    Year = year
                });
            }
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
                if (viewModel.Action == EnumActions.New)
                {
                    Common_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Save ADL({0}) success.", viewModel.Head.ProjectNo).Text;
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
                if (viewModel.Action == EnumActions.New)
                {
                    Common_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    Common_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Confirm ADL({0}) success.", viewModel.Head.ProjectNo).Text;
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
                    viewModel.Head.Phase = EnumPhase.Quotation;
                }
                else if (viewModel.Head.Phase == EnumPhase.Quotation)
                {
                    viewModel.Head.Phase = EnumPhase.IBP;
                }
                else if (viewModel.Head.Phase == EnumPhase.Quotation)
                {
                    viewModel.Head.Status = EnumStatus.Frozen;
                    viewModel.Head.Phase = EnumPhase.IBP;
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
                viewModel.Message = T("Submit ADL({0}) success.", viewModel.Head.ProjectNo).Text;
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

        private ADLRecord Common_CreateNew(ADLViewModel viewModel)
        {
            var adl = _adlRecords.Get(viewModel.Head.Id);
            if (adl != null)
            {
                viewModel.Head.ProjectNo = GetProjectNo(viewModel.Head.Customer);
                viewModel.Head.VersionNo = 1;
            }
            adl = new Models.ADLRecord()
            {
                CreateTime = DateTime.Now,
                Creator = _orchardService.WorkContext.CurrentUser.UserName
            };
            SetADLRecord(adl, viewModel);
            _adlRecords.Create(adl);
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
                return Common_CreateNew(viewModel);
            }
            if (adl != null)
            {
                SetADLRecord(adl, viewModel);
            };
            _adlRecords.Update(adl);
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
            adl.OfferDate = viewModel.Head.OfferDate;
            adl.Phase = viewModel.Head.Phase;
            adl.Status = viewModel.Head.Status;
            adl.ProgramController = viewModel.Head.ProgramController;
            adl.ProgramManager = viewModel.Head.ProgramManager;
            adl.ProtoDate = viewModel.Head.ProtoDate;
            adl.PTRDate = viewModel.Head.PTRDate;
            adl.Quotation = viewModel.Head.Quotation;
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
            adl.EditTime = DateTime.Now;
            adl.Editor = _orchardService.WorkContext.CurrentUser.UserName;
            adl.IsLastest = true;
        }

        public string GetProjectNo(string customer)
        {
            int currentSeqenceNo = 1;
            var queries = _adlRecords.Table;
            queries = queries.Where(w => w.Customer == customer);
            string maxProjectNo = queries.Max(item => item.ProjectNo);
            if (!string.IsNullOrEmpty(maxProjectNo))
            {
                string maxProjectNoSeqenceNo = maxProjectNo.Substring(3, maxProjectNo.Length - 3);
                int maxSeqenceNo = 0;
                if (int.TryParse(maxProjectNoSeqenceNo, out maxSeqenceNo))
                {
                    currentSeqenceNo = maxSeqenceNo + 1;
                }
            }
            string currentProjectNo = string.Format("{0}{1}", customer, currentSeqenceNo.ToString("00000"));
            return currentProjectNo;
        }
    }
}