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
using System.Data.Common;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class CostCompareController : Controller
    {
        private readonly ISiteService _siteService;
        private readonly IAuthorizationService _authorizationService;
        private readonly IRepository<ADLCostRecord> _adlCostRecords;
        private readonly IRepository<ActualCostRecord> _actualCostRecords;
        public IOrchardServices Services { get; set; }
        public CostCompareController(IOrchardServices orchardService
                        , ISiteService siteService
                        , IShapeFactory shapeFactory
                        , IAuthorizationService authorizationService
                        , IRepository<ADLCostRecord> adlCostRecords
                        , IRepository<ActualCostRecord> actualCostRecords)
        {
            Services = orchardService;
            _siteService = siteService;
            _authorizationService = authorizationService;
            _adlCostRecords = adlCostRecords;
            _actualCostRecords = actualCostRecords;
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
            //if (!Services.Authorizer.Authorize(Faurecia.ADL.Permissions.CompareHeadCount, T("Not authorized to compare head count")))
            //    return new HttpUnauthorizedResult();
            return View("Index");
        }

        public ActionResult UploadFile(HttpPostedFileBase costFile)
        {
            try
            {
                if (costFile == null)
                {
                    return Json(new { Code = 0, Message = string.Empty }, JsonRequestBehavior.AllowGet);
                }

                if (costFile != null && costFile.ContentLength > 10)
                {
                    if (!costFile.FileName.EndsWith(".xls") && !costFile.FileName.EndsWith(".xlsx"))
                    {
                        return Json(new { Code = 1, Message = T("No excel file (.xls or .xlsx),please check!").Text }, JsonRequestBehavior.AllowGet);
                    }
                    var fileName = System.IO.Path.GetFileNameWithoutExtension(costFile.FileName);
                    var index = fileName.LastIndexOf("-");
                    var yearMonth = string.Empty;
                    if (index > 0)
                    {
                        yearMonth = fileName.Substring(index + 1, fileName.Length - (index+1)).Trim();
                    }
                    if (string.IsNullOrEmpty(yearMonth))
                    {
                        return Json(new { Code = 1, Message = T("File name don't match（\"xxxx-yyyyMM.xlsx)\" format,please check!").Text }, JsonRequestBehavior.AllowGet);
                    }
                    string filePath = Server.MapPath(string.Format("~/UploadFiles/{0}", Guid.NewGuid().ToString()));
                    if (!System.IO.Directory.Exists(filePath))
                    {
                        System.IO.Directory.CreateDirectory(filePath);
                    }
                    string fileFullPath = System.IO.Path.Combine(filePath, costFile.FileName);
                    if (System.IO.File.Exists(fileFullPath))
                    {
                        System.IO.File.Delete(fileFullPath);
                    }
                    costFile.SaveAs(fileFullPath);
                    SaveRealCostData(yearMonth, fileFullPath);
                }
                return Json(new { Code = 0, Message = T("Upload Success.").Text }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Logger.Error(ex, ex.Message);
                return Json(new { Code = 2, Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        private void SaveRealCostData(string yearMonth, string fileFullPath)
        {
            string sql = "SELECT \"WBS Element\" AS WBSElement, \"Value in Obj# Crcy\" AS CostValue FROM [Sheet1$] WHERE \"WBS Element\" <> '' AND \"WBS Element\" IS NOT NULL";
            string connectionString = string.Format("Driver={{Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)}};Dbq={0};", fileFullPath);
            //创建数据库连接对象。
            IList<ActualCostUploadData> lst = new List<ActualCostUploadData>();
            using (DbConnection con = new System.Data.Odbc.OdbcConnection(connectionString))
            {
                con.Open();
                using (DbCommand cmd = con.CreateCommand())
                {
                    //从Access数据库获取指定组件的数据。
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = sql;
                    IDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string wbsElement = Convert.ToString(dr[0]);
                        string val = Convert.ToString(dr[1]);
                        double cost = 0;
                        if (double.TryParse(val, out cost) == false)
                        {
                            continue;
                        }
                        lst.Add(new ActualCostUploadData()
                        {
                            WBSElement=wbsElement,
                            CostValue= cost
                        });
                    }
                }
                con.Close();
            }

            var lnq = from item in lst
                      group item by item.WBSElement into g
                      select new { WBSElement=g.Key, CostValue = g.Sum(item=>item.CostValue) };

            foreach (var u in lnq)
            {
                var qry = _actualCostRecords.Table.Where(w => w.WBSElement ==u.WBSElement && w.YearMonth == yearMonth);
                var item = qry.FirstOrDefault();
                if (item != null)
                {
                    item.CostValue = u.CostValue;
                    item.Editor = Services.WorkContext.CurrentUser.UserName;
                    item.EditTime = DateTime.Now;
                    _actualCostRecords.Update(item);
                }
                else
                {
                    item = new ActualCostRecord()
                    {
                        WBSElement = u.WBSElement,
                        WBSID = u.WBSElement.Length > 6 ? u.WBSElement.Substring(0, 6) : u.WBSElement,
                        CostValue = u.CostValue,
                        CreateTime = DateTime.Now,
                        Creator = Services.WorkContext.CurrentUser.UserName,
                        Editor = Services.WorkContext.CurrentUser.UserName,
                        EditTime = DateTime.Now,
                        YearMonth = yearMonth
                    };
                    _actualCostRecords.Create(item);
                }
            }
        }

        public ActionResult GetData(string ids, string type, string year)
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
            var data = (type == "Year") ? GetYearChartData(lstIds) : GetMonthChartData(lstIds, year);

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        private ChartData GetYearChartData(IList<int> lstIds)
        {
            var data = new ChartData();
            var lnq = from item in _adlCostRecords.Table
                      where lstIds.Contains(item.ADLRecord.Id)
                      select new CostYearQueryData
                      {
                          Name = string.Format("{0}.{1}({2})", item.ADLRecord.ProjectNo
                                             , item.ADLRecord.VersionNo
                                             , string.IsNullOrEmpty(item.ADLRecord.WBSID)?T("None").Text:item.ADLRecord.WBSID),
                          WBSID = item.ADLRecord.WBSID,
                          Year = item.Year.ToString(),
                          Cost = (item.Jan ?? 0)
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
            IList<CostYearQueryData> lst = lnq.ToList();
            var lstYears= lst.Select(item => item.Year).Distinct().OrderBy(o => o).ToList();
            data.Categories = lstYears;
            IList<string> lstWBSID = lst.Select(item => item.WBSID).Distinct().OrderBy(o => o).ToList();

            foreach(var wbsid in lstWBSID)
            {
                //Finance File Series.
                ChartSeriesData seriesData0 = new ChartSeriesData();
                seriesData0.name = string.Format("WBSID:({0})",string.IsNullOrEmpty(wbsid)? T("None").Text :wbsid);
                data.Legend.Add(seriesData0.name);
                var qry = _actualCostRecords.Table.Where(w => w.WBSID == wbsid);
                if (qry.Count() > 0)
                {
                    foreach (var year in lstYears)
                    {
                        string startMonth = string.Format("{0}01", year);
                        string endMonth = string.Format("{0}12", year);
                        var cost = qry.Where(w => w.YearMonth.CompareTo(startMonth) >= 0 && w.YearMonth.CompareTo(endMonth) <= 0)
                                      .Sum(s => s.CostValue);
                        seriesData0.data.Add(cost ?? 0);
                    }
                }
                else
                {
                    foreach (var year in lstYears)
                    {
                        seriesData0.data.Add(0);
                    }
                }
                data.Series.Add(seriesData0);

                //寻求所有WBSID==WBSID的项目数据。
                ChartSeriesData seriesDataSum = null;

                var names = lst.Where(w => w.WBSID == wbsid).Select(item => item.Name).Distinct().OrderBy(o => o);
                var nameCount = names.Count();
                if (nameCount > 1)
                {
                    seriesDataSum = new ChartSeriesData();
                }
                foreach (var name in names)
                {
                    ChartSeriesData seriesData = new ChartSeriesData();
                    seriesData.name = name;
                    data.Legend.Add(name);
                    if (seriesDataSum != null)
                    {
                        seriesDataSum.name += string.Format("+ {0}", name);
                    }
                    for(int i=0;i<lstYears.Count;i++)
                    {
                        var year = lstYears[i];
                        var cost = lst.Where(w => w.Name == name && w.Year == year).Sum(s => s.Cost);
                        seriesData.data.Add(cost);

                        if (seriesDataSum != null)
                        {
                            if (seriesDataSum.data.Count > i)
                            {
                                seriesDataSum.data[i] += cost;
                            }
                            else
                            {
                                seriesDataSum.data.Add(cost);
                            }
                        }
                    }
                    data.Series.Add(seriesData);
                }

                if (seriesDataSum != null)
                {
                    seriesDataSum.name = seriesDataSum.name.Trim('+');
                    data.Legend.Add(seriesDataSum.name);
                    data.Series.Add(seriesDataSum);
                }
            }
            
            return data;
        }


        private ChartData GetMonthChartData(IList<int> lstIds, string nyear)
        {
            var data = new ChartData();
            
            IList<CostMonthQueryData> lst;
            if (string.IsNullOrEmpty(nyear))
            {
                var lnq = from item in _adlCostRecords.Table
                          where lstIds.Contains(item.ADLRecord.Id)
                          select new CostMonthQueryData
                          {
                              Name = string.Format("{0}.{1}({2})", item.ADLRecord.ProjectNo
                                             , item.ADLRecord.VersionNo
                                             , string.IsNullOrEmpty(item.ADLRecord.WBSID) ? T("None").Text : item.ADLRecord.WBSID),
                              WBSID = item.ADLRecord.WBSID,
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
                var lnq = from item in _adlCostRecords.Table
                          where lstIds.Contains(item.ADLRecord.Id) && item.Year == Convert.ToInt32(nyear)
                          select new CostMonthQueryData
                          {
                              Name = string.Format("{0}.{1}({2})", item.ADLRecord.ProjectNo
                                             , item.ADLRecord.VersionNo
                                             , string.IsNullOrEmpty(item.ADLRecord.WBSID) ? T("None").Text : item.ADLRecord.WBSID),
                              WBSID = item.ADLRecord.WBSID,
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
            IList<string> lstWBSID = lst.Select(item => item.WBSID).Distinct().OrderBy(o => o).ToList();

            foreach (var wbsid in lstWBSID)
            {
                //Finance File Series.
                ChartSeriesData seriesData0 = new ChartSeriesData();
                seriesData0.name = string.Format("WBSID:({0})", string.IsNullOrEmpty(wbsid) ? T("None").Text : wbsid);
                data.Legend.Add(seriesData0.name);
                var qry = _actualCostRecords.Table.Where(w => w.WBSID == wbsid);
                if (qry.Count() > 0)
                {
                    foreach (var year in lstYears)
                    {
                        var jan = qry.Where(w => w.YearMonth == string.Format("{0}01", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(jan ?? 0);
                        var feb = qry.Where(w => w.YearMonth == string.Format("{0}02", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(feb ?? 0);
                        var may = qry.Where(w => w.YearMonth == string.Format("{0}03", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(may ?? 0);
                        var apr = qry.Where(w => w.YearMonth == string.Format("{0}04", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(apr ?? 0);
                        var mar = qry.Where(w => w.YearMonth == string.Format("{0}05", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(mar ?? 0);
                        var jun = qry.Where(w => w.YearMonth == string.Format("{0}06", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(jun ?? 0);
                        var jul = qry.Where(w => w.YearMonth == string.Format("{0}07", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(jul ?? 0);
                        var aug = qry.Where(w => w.YearMonth == string.Format("{0}08", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(aug ?? 0);
                        var sep = qry.Where(w => w.YearMonth == string.Format("{0}09", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(sep ?? 0);
                        var oct = qry.Where(w => w.YearMonth == string.Format("{0}10", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(oct ?? 0);
                        var nov = qry.Where(w => w.YearMonth == string.Format("{0}11", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(nov ?? 0);
                        var dev = qry.Where(w => w.YearMonth == string.Format("{0}12", year)).Sum(s => s.CostValue);
                        seriesData0.data.Add(dev ?? 0);
                    }
                }
                else
                {
                    foreach (var year in lstYears)
                    {
                        for (var month = 1; month <= 12; month++)
                        {
                            seriesData0.data.Add(0);
                        }
                    }
                }
                data.Series.Add(seriesData0);

                //寻求所有WBSID==WBSID的项目数据。
                ChartSeriesData seriesDataSum = null;

                var names = lst.Where(w => w.WBSID == wbsid).Select(item => item.Name).Distinct().OrderBy(o => o);
                var nameCount = names.Count();
                if (nameCount > 1)
                {
                    seriesDataSum = new ChartSeriesData();
                }

                foreach (var name in names)
                {
                    ChartSeriesData seriesData = new ChartSeriesData();
                    seriesData.name = name;
                    data.Legend.Add(name);
                    if (seriesDataSum != null)
                    {
                        seriesDataSum.name += string.Format("+{0} ", name);
                    }
                    for (int i = 0; i < lstYears.Count; i++)
                    {
                        var year = lstYears[i];
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

                        if (seriesDataSum != null)
                        {
                            for (var month = 0; month < 12; month++)
                            {
                                var index = i * 12 + month;
                                if (seriesDataSum.data.Count > index)
                                {
                                    seriesDataSum.data[index] += seriesData.data[index];
                                }
                                else
                                {
                                    seriesDataSum.data.Add(seriesData.data[index]);
                                }
                            }
                        }
                    }
                    data.Series.Add(seriesData);
                }
                if (seriesDataSum != null)
                {
                    seriesDataSum.name = seriesDataSum.name.Trim('+');
                    data.Legend.Add(seriesDataSum.name);
                    data.Series.Add(seriesDataSum);
                }
            }
            
            return data;
        }

        
    }

    public class ActualCostUploadData{
        public string WBSElement { get; set; }
        public double CostValue { get; set; }
    }

    public class CostYearQueryData
    {
        public string Name { get; set; }
        public string WBSID { get; set; }
        public string Year { get; set; }
        public double Cost { get; set; }
    }

    public class CostMonthQueryData
    {
        public string Name { get; set; }
        public string WBSID { get; set; }
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