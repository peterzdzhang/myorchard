using Faurecia.FTL.Models;
using Faurecia.FTL.ViewModels;
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

namespace Faurecia.FTL.Controllers
{
    [HandleError, Themed]
    public class DefaultController : Controller
    {
        private readonly IOrchardServices _orchardService;
        private readonly ISiteService _siteService;
        private readonly IRepository<ProjectRecord> _projectRecords;
        private readonly IRepository<ProjectRevisionRecord> _projectRevisionRecords;
        private readonly IRepository<ProjectRevisionAttachmentRecord> _projectRevisionAttachmentRecords;
        private readonly IRepository<ProjectRevisionContentRecord> _projectContentRecords;
        private readonly IRepository<ProjectRevisionContentAttachmentRecord> _projectRevisionContentAttachmentRecords;

        public DefaultController(IOrchardServices orchardService,
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
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            New = shapeFactory;
            _projectRecords = projectRecords;
            _projectRevisionRecords = projectRevisionRecords;
            _projectRevisionAttachmentRecords = projectRevisionAttachmentRecords;
            _projectContentRecords = projectContentRecords;
            _projectRevisionContentAttachmentRecords = projectRevisionContentAttachmentRecords;
        }

        dynamic New { get; set; }
        public ILogger Logger { get; set; }
        public Localizer T { get; set; }
        // GET: Default
        public ActionResult Index(ProjectIndexOptions options, PagerParameters pagerParameters)
        {
            if (!_orchardService.Authorizer.Authorize(Faurecia.FTL.Permissions.FTLHome, T("Not authorized to show budget home.")))
                return new HttpUnauthorizedResult();

            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);
            pager.UpdateTargetId = "indexQueryResults";
            if (options == null)
            {
                options = new ProjectIndexOptions();
            }
            var queries = _projectRecords.Table;

            if(!string.IsNullOrWhiteSpace(options.Project))
            {
                queries = queries.Where(w => w.Project.Contains(options.Project));
            }
            if (!string.IsNullOrWhiteSpace(options.Customer))
            {
                queries = queries.Where(w => w.Customer.Contains(options.Customer));
            }
          
            var pagerShape = New.Pager(pager).TotalItemCount(queries.Count());

            switch (options.Order)
            {
                case ProjectOrder.Project:
                    queries = queries.OrderBy(u => u.Project);
                    break;
                case ProjectOrder.Customer:
                    queries = queries.OrderBy(u => u.Customer);
                    break;
                case ProjectOrder.Product:
                    queries = queries.OrderBy(u => u.Product);
                    break;
                case ProjectOrder.CreateTime:
                    queries = queries.OrderBy(u => u.CreateTime);
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
            var model = new DefaultIndexViewModel
            {
                Projects = results.Select(x => new ProjectIndexEntry
                {
                    ProjectRecord = x,
                    Id = x.Id
                }).ToList(),
                Options = options,
                Pager = pagerShape
            };
            // maintain previous route data when generating page links
            var routeData = new RouteData();
            routeData.Values.Add("Options.Filter", options.Filter);
            routeData.Values.Add("Options.Project", options.Project);
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

        //删除
        public ActionResult Delete()
        {
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
                            foreach (var item in _projectRevisionRecords.Table.Where(w => w.ProjectRecord.Id == nId))
                            {
                                foreach (var attachment in _projectRevisionAttachmentRecords.Table.Where(w => w.ProjectRevisionRecord.Id == item.Id))
                                {
                                    if(System.IO.File.Exists(attachment.Path))
                                    {
                                        System.IO.File.Delete(attachment.Path);
                                    }
                                    _projectRevisionAttachmentRecords.Delete(attachment);
                                }
                                foreach (var contentItem in _projectContentRecords.Table.Where(w => w.ProjectRevisionRecord.Id == item.Id))
                                {
                                    foreach (var attachment in _projectRevisionContentAttachmentRecords.Table.Where(w => w.ProjectRevisionContentRecord.Id == contentItem.Id))
                                    {
                                        if (System.IO.File.Exists(attachment.Path))
                                        {
                                            System.IO.File.Delete(attachment.Path);
                                        }
                                        _projectRevisionContentAttachmentRecords.Delete(attachment);
                                    }
                                    _projectContentRecords.Delete(contentItem);
                                }

                                _projectRevisionRecords.Delete(item);
                            }
                            _projectRecords.Delete(new ProjectRecord() { Id = nId });
                        }
                    }
                }
                catch (Exception ex)
                {
                    return Json(new { Code = 1, Message = T("Delete Failed: ") + ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            return Json(new { Code = 0, Message = T("Delete Success.") }, JsonRequestBehavior.AllowGet);
        }
    }
}