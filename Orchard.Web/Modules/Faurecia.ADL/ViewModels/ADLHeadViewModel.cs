using Faurecia.ADL.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.ViewModels
{
    public class ADLHeadViewModel
    {
        public ADLHeadViewModel()
        {
            VersionNo = 1;
            Currency = "RMB";
            Id = 0;
        }
        [Required]
        public int Id { get; set; }

        [JsonConverter(typeof(StringEnumConverter))]
        public EnumPhase Phase { get; set; }

        [JsonConverter(typeof(StringEnumConverter))]
        public EnumPhase NextPhase { get; set; }

        [JsonConverter(typeof(StringEnumConverter))]
        public EnumStatus Status { get; set; }
        [Required]
        public string ProjectNo { get; set; }

        [Required]
        public int VersionNo { get; set; }

        [Required]
        [StringLength(8)]
        public string Name { get; set; }

        [Required]
        [StringLength(25)]
        public string Customer { get; set; }

        [Required]
        [StringLength(5)]
        public string Currency { get; set; }

        [Required]
        [StringLength(50)]
        public string ProgramManager { get; set; }

        [Required]
        [StringLength(50)]
        public string ProgramController { get; set; }

        public string Type { get; set; }

        public DateTime? StartDate { get; set; }

        public DateTime? OfferDate { get; set; }

        public DateTime? ProtoDate { get; set; }

        public DateTime? PTRDate { get; set; }

        public DateTime? SOPDate { get; set; }
        
        public DateTime? Mockup { get; set; }

        public DateTime? Award { get; set; }
        [StringLength(500)]
        public string MileStoneComments { get; set; }

        public string Variant1 { get; set; }

        public string Variant2 { get; set; }

        public string Variant3 { get; set; }

        public string FrameMaturity { get; set; }

        [StringLength(500)]
        public string VehicelComments { get; set; }

        public string Tracks { get; set; }

        public string Recliner { get; set; }

        public string HA { get; set; }
        [StringLength(50)]
        public string Ballfix { get; set; }

        public string KEZE { get; set; }

        [StringLength(100)]
        public string WBSID { get; set; }

        public string Quotation { get; set; }
        [StringLength(255)]
        public string QuotationComments { get; set; }

        public DateTime? QuotationTime { get; set; }

        public string IBP { get; set; }
        [StringLength(500)]
        public string IBPComments { get; set; }

        public DateTime? IBPTime { get; set; }

        public string Creator { get; set; }

        public DateTime? CreateTime { get; set; }
    }

}