using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class ADLIndexViewModel
    {
        public ADLIndexViewModel()
        {
            ADLs = new List<ADLIndexEntry>();
            Options = new ADLIndexOptions();

        }
        public IList<ADLIndexEntry> ADLs { get; set; }

        public bool IsDisplayCompareHeadCount { get; set; }

        public bool IsDisplayCompareCost { get; set; }
        public ADLIndexOptions Options { get; set; }
        public dynamic Pager { get; set; }
    }

    public class ADLIndexEntry
    {
        public ADLRecord ADLRecord { get; set; }

        public bool IsChecked { get; set; }

        public int Id { get; set; }
    }

    public class ADLIndexOptions
    {
        public virtual string ProjectNo { get; set; }
        public virtual string Customer { get; set; }

        public virtual DateTime? StartDate1 { get; set; }
        public virtual DateTime? StartDate2 { get; set; }
        public virtual string ProgramManager { get; set; }

        public ADLOrder Order { get; set; }

        public ADLFilter Filter { get; set; }
    }

    public enum ADLOrder
    {
        ProjectNo,
        Customer,
        StartDate,
        ProgramManager
    }

    public enum ADLFilter
    {
        LastestVersion,
        AllVersion
    }
    
}