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
        // GET: Copy
        public ActionResult Copy(int id = 0)
        {
            if (id == 0)
            {
                return View("Index", new CreateIndexViewModel()
                {
                    Head = new FTLHeadViewModel()
                    {
                        Id = 0
                    },
                    ActionName = Actions.Normal
                });
            }
            else
            {
                ProjectRecord record = _projectRecords.Get(id);
                var viewModel = new CreateIndexViewModel()
                {
                    Head = new FTLHeadViewModel()
                    {
                        CreateTime = record.CreateTime,
                        Creator = record.Creator,
                        Customer = record.Customer,
                        Editor = record.Editor,
                        EditTime = record.EditTime,
                        Id = record.Id,
                        Market = record.Market,
                        Mechanism = record.Mechanism,
                        Model = record.Model,
                        Owner = record.Owner,
                        Phase = record.Phase,
                        Product = record.Product,
                        Project = record.Project,
                        Seat = record.Seat,
                        Version = record.Version
                    },
                    ActionName = Actions.Copy
                };
                return View("Index",viewModel);
            }
        }
        // GET: Create
        public ActionResult Index(int id=0)
        {
            if (id == 0)
            {
                return View(new CreateIndexViewModel()
                {
                    Head = new FTLHeadViewModel()
                    {
                        Id = 0
                    },
                    ActionName = Actions.Normal
                });
            }
            else
            {
                ProjectRecord record = _projectRecords.Get(id);
                var viewModel = new CreateIndexViewModel()
                {
                    Head = new FTLHeadViewModel()
                    {
                        CreateTime = record.CreateTime,
                        Creator = record.Creator,
                        Customer = record.Customer,
                        Editor = record.Editor,
                        EditTime = record.EditTime,
                        Id = record.Id,
                        Market = record.Market,
                        Mechanism = record.Mechanism,
                        Model = record.Model,
                        Owner = record.Owner,
                        Phase = record.Phase,
                        Product = record.Product,
                        Project = record.Project,
                        Seat = record.Seat,
                        Version = record.Version
                    },
                    ActionName = Actions.Normal
                };
                return View(viewModel);
            }
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

        private ActionResult Save(Func<CreateIndexViewModel, CreateIndexViewModel> action)
        {
            var viewModel = new CreateIndexViewModel();
            TryUpdateModel(viewModel);
            if (ModelState.IsValid)
            {
                try
                {
                    if (viewModel.Head.Id == 0)
                    {
                        viewModel=Create(viewModel);
                    }
                    else
                    {
                        //更新项目记录
                        viewModel=action(viewModel);
                    }
                    viewModel.Code = 0;
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

        private CreateIndexViewModel Create(CreateIndexViewModel viewModel)
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
                Owner = _orchardService.WorkContext.CurrentUser.UserName,
                Phase = ProjectPhase.GR1,
                Version = "1.0"
            };
            _projectRecords.Create(record);
            _projectRecords.Flush();
            //新增一条版本记录
            ProjectRevisionRecord revisionRecord = new ProjectRevisionRecord()
            {
                CreateTime = DateTime.Now,
                Creator = record.Creator,
                Editor = record.Editor,
                EditTime = DateTime.Now,
                MiniorRevision = record.Version.ToString(),
                Owner = _orchardService.WorkContext.CurrentUser.UserName,
                ProgramPhase = record.Phase,
                ReviewDate = string.Empty,
                ReviewedBy = string.Empty,
                CustomerReleaseDate = string.Empty,
                CustomerSpecificationName = string.Empty,
                Comments = string.Empty,
                Status = ProjectRevisionRecord.StatusInwork,
                ProjectRecord = record
            };
            _projectRevisionRecords.Create(revisionRecord);
            _projectRevisionRecords.Flush();
            viewModel.Head.Id = record.Id;
            viewModel.Message = T("Create project [{0}] successfully.", record.Project).Text;
            return viewModel;
        }

        private CreateIndexViewModel Update(CreateIndexViewModel viewModel)
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
            _projectRecords.Flush();
            viewModel.Head.Id = record.Id;
            viewModel.Message = T("Update project [{0}] successfully.", record.Project).Text;
            return viewModel;
        }

        private CreateIndexViewModel Confirm(CreateIndexViewModel viewModel)
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
            record.Version = IncreaseSubVersion(record.Version);
            _projectRecords.Update(record);
            _projectRecords.Flush();
            //更新所有版本记录为Released
            var lnq = from item in _projectRevisionRecords.Table
                      where item.Status == ProjectRevisionRecord.StatusInwork && item.ProjectRecord.Id == viewModel.Head.Id
                      select item;
            foreach(var item in lnq)
            {
                item.Status = ProjectRevisionRecord.StatusReleased;
                item.Editor = record.Editor;
                item.EditTime = DateTime.Now;
                _projectRevisionRecords.Update(item);
            }
            //新增一条版本记录
            ProjectRevisionRecord revisionRecord = new ProjectRevisionRecord()
            {
                CreateTime = DateTime.Now,
                Creator = record.Creator,
                Editor = record.Editor,
                EditTime = DateTime.Now,
                MiniorRevision = record.Version.ToString(),
                Owner = record.Owner,
                ProgramPhase = record.Phase,
                ReviewDate = string.Empty,
                ReviewedBy = string.Empty,
                CustomerReleaseDate = string.Empty,
                CustomerSpecificationName = string.Empty,
                Comments = string.Empty,
                Status = ProjectRevisionRecord.StatusInwork,
                ProjectRecord=record
            };
            _projectRevisionRecords.Create(revisionRecord);
            _projectRevisionRecords.Flush();

            viewModel.Head.Id = record.Id;
            viewModel.Message = T("Confirm project [{0}] successfully.", record.Project).Text;
            return viewModel;
        }

        private string IncreaseSubVersion(string version="")
        {
            string[] versions = version.Split('.');
            int mainVersion = 1;
            int subVersion = 0;
            if (versions.Length > 0)
            {
                if (!int.TryParse(versions[0], out mainVersion))
                {
                    mainVersion = 1;
                }
            }
            if (versions.Length > 1)
            {
                if (!int.TryParse(versions[1], out subVersion))
                {
                    subVersion = 0;
                }
                subVersion = subVersion + 1;
            }
            return string.Format("{0}.{1}", mainVersion, subVersion);
        }

        private string IncreaseMainVersion(string version = "")
        {
            string[] versions = version.Split('.');
            int mainVersion = 1;
            int subVersion = 0;
            if (versions.Length > 0)
            {
                if (!int.TryParse(versions[0], out mainVersion))
                {
                    mainVersion = 1;
                }
                mainVersion = mainVersion + 1;
            }
            return string.Format("{0}.{1}", mainVersion, subVersion);
        }

        private CreateIndexViewModel Submit(CreateIndexViewModel viewModel)
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
            record.Version = IncreaseMainVersion(record.Version);
            if(record.Phase<ProjectPhase.GR4)
            {
                record.Phase = (ProjectPhase)(record.Phase + 1);
            }
            _projectRecords.Update(record);
            //更新所有版本记录为Released
            var lnq = from item in _projectRevisionRecords.Table
                      where item.Status == ProjectRevisionRecord.StatusInwork && item.ProjectRecord.Id == viewModel.Head.Id
                      select item;
            foreach (var item in lnq)
            {
                item.Status = ProjectRevisionRecord.StatusReleased;
                item.Editor = record.Editor;
                item.EditTime = DateTime.Now;
                _projectRevisionRecords.Update(item);
            }
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
                Status = ProjectRevisionRecord.StatusInwork,
                ProjectRecord = record
            };
            _projectRevisionRecords.Create(revisionRecord);

            viewModel.Head.Id = record.Id;
            viewModel.Message = T("Submit project [{0}] successfully.", record.Project).Text;
            return viewModel;
        }


        public ActionResult GetProjectRevisions(int projectId)
        {
            var lnq = from item in _projectRevisionRecords.Table
                      where item.ProjectRecord.Id == projectId
                      select item;
            var lst = from item in lnq
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
            return Json(JsonConvert.SerializeObject(lst),JsonRequestBehavior.AllowGet);
        }
        
        
        public ActionResult SaveRevisionData()
        {
            return Json(new { Code = 0, Message = "" });
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