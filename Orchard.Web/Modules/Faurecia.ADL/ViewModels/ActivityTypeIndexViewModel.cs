using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class ActivityTypeIndexViewModel
    {
        public ActivityTypeIndexViewModel()
        {
            ActivityTypes = new List<ActivityTypesEntry>();
            Options = new ActivityTypeIndexOptions();

        }
        public IList<ActivityTypesEntry> ActivityTypes { get; set; }

        public ActivityTypeIndexOptions Options { get; set; }
        public dynamic Pager { get; set; }
    }

    public class ActivityTypesEntry
    {
        public ActivityTypeRecord ActivityType { get; set; }

        public bool IsChecked { get; set; }
    }

    public class ActivityTypeIndexOptions
    {
        public string Search { get; set; }

        public ActivityTypeOrder Order { get; set; }

        public ActivityTypeFilter Filter { get; set; }

        public ActivityTypeBulkAction BulkAction { get; set; }
    }

    public enum ActivityTypeOrder
    {
        CostCenter,
        CostCenterDesc
    }

    public enum ActivityTypeFilter
    {
        DD,
        Travel,
        DV,
        PV,
        ExternalSupport,
        Capitalized
    }

    public enum ActivityTypeBulkAction
    {
        None,
        Create,
        Edit,
        Delete,
        BulkEdit,
        BulkDelete,
        BulkDisabled,
        BulkEnabled
    }

}