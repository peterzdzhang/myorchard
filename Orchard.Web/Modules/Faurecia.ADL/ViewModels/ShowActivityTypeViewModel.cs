using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.ViewModels
{
    public class ShowActivityTypeViewModel 
    {
        public ShowActivityTypeViewModel()
        {
            ActivityTypes = new List<ActivityTypeEntry>();
        }
        public int ADLRecordId { get; set; }
        public IList<ActivityTypeEntry> ActivityTypes { get; set; }
        public dynamic Pager { get; set; }

        public ShowActivityTypeOptions Options { get; set; }
    }

    public class ShowActivityTypeOptions
    {
        public ActivityTypeColumnType Column { get; set; }
        public string SearchText { get; set; }
        public ActivityTypeColumnType Order { get; set; }
    }

    public enum ActivityTypeColumnType
    {
        Id,
        ActivityType,
        CostCenter,
        RMBHour,
        Comment
    }

}