using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class ChartData
    {
        public ChartData()
        {
            Categories = new List<string>();
            Series = new List<ChartSeriesData>();
            Legend = new List<string>();

        }
        public IList<string> Categories { get; set; }
        public IList<ChartSeriesData> Series { get; set; }

        public IList<string> Legend { get; set; }
    }

    public class ChartSeriesData
    {
        public ChartSeriesData()
        {
            data = new List<double>();
            type = "bar";
        }
        public string name { get; set; }
        public IList<double> data { get; set; }

        public string type { get; set; }

        public string stack { get; set; }
    }
}