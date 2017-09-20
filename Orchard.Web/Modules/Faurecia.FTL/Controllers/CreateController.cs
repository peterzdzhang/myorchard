using Faurecia.FTL.Models;
using Faurecia.FTL.ViewModels;
using Newtonsoft.Json;
using Orchard;
using Orchard.Data;
using Orchard.DisplayManagement;
using Orchard.Localization;
using Orchard.Logging;
using Orchard.Settings;
using Orchard.Themes;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;

namespace Faurecia.FTL.Controllers
{

    [HandleError, Themed]
    public class CreateController : Controller
    {
        private readonly IOrchardServices _orchardService;
        private readonly ISiteService _siteService;
        private readonly IRepository<ProjectRecord> _projectRecords;
        private readonly IRepository<ProjectRevisionRecord> _projectRevisionRecords;
        private readonly IRepository<ProjectRevisionAttachmentRecord> _projectRevisionAttachmentRecords;
        private readonly IRepository<ProjectRevisionContentRecord> _projectContentRecords;
        private readonly IRepository<ProjectRevisionContentAttachmentRecord> _projectRevisionContentAttachmentRecords;
        dynamic New { get; set; }
        public ILogger Logger { get; set; }
        public Localizer T { get; set; }

        public CreateController(IOrchardServices orchardService,
            ISiteService siteService,
            IShapeFactory shapeFactory,
            IRepository<ProjectRecord> projectRecords,
            IRepository<ProjectRevisionRecord> projectRevisionRecords,
            IRepository<ProjectRevisionAttachmentRecord> projectRevisionAttachmentRecords,
            IRepository<ProjectRevisionContentRecord> projectContentRecords,
            IRepository<ProjectRevisionContentAttachmentRecord> projectRevisionContentAttachmentRecords)
        {
            _siteService = siteService;
            _orchardService = orchardService;
            _projectRecords = projectRecords;
            _projectRevisionRecords = projectRevisionRecords;
            _projectRevisionAttachmentRecords = projectRevisionAttachmentRecords;
            _projectContentRecords = projectContentRecords;
            _projectRevisionContentAttachmentRecords = projectRevisionContentAttachmentRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            New = shapeFactory;
        }
        // GET: Create
        public ActionResult Index()
        {
            return View(new CreateIndexViewModel()
            {
              Head=new FTLHeadViewModel()
              {
                   Id=0
              }
            });
        }

        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Save")]
        public ActionResult SavePost()
        {
            return Save(Update);
        }

        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Confirm")]
        public ActionResult ConfirmPost()
        {
            return Save(Confirm);
        }

        [HttpPost, ActionName("Save")]
        [Orchard.Mvc.FormValueRequired("submit.Submit")]
        public ActionResult SubmitPost()
        {
            return Save(Submit);
        }

        private ActionResult Save(Action<CreateIndexViewModel> action)
        {
            var viewModel = new CreateIndexViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {
                try
                {
                    if (viewModel.Head.Id == 0)
                    {
                        Create(viewModel);
                    }
                    else
                    {
                        //更新项目记录
                        action(viewModel);
                    }
                    viewModel.Code = 0;
                    viewModel.Message = string.Empty;
                }
                catch (Exception ex)
                {
                    viewModel.Code = 1;
                    viewModel.Message = ex.Message;
                    Logger.Error(ex, ex.Message);
                }

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

        private void Create(CreateIndexViewModel viewModel)
        {
            //新增一条项目记录
            ProjectRecord record = new ProjectRecord()
            {
                CreateTime = DateTime.Now,
                Creator = _orchardService.WorkContext.CurrentUser.UserName,
                Editor = _orchardService.WorkContext.CurrentUser.UserName,
                EditTime = DateTime.Now,
                Market = viewModel.Head.Market,
                Seat = viewModel.Head.Seat,
                Customer = viewModel.Head.Customer,
                Model = viewModel.Head.Model,
                Product = viewModel.Head.Product,
                Project = viewModel.Head.Project,
                Mechanism = viewModel.Head.Mechanism,
                Owner = string.Empty,
                Phase = ProjectPhase.GR1,
                Version = 1
            };
            _projectRecords.Create(record);
            //新增一条版本记录
            ProjectRevisionRecord revisionRecord = new ProjectRevisionRecord()
            {
                Comments = string.Empty,
                CreateTime = DateTime.Now,
                Creator = record.Creator,
                CustomerReleaseDate = string.Empty,
                CustomerSpecificationName = string.Empty,
                Editor = record.Editor,
                EditTime = DateTime.Now,
                MiniorRevision = record.Version.ToString(),
                Owner = string.Empty,
                ProgramPhase = record.Phase,
                ReviewDate = string.Empty,
                ReviewedBy = string.Empty,
                Status = string.Empty,
                ProjectRecord = record
            };
            _projectRevisionRecords.Create(revisionRecord);
        }

        private void Update(CreateIndexViewModel viewModel)
        {
            //更新项目记录
            ProjectRecord record = _projectRecords.Get(viewModel.Head.Id);
            record.Editor = _orchardService.WorkContext.CurrentUser.UserName;
            record.EditTime = DateTime.Now;
            record.Market = viewModel.Head.Market;
            record.Seat = viewModel.Head.Seat;
            record.Customer = viewModel.Head.Customer;
            record.Model = viewModel.Head.Model;
            record.Product = viewModel.Head.Product;
            record.Project = viewModel.Head.Project;
            record.Mechanism = viewModel.Head.Mechanism;
            _projectRecords.Update(record);
        }

        private void Confirm(CreateIndexViewModel viewModel)
        {
            //更新项目记录
            ProjectRecord record = _projectRecords.Get(viewModel.Head.Id);
            record.Editor = _orchardService.WorkContext.CurrentUser.UserName;
            record.EditTime = DateTime.Now;
            record.Market = viewModel.Head.Market;
            record.Seat = viewModel.Head.Seat;
            record.Customer = viewModel.Head.Customer;
            record.Model = viewModel.Head.Model;
            record.Product = viewModel.Head.Product;
            record.Project = viewModel.Head.Project;
            record.Mechanism = viewModel.Head.Mechanism;
            record.Version = record.Version+1;
            _projectRecords.Update(record);
            //新增一条版本记录
            ProjectRevisionRecord revisionRecord = new ProjectRevisionRecord()
            {
                Comments = string.Empty,
                CreateTime = DateTime.Now,
                Creator = record.Creator,
                CustomerReleaseDate = string.Empty,
                CustomerSpecificationName = string.Empty,
                Editor = record.Editor,
                EditTime = DateTime.Now,
                MiniorRevision = record.Version.ToString(),
                Owner = string.Empty,
                ProgramPhase = record.Phase,
                ReviewDate = string.Empty,
                ReviewedBy = string.Empty,
                Status = string.Empty,
                ProjectRecord = record
            };
            _projectRevisionRecords.Create(revisionRecord);
        }

        private void Submit(CreateIndexViewModel viewModel)
        {
            //更新项目记录
            ProjectRecord record = _projectRecords.Get(viewModel.Head.Id);
            record.Editor = _orchardService.WorkContext.CurrentUser.UserName;
            record.EditTime = DateTime.Now;
            record.Market = viewModel.Head.Market;
            record.Seat = viewModel.Head.Seat;
            record.Customer = viewModel.Head.Customer;
            record.Model = viewModel.Head.Model;
            record.Product = viewModel.Head.Product;
            record.Project = viewModel.Head.Project;
            record.Mechanism = viewModel.Head.Mechanism;
            record.Version = record.Version + 1;
            _projectRecords.Update(record);
            //新增一条版本记录
            ProjectRevisionRecord revisionRecord = new ProjectRevisionRecord()
            {
                Comments = string.Empty,
                CreateTime = DateTime.Now,
                Creator = record.Creator,
                CustomerReleaseDate = string.Empty,
                CustomerSpecificationName = string.Empty,
                Editor = record.Editor,
                EditTime = DateTime.Now,
                MiniorRevision = record.Version.ToString(),
                Owner = string.Empty,
                ProgramPhase = record.Phase,
                ReviewDate = string.Empty,
                ReviewedBy = string.Empty,
                Status = string.Empty,
                ProjectRecord = record
            };
            _projectRevisionRecords.Create(revisionRecord);
        }


        public ActionResult GetProjectRevisions(int projectId)
        {
            IList<ProjectRevisionRecord> lst = new List<ProjectRevisionRecord>();
            lst.Add(new ProjectRevisionRecord()
            {
                Id=0,
                MiniorRevision="1",
                Status=string.Empty,
                ReviewDate="2017-08-14",
                ReviewedBy="test",
                CustomerReleaseDate="",
                CustomerSpecificationName="test",
                ProgramPhase=ProjectPhase.GR1,
                Owner="test",
                Comments="test",
            });

            var lnq = from item in lst
                      select new
                      {
                          MiniorRevision = item.MiniorRevision,
                          Status = item.Status,
                          ReviewDate = item.ReviewDate,
                          ReviewedBy = item.ReviewedBy,
                          CustomerReleaseDate = item.CustomerReleaseDate,
                          CustomerSpecificationName = item.CustomerSpecificationName,
                          ProgramPhase = item.ProgramPhase.ToString(),
                          Owner = item.Owner,
                          Comments = item.Comments
                      };
            return Json(JsonConvert.SerializeObject(lnq),JsonRequestBehavior.AllowGet);
        }


        public ActionResult ExportToExcel(int id)
        {
            ProjectRecord record = _projectRecords.Get(id);
            //创建工作薄。
            IWorkbook wb = new HSSFWorkbook();
            //设置EXCEL格式
            ICellStyle style = wb.CreateCellStyle();
            style.FillForegroundColor = 10;
            //有边框
            style.BorderBottom = BorderStyle.Thin;
            style.BorderLeft = BorderStyle.Thin;
            style.BorderRight = BorderStyle.Thin;
            style.BorderTop = BorderStyle.Thin;
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
            versionHistoryCaptionCellFont.Boldweight = (short)FontBoldWeight.Bold;
            versionHistoryCaptionCellStyle.SetFont(versionHistoryCaptionCellFont);
            versionHistoryCaptionCellStyle.FillForegroundColor = IndexedColors.Grey40Percent.Index;
            versionHistoryCaptionCellStyle.FillPattern = FillPattern.SolidForeground;
            versionHistoryCaptionCellStyle.Alignment = HorizontalAlignment.Center;
            versionHistoryCaptionCellStyle.VerticalAlignment = VerticalAlignment.Center;
            versionHistoryCaptionCellStyle.BorderBottom = BorderStyle.Thin;
            versionHistoryCaptionCellStyle.BorderLeft = BorderStyle.Thin;
            versionHistoryCaptionCellStyle.BorderRight = BorderStyle.Thin;
            versionHistoryCaptionCellStyle.BorderTop = BorderStyle.Thin;
            versionHistoryCaptionCellStyle.LeftBorderColor = IndexedColors.Grey50Percent.Index;
            versionHistoryCaptionCellStyle.RightBorderColor = IndexedColors.Grey50Percent.Index;
            versionHistoryCaptionCellStyle.TopBorderColor = IndexedColors.Grey50Percent.Index;
            versionHistoryCaptionCellStyle.BottomBorderColor = IndexedColors.Grey50Percent.Index;
            ICellStyle versionHistoryRowCellStyle = wb.CreateCellStyle();
            IFont versionHistoryRowCellFont = wb.CreateFont();
            versionHistoryRowCellFont.FontHeightInPoints = 11;
            versionHistoryRowCellFont.FontName = "Arial";
            versionHistoryRowCellFont.Underline = 0;
            versionHistoryRowCellFont.Boldweight = (short)FontBoldWeight.None;
            versionHistoryRowCellStyle.SetFont(versionHistoryRowCellFont);
            versionHistoryRowCellStyle.FillPattern = FillPattern.NoFill;
            versionHistoryRowCellStyle.WrapText = true;
            versionHistoryRowCellStyle.Alignment = HorizontalAlignment.Left;
            versionHistoryRowCellStyle.VerticalAlignment = VerticalAlignment.Top;
            versionHistoryRowCellStyle.BorderBottom = BorderStyle.Thin;
            versionHistoryRowCellStyle.BorderLeft = BorderStyle.Thin;
            versionHistoryRowCellStyle.BorderRight = BorderStyle.Thin;
            versionHistoryRowCellStyle.BorderTop = BorderStyle.Thin;
            versionHistoryRowCellStyle.LeftBorderColor = IndexedColors.Grey50Percent.Index;
            versionHistoryRowCellStyle.RightBorderColor = IndexedColors.Grey50Percent.Index;
            versionHistoryRowCellStyle.TopBorderColor = IndexedColors.Grey50Percent.Index;
            versionHistoryRowCellStyle.BottomBorderColor = IndexedColors.Grey50Percent.Index;

            string fileName = string.Format("FTL-{0} {1}.xls", 
                                            record.Customer,
                                            record.Project);
            MemoryStream ms = new MemoryStream();
            wb.Write(ms);
            ms.Flush();
            ms.Position = 0;
            return File(ms, "application/vnd.ms-excel", fileName);
        }
    }

    
}