using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class ActivityTypeCreateViewModel
    {
        public int Id { get; set; }

        [Required]
        public string CostCenter { get; set; }

        [Required]
        public string ActivityType { get; set; }

        public string RMBHour { get; set; }

        public string Comment { get; set; }
       
        public ActivityTypeDisplayGroup DisplayGroup { get; set; }

        public ActivityTypeTotalGroup TotalGroup { get; set; }

        public IList<HourRatioCreateEntry> HourRatios { get; set; }

        public bool IsUsed { get; set; }
    }

    public class HourRatioCreateEntry
    {
        public HourRatioRecord HourRatio { get; set; }

        public bool IsChecked { get; set; }
    }
}