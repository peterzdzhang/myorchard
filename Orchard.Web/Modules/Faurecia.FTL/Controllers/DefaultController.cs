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

        public DefaultController(IOrchardServices orchardService,
            ISiteService siteService,
            IShapeFactory shapeFactory,
            IRepository<ProjectRecord> projectRecords)
        {
            _siteService = siteService;
            _orchardService = orchardService;
            _projectRecords = projectRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            New = shapeFactory;
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
    }
}