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
using System.Data;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class HeadCountCompareController : Controller
    {
        private readonly ISiteService _siteService;
        private readonly IAuthorizationService _authorizationService;
        private readonly IRepository<WorkingHourRecord> _workingHourRecords;
        private readonly IRepository<ADLHeadCountRecord> _adlHeadCountRecords;

        public IOrchardServices Services { get; set; }
        public HeadCountCompareController(IOrchardServices orchardService
                        ,ISiteService siteService
                        ,IShapeFactory shapeFactory
                        ,IAuthorizationService authorizationService
                        ,IRepository<WorkingHourRecord> workingHourRecords
                        , IRepository<ADLHeadCountRecord> adlHeadCountRecords)
        {
            Services = orchardService;
            _siteService = siteService;
            _authorizationService = authorizationService;
            _workingHourRecords = workingHourRecords;
            _adlHeadCountRecords = adlHeadCountRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            Shape = shapeFactory;
        }

        dynamic Shape { get; set; }
        public Localizer T { get; set; }
        public ILogger Logger { get; set; }


        // GET: WorkingHour
        public ActionResult Index(string ids)
        {
            if (!Services.Authorizer.Authorize(Faurecia.ADL.Permissions.CompareHeadCount, T("Not authorized to compare head count")))
                return new HttpUnauthorizedResult();
            return View("Index");
        }

        
        public ActionResult GetData(string ids)
        {
            var data = new ChartData();
            IList<int> lstIds = new List<int>();
            if (!string.IsNullOrEmpty(ids))
            {
                foreach (string id in ids.Split(','))
                {
                    int nId = 0;
                    int.TryParse(id, out nId);
                    if (nId != 0)
                    {
                        lstIds.Add(nId);
                    }
                }
            }
            var lnq = from item in _adlHeadCountRecords.Table
                      where lstIds.Contains(item.ADLRecord.Id)
                      select new HeadCountQueryData
                      {
                          Name = string.Format("{0}:{1}",item.ADLRecord.Id,item.ADLRecord.Name),
                          Year = item.Year.ToString(),
                          HeadCount =(item.Jan??0)
                                      + (item.Feb ?? 0)
                                      + (item.May ?? 0)
                                      + (item.Apr ?? 0)
                                      + (item.Mar ?? 0)
                                      + (item.Jun ?? 0) 
                                      + (item.Jul ?? 0) 
                                      + (item.Aug ?? 0)
                                      + (item.Sep ?? 0)
                                      + (item.Oct ?? 0)
                                      + (item.Nov ?? 0) 
                                      + (item.Dev ?? 0)
                      };
            IList<HeadCountQueryData> lst = lnq.ToList();
            data.Categories = lst.Select(item => item.Year).Distinct().OrderBy(o=>o).ToList();
            IList<string> names = lst.Select(item => item.Name).Distinct().OrderBy(o => o).ToList();
            data.Legend = names;
            foreach (var name in names)
            {
                ChartSeriesData seriesData = new ChartSeriesData();
                seriesData.name = name;
                foreach (var category in data.Categories)
                {
                    var sum = lst.Where(w => w.Name == name && w.Year==category).Sum(s=>s.HeadCount);
                    seriesData.data.Add(sum);
                }
                data.Series.Add(seriesData);
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        
    }

    public class HeadCountQueryData
    {
        public string Name { get; set; }
        public string Year { get; set; }
        public double HeadCount { get; set; }
    }
}