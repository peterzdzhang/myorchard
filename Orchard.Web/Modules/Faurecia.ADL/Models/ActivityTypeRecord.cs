using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.Models
{
    public class ActivityTypeRecord
    {
        public virtual int Id { get; set; }

        public virtual int VersionNo { get; set; }
        public virtual int OriginalRecordId { get; set; }
        public virtual string Comment { get; set; }
        public virtual string RMBHour { get; set; }
        public virtual string CostCenter { get; set; }
        public virtual string ActivityType { get; set; }
        public virtual ActivityTypeDisplayGroup DisplayGroup { get; set; }
        public virtual ActivityTypeTotalGroup TotalGroup { get; set; }
        public virtual bool IsUsed { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime EditTime { get; set; }
        public virtual string Editor { get; set; }
    }


    public enum ActivityTypeDisplayGroup
    {
        DD,
        Travel,
        DV,
        PV,
        ExternalSupport,
        Capitalized
    }

    public enum ActivityTypeTotalGroup
    {
        None,
        DD,
        DV,
        PV,
        otherCT,
        ME,
        Travel,
        FEA
    }
}