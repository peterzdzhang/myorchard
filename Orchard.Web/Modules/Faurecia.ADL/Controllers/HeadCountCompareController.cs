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
        private readonly IRepository<HeadCountRecord> _headCountRecords;
        private readonly IRepository<ADLHeadCountRecord> _adlHeadCountRecords;

        public IOrchardServices Services { get; set; }
        public HeadCountCompareController(IOrchardServices orchardService
                        ,ISiteService siteService
                        ,IShapeFactory shapeFactory
                        ,IAuthorizationService authorizationService
                        ,IRepository<HeadCountRecord> headCountRecords
                        , IRepository<ADLHeadCountRecord> adlHeadCountRecords)
        {
            Services = orchardService;
            _siteService = siteService;
            _authorizationService = authorizationService;
            _headCountRecords = headCountRecords;
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
        
        public ActionResult GetData(string ids,string type,string year)
        {
            
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
            var data = (type == "Year") ? GetYearChartData(lstIds) : GetMonthChartData(lstIds,year);
            
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        

        private ChartData GetYearChartData(IList<int> lstIds)
        {
            var data = new ChartData();
            var lnq = from item in _adlHeadCountRecords.Table
                      where lstIds.Contains(item.ADLRecord.Id)
                      select new HeadCountYearQueryData
                      {
                          Name = string.Format("{0}.{1}", item.ADLRecord.ProjectNo, item.ADLRecord.VersionNo),
                          Year = item.Year.ToString(),
                          HeadCount = (item.Jan ?? 0)
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
            IList<HeadCountYearQueryData> lst = lnq.ToList();
            data.Categories = lst.Select(item => item.Year).Distinct().OrderBy(o => o).ToList();
            IList<string> names = lst.Select(item => item.Name).Distinct().OrderBy(o => o).ToList();
            foreach (var name in names)
            {
                data.Legend.Add(name);
                ChartSeriesData seriesData = new ChartSeriesData();
                seriesData.name = name;
                //seriesData.stack = "Project";
                foreach (var category in data.Categories)
                {
                    var sum = lst.Where(w => w.Name == name && w.Year == category).Sum(s => s.HeadCount);
                    seriesData.data.Add(sum);
                }
                data.Series.Add(seriesData);
            }
            Sum(data);

            var lnqHeadCount = _headCountRecords.Table.Where(w => w.IsUsed == true);
            ChartSeriesData seriesDataHeadCount = new ChartSeriesData();
            data.Legend.Add(T("Base").Text);
            seriesDataHeadCount.name = T("Base").Text;
            foreach (var category in data.Categories)
            {
                var year = 0;
                int.TryParse(category, out year);
                if (year == 0) continue;
                var item = lnqHeadCount.Where(w => w.Year == year).FirstOrDefault();
                var sum = 0.0;
                if (item != null)
                {
                    sum = (item.Jan ?? 0)
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
                                     + (item.Dev ?? 0);
                }
                seriesDataHeadCount.data.Add(sum);
            }
            data.Series.Add(seriesDataHeadCount);
            return data;
        }


        private ChartData GetMonthChartData(IList<int> lstIds,string nyear)
        {
            var data = new ChartData();
            IList<HeadCountMonthQueryData> lst;

            if (string.IsNullOrEmpty(nyear))
            {
                var lnq = from item in _adlHeadCountRecords.Table
                          where lstIds.Contains(item.ADLRecord.Id)
                          select new HeadCountMonthQueryData
                          {
                              Name = string.Format("{0}.{1}", item.ADLRecord.ProjectNo, item.ADLRecord.VersionNo),
                              Year = item.Year.ToString(),
                              Jan = (item.Jan ?? 0),
                              Feb = (item.Feb ?? 0),
                              May = (item.May ?? 0),
                              Apr = (item.Apr ?? 0),
                              Mar = (item.Mar ?? 0),
                              Jun = (item.Jun ?? 0),
                              Jul = (item.Jul ?? 0),
                              Aug = (item.Aug ?? 0),
                              Sep = (item.Sep ?? 0),
                              Oct = (item.Oct ?? 0),
                              Nov = (item.Nov ?? 0),
                              Dev = (item.Dev ?? 0)
                          };


                lst = lnq.ToList();
            }
            else
            {
                var lnq = from item in _adlHeadCountRecords.Table
                          where lstIds.Contains(item.ADLRecord.Id) && item.Year==Convert.ToInt32(nyear)
                          select new HeadCountMonthQueryData
                          {
                              Name = string.Format("{0}.{1}", item.ADLRecord.ProjectNo, item.ADLRecord.VersionNo),
                              Year = item.Year.ToString(),
                              Jan = (item.Jan ?? 0),
                              Feb = (item.Feb ?? 0),
                              May = (item.May ?? 0),
                              Apr = (item.Apr ?? 0),
                              Mar = (item.Mar ?? 0),
                              Jun = (item.Jun ?? 0),
                              Jul = (item.Jul ?? 0),
                              Aug = (item.Aug ?? 0),
                              Sep = (item.Sep ?? 0),
                              Oct = (item.Oct ?? 0),
                              Nov = (item.Nov ?? 0),
                              Dev = (item.Dev ?? 0)
                          };


                lst = lnq.ToList();
            }

            IList<string> lstYears = lst.Select(item => item.Year).Distinct().OrderBy(o => o).ToList();
            foreach (var year in lstYears)
            {
                for (var month = 1; month <= 12; month++)
                {
                    data.Categories.Add(string.Format("{0}{1}", year, month.ToString("00")));
                }
            }
            IList<string> names = lst.Select(item => item.Name).Distinct().OrderBy(o => o).ToList();
            foreach (var name in names)
            {
                data.Legend.Add(name);
                ChartSeriesData seriesData = new ChartSeriesData();
                seriesData.name = name;
                //seriesData.stack = "Project";
                foreach (var year in lstYears)
                {
                    var jan = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Jan);
                    seriesData.data.Add(jan);
                    var feb = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Feb);
                    seriesData.data.Add(feb);
                    var may = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.May);
                    seriesData.data.Add(may);
                    var apr = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Apr);
                    seriesData.data.Add(apr);
                    var mar = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Mar);
                    seriesData.data.Add(mar);
                    var jun = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Jun);
                    seriesData.data.Add(jun);
                    var jul = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Jul);
                    seriesData.data.Add(jul);
                    var aug = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Aug);
                    seriesData.data.Add(aug);
                    var sep = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Sep);
                    seriesData.data.Add(sep);
                    var oct = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Oct);
                    seriesData.data.Add(oct);
                    var nov = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Nov);
                    seriesData.data.Add(nov);
                    var dev = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Dev);
                    seriesData.data.Add(dev);
                }
                data.Series.Add(seriesData);
            }
            Sum(data);

            var lnqHeadCount = _headCountRecords.Table.Where(w => w.IsUsed == true);
            ChartSeriesData seriesDataHeadCount = new ChartSeriesData();
            data.Legend.Add(T("Base").Text);
            seriesDataHeadCount.name = T("Base").Text;
            foreach (var year in lstYears)
            {
                var item = lnqHeadCount.Where(w => w.Year == Convert.ToInt32(year)).FirstOrDefault();
                seriesDataHeadCount.data.Add(item==null?0:(item.Jan ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Feb ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.May ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Apr ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Mar ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Jun ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Jul ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Aug ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Sep ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Oct ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Nov ?? 0));
                seriesDataHeadCount.data.Add(item == null ? 0 : (item.Dev ?? 0));
            }
            data.Series.Add(seriesDataHeadCount);
            return data;
        }

        private void Sum(ChartData data)
        {
            string sumLegendName = string.Empty;
            foreach(var name in data.Legend)
            {
                sumLegendName +=string.Format("+{0}", name);
            }
            sumLegendName = sumLegendName.Trim('+');
            data.Legend.Add(sumLegendName);

            ChartSeriesData seriesData = new ChartSeriesData();
            seriesData.name = sumLegendName;
            for (int i = 0; i < data.Categories.Count; i++)
            {
                double sum = 0.0;
                foreach (var item in data.Series)
                {
                    sum += item.data[i];
                }
                seriesData.data.Add(sum);
            }
            data.Series.Add(seriesData);
        }
    }


    public class HeadCountYearQueryData
    {
        public string Name { get; set; }
        public string Year { get; set; }
        public double HeadCount { get; set; }
    }


    public class HeadCountMonthQueryData
    {
        public string Name { get; set; }
        public string Year { get; set; }
        public double Jan { get; set; }
        public double Feb { get; set; }
        public double May { get; set; }
        public double Apr { get; set; }
        public double Mar { get; set; }
        public double Jun { get; set; }
        public double Jul { get; set; }
        public double Aug { get; set; }
        public double Sep { get; set; }
        public double Oct { get; set; }
        public double Nov { get; set; }
        public double Dev { get; set; }
    }


}