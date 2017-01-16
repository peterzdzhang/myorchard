using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class WorkingHourIndexViewModel
    {
        public WorkingHourIndexViewModel()
        {
            WorkingHours = new List<WorkingHoursEntry>();
            Options = new WorkingHourIndexOptions();

        }
        public IList<WorkingHoursEntry> WorkingHours { get; set; }

        public WorkingHourIndexOptions Options { get; set; }
        public dynamic Pager { get; set; }
    }

    public class WorkingHoursEntry
    {
        public WorkingHourRecord WorkingHour { get; set; }

        public bool IsChecked { get; set; }
    }

    public class WorkingHourIndexOptions
    {
        public string Search { get; set; }

        public WorkingHourOrder Order { get; set; }

        public WorkingHourFilter Filter { get; set; }

        public WorkingHourAction BulkAction { get; set; }
    }

    public enum WorkingHourOrder
    {
        Year,
        YearDesc
    }

    public enum WorkingHourFilter
    {
        None
    }
    

}