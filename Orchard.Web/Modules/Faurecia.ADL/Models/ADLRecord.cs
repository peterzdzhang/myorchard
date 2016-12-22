using Orchard.ContentManagement.Records;
using Orchard.Data.Conventions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.Models
{
    /// <summary>
    /// ADL 记录
    /// </summary>
    public class ADLRecord 
    {
        public virtual int Id { get; set; }
        public virtual string ProjectNo { get; set; }
        public virtual int VersionNo { get; set; }

        public virtual string Name { get; set; }
        public virtual string Customer { get; set; }
        public virtual string Currency { get; set; }

        public virtual string ProgramManager{get;set;}

        public virtual string ProgramController { get; set; }
        // Request info / milestone
        public virtual string Type { get; set; }

        public virtual DateTime? StartDate { get; set; }
        public virtual DateTime? OfferDate { get; set; }

        public virtual DateTime? ProtoDate { get; set; }

        public virtual DateTime? PTRDate { get; set; }
        public virtual DateTime? SOPDate { get; set; }
        public virtual string MockUp { get; set; }
        public virtual string Award { get; set; }

        public virtual string MileStoneComments { get; set; }
        //Vehicle/Frame information
        public virtual string Variant1 { get; set; }

        public virtual string Variant2 { get; set; }
        public virtual string Variant3 { get; set; }

        public virtual string FrameMaturity { get; set; }

        public virtual string VehicelComments { get; set; }
        //Products offer
        public virtual string Tracks { get; set; }
        public virtual string Recliner { get; set; }
        public virtual string HA { get; set; }
        public virtual string Ballfix { get; set; }
        public virtual string KEZE { get; set; }

        public virtual EnumStatus Status { get; set; }
        public virtual EnumPhase Phase { get; set; }
        public virtual string QuotationComments { get; set; }
        public virtual string Quotation { get; set; }
        public virtual DateTime? QuotationTime { get; set; }

        public virtual string IBPComments { get; set; }
        public virtual string IBP { get; set; }
        public virtual DateTime? IBPTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime? CreateTime { get; set; }
        public virtual string Editor { get; set; }
        public virtual DateTime? EditTime { get; set; }
        public virtual bool IsLastest { get; set; }

        //[CascadeAllDeleteOrphan]
        //public virtual IList<ADLHeadCountRecord> HeadCounts { get; set; }
        //[CascadeAllDeleteOrphan]
        //public virtual IList<ADLHourRatioRecord> HourRatios { get; set; }
        //[CascadeAllDeleteOrphan]
        //public virtual IList<ADLCostRecord> Costs { get; set; }
        //[CascadeAllDeleteOrphan]
        //public virtual IList<ADLWorkingHourRecord> WorkingHours { get; set; }
    }

    public enum EnumStatus
    {
        Inwork,
        Frozen
    }

    public enum EnumPhase
    {
        Creating,
        Quotation,
        IBP
    }


}