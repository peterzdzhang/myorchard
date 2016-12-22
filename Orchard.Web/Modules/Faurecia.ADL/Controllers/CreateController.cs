using Faurecia.ADL.Models;
using Faurecia.ADL.ViewModels;
using Orchard;
using Orchard.Core.Contents.Controllers;
using Orchard.Data;
using Orchard.DisplayManagement;
using Orchard.Localization;
using Orchard.Logging;
using Orchard.Settings;
using Orchard.Themes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class CreateController : Controller
    {
        private readonly IOrchardServices _orchardService;
        private readonly ISiteService _siteService;
        private readonly IRepository<ADLRecord> _adlRecords;

        public CreateController(IOrchardServices orchardService,
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

        // GET: Create

        public ActionResult Index(int Id=0)
        {
            ViewBag.Title = T("ADL Create New").Text;
            var viewModel = new ADLCreateViewModel() {
                Action = EnumActions.New,
                Phase=EnumPhase.Creating,
                Status=EnumStatus.Inwork
            };
            var adl = _adlRecords.Get(Id);
            if (adl != null)
            {
                if (adl.IsLastest)
                {
                    viewModel.Action = EnumActions.Modify;
                    ViewBag.Title = T("ADL Create Modify").Text;
                }
                else
                {
                    viewModel.Action = EnumActions.View;
                    ViewBag.Title = T("ADL View").Text;
                }
                viewModel.Id = Id;
                viewModel.Award = adl.Award;
                viewModel.Ballfix = adl.Ballfix;
                viewModel.Currency = adl.Currency;
                viewModel.Customer = adl.Customer;
                viewModel.FrameMaturity = adl.FrameMaturity;
                viewModel.HA = adl.HA;
                viewModel.KEZE = adl.KEZE;
                viewModel.MileStoneComments = adl.MileStoneComments;
                viewModel.Mockup = adl.MockUp;
                viewModel.Name = adl.Name;
                viewModel.OfferDate = adl.OfferDate;
                viewModel.Phase = adl.Phase;
                viewModel.ProgramController = adl.ProgramController;
                viewModel.ProgramManager = adl.ProgramManager;
                viewModel.ProjectNo = adl.ProjectNo;
                viewModel.ProtoDate = adl.ProtoDate;
                viewModel.PTRDate = adl.PTRDate;
                viewModel.Quotation = adl.Quotation;
                viewModel.Recliner = adl.Recliner;
                viewModel.SOPDate = adl.SOPDate;
                viewModel.StartDate = adl.StartDate;
                viewModel.Status = adl.Status;
                viewModel.Tracks = adl.Tracks;
                viewModel.Type = adl.Type;
                viewModel.Variant1 = adl.Variant1;
                viewModel.Variant2 = adl.Variant2;
                viewModel.Variant3 = adl.Variant3;
                viewModel.VehicelComments = adl.VehicelComments;
                viewModel.VersionNo = adl.VersionNo;
            }
            SetQuotations(viewModel);
            return View(viewModel);
        }


        [HttpPost, ActionName("Index")]
        [Orchard.Mvc.FormValueRequired("submit.Save")]
        public ActionResult SavePost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            SetQuotations(viewModel);

            if (ModelState.IsValid)
            {
                if (viewModel.Action == EnumActions.New)
                {
                    SavePost_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    SavePost_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Save ADL({0}) success.", viewModel.ProjectNo).Text;
            }

            return View(viewModel);
        }
        private void SavePost_CreateNew(ADLCreateViewModel viewModel)
        {
            viewModel.Phase = EnumPhase.Creating;
            viewModel.Status = EnumStatus.Inwork;
            Common_CreateNew(viewModel);
        }
        private void SavePost_Modify(ADLCreateViewModel viewModel)
        {
            viewModel.Phase = EnumPhase.Creating;
            viewModel.Status = EnumStatus.Inwork;
            Common_Modify(viewModel);
        }
        private void SetQuotations(ADLCreateViewModel viewModel)
        {
            viewModel.Quotations = new List<SelectListItem>()
            {
                new SelectListItem() { Text=T("Any Quotation Person").Text,Value="" }
            };
        }

        [HttpPost, ActionName("Index")]
        [Orchard.Mvc.FormValueRequired("submit.Confirm")]
        public ActionResult ConfirmPost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            SetQuotations(viewModel);
            if (ModelState.IsValid)
            {
                if (viewModel.Action == EnumActions.New)
                {
                    ConfirmPost_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    ConfirmPost_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Confirm ADL({0}) success.", viewModel.ProjectNo).Text;
            }
            return View(viewModel);
        }
        private void ConfirmPost_CreateNew(ADLCreateViewModel viewModel)
        {
            viewModel.Phase = EnumPhase.Creating;
            viewModel.Status = EnumStatus.Frozen;
            Common_CreateNew(viewModel);
        }
        private void ConfirmPost_Modify(ADLCreateViewModel viewModel)
        {
            viewModel.Phase = EnumPhase.Creating;
            viewModel.Status = EnumStatus.Frozen;
            Common_Modify(viewModel);
        }

        [HttpPost, ActionName("Index")]
        [Orchard.Mvc.FormValueRequired("submit.Submit")]
        public ActionResult SubmitPost()
        {
            var viewModel = new ADLCreateViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {
                if (viewModel.Action == EnumActions.New)
                {
                    SubmitPost_CreateNew(viewModel);
                }
                else if (viewModel.Action == EnumActions.Modify)
                {
                    SubmitPost_Modify(viewModel);
                }
                viewModel.Action = EnumActions.Modify;
                viewModel.Message = T("Submit ADL({0}) success.", viewModel.ProjectNo).Text;
            }
            return RedirectToAction("Index","Default");
        }
        private void SubmitPost_CreateNew(ADLCreateViewModel viewModel)
        {
            viewModel.Phase = EnumPhase.Quotation;
            viewModel.Status = EnumStatus.Inwork;
            Common_CreateNew(viewModel);
        }
        private void SubmitPost_Modify(ADLCreateViewModel viewModel)
        {
            viewModel.Phase = EnumPhase.Quotation;
            viewModel.Status = EnumStatus.Inwork;
            Common_Modify(viewModel);
        }

        private ADLRecord Common_CreateNew(ADLCreateViewModel viewModel)
        {
            var adl = _adlRecords.Get(item => item.ProjectNo == viewModel.ProjectNo
                                               && item.VersionNo == viewModel.VersionNo);
            if (adl != null)
            {
                viewModel.ProjectNo = GetProjectNo(viewModel.Customer);
                viewModel.VersionNo = 1;
            }
            adl = new Models.ADLRecord()
            {
                ProjectNo = viewModel.ProjectNo,
                VersionNo = viewModel.VersionNo,
                Award = viewModel.Award,
                Ballfix = viewModel.Ballfix,
                Currency = viewModel.Currency,
                Customer = viewModel.Customer,
                FrameMaturity = viewModel.FrameMaturity,
                HA = viewModel.HA,
                KEZE = viewModel.KEZE,
                MileStoneComments = viewModel.MileStoneComments,
                MockUp = viewModel.Mockup,
                OfferDate = viewModel.OfferDate,
                Phase = viewModel.Phase,
                Status = viewModel.Status,
                ProgramController = viewModel.ProgramController,
                ProgramManager = viewModel.ProgramManager,
                ProtoDate = viewModel.ProtoDate,
                PTRDate = viewModel.PTRDate,
                Quotation = viewModel.Quotation,
                Recliner = viewModel.Recliner,
                SOPDate = viewModel.SOPDate,
                StartDate = viewModel.StartDate,
                Type = viewModel.Type,
                Tracks = viewModel.Tracks,
                Variant1 = viewModel.Variant1,
                Variant2 = viewModel.Variant2,
                Variant3 = viewModel.Variant3,
                VehicelComments = viewModel.VehicelComments,
                Name = viewModel.Name,
                CreateTime = DateTime.Now,
                Creator = _orchardService.WorkContext.CurrentUser.UserName,
                EditTime = DateTime.Now,
                Editor = _orchardService.WorkContext.CurrentUser.UserName,
                IsLastest = true
            };
            _adlRecords.Create(adl);
            return adl;
        }
        private ADLRecord Common_Modify(ADLCreateViewModel viewModel)
        {
            var adl = _adlRecords.Get(item => item.ProjectNo == viewModel.ProjectNo
                                               && item.VersionNo == viewModel.VersionNo);
            if (adl == null)
            {
                return Common_CreateNew(viewModel);
            }
            //如果状态是冻结，表示已Confirm，需要重新生成新的版本。
            if(adl.Status==EnumStatus.Frozen)
            {
                //获取最新版本号的项目,并更新为非最新版本号。
                adl = _adlRecords.Get(item => item.ProjectNo == viewModel.ProjectNo
                                               && item.IsLastest==true);
                adl.IsLastest = false;
                adl.EditTime = DateTime.Now;
                adl.Editor = _orchardService.WorkContext.CurrentUser.UserName;
                _adlRecords.Update(adl);
                //获取最大版本号，创建一个新的版本号。
                var queries = _adlRecords.Table.Where(w => w.ProjectNo == viewModel.ProjectNo);
                var maxVersionNo = queries.Max(item => item.VersionNo);
                viewModel.VersionNo = maxVersionNo + 1;
                return Common_CreateNew(viewModel);
            }
            if (adl != null)
            {
                adl.Award = viewModel.Award;
                adl.Ballfix = viewModel.Ballfix;
                adl.Currency = viewModel.Currency;
                adl.Customer = viewModel.Customer;
                adl.FrameMaturity = viewModel.FrameMaturity;
                adl.HA = viewModel.HA;
                adl.KEZE = viewModel.KEZE;
                adl.MileStoneComments = viewModel.MileStoneComments;
                adl.MockUp = viewModel.Mockup;
                adl.OfferDate = viewModel.OfferDate;
                adl.Phase = viewModel.Phase;
                adl.Status = viewModel.Status;
                adl.ProgramController = viewModel.ProgramController;
                adl.ProgramManager = viewModel.ProgramManager;
                adl.ProtoDate = viewModel.ProtoDate;
                adl.PTRDate = viewModel.PTRDate;
                adl.Quotation = viewModel.Quotation;
                adl.Recliner = viewModel.Recliner;
                adl.SOPDate = viewModel.SOPDate;
                adl.StartDate = viewModel.StartDate;
                adl.Type = viewModel.Type;
                adl.Tracks = viewModel.Tracks;
                adl.Variant1 = viewModel.Variant1;
                adl.Variant2 = viewModel.Variant2;
                adl.Variant3 = viewModel.Variant3;
                adl.VehicelComments = viewModel.VehicelComments;
                adl.Name = viewModel.Name;
                adl.EditTime = DateTime.Now;
                adl.Editor = _orchardService.WorkContext.CurrentUser.UserName;
                adl.IsLastest = true;
            };
            _adlRecords.Update(adl);
            return adl;
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