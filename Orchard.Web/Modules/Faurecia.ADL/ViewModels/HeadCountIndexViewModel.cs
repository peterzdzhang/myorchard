using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class HeadCountIndexViewModel
    {
        public HeadCountIndexViewModel()
        {
            HeadCounts = new List<HeadCountsEntry>();
            Options = new HeadCountIndexOptions();

        }
        public IList<HeadCountsEntry> HeadCounts { get; set; }

        public HeadCountIndexOptions Options { get; set; }
        public dynamic Pager { get; set; }
    }

    public class HeadCountsEntry
    {
        public HeadCountRecord HeadCount { get; set; }

        public bool IsChecked { get; set; }
    }

    public class HeadCountIndexOptions
    {
        public string Search { get; set; }

        public HeadCountOrder Order { get; set; }

        public HeadCountFilter Filter { get; set; }

        public HeadCountAction BulkAction { get; set; }
    }

    public enum HeadCountOrder
    {
        Year,
        YearDesc
    }

    public enum HeadCountFilter
    {
        LastestVersion,
        AllVersion
    }
    

}