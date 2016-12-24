using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.ViewModels
{
    public class ADLQuotationViewModel: ADLViewModel
    {
        public ADLQuotationViewModel()
        {
            Years = new List<int>();
            HeadCounts = new List<HeadCountEntry>();
            HourRatios = new List<HourRatioEntry>();
            Costs = new List<CostEntry>();
            WorkingHours = new List<WorkingHourEntry>();
            IBPs = new List<SelectListItem>();
        }
        public int CurrentYear { get; set; }
        public IList<int> Years { get; set; }
        public IEnumerable<SelectListItem> IBPs { get; set; }
        public IList<ActivityTypeEntry> ActivityTypes { get; set; }
        public IList<HeadCountEntry> HeadCounts { get; set; }
        public IList<HourRatioEntry> HourRatios { get; set; }
        public IList<CostEntry> Costs { get; set; }
        public IList<WorkingHourEntry> WorkingHours { get; set; }
    }
}