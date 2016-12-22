using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.ViewModels
{
    public class ADLViewModel
    {
        public ADLViewModel()
        {
            VersionNo = 1;
            Currency = "RMB";
        }
        public int Id { get; set; }
        public string Message { get; set; }

        public EnumActions Action { get; set; }

        public EnumPhase Phase { get; set; }
        public EnumStatus Status { get; set; }
        [Required]
        public string ProjectNo { get; set; }

        [Required]
        public int VersionNo { get; set; }

        [Required]
        [StringLength(255)]
        public string Name { get; set; }

        [Required]
        [StringLength(3,MinimumLength =3)]
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

        [StringLength(50)]
        public string Mockup { get; set; }
        [StringLength(50)]
        public string Award { get; set; }
        [StringLength(255)]
        public string MileStoneComments { get; set; }

        public string Variant1 { get; set; }

        public string Variant2 { get; set; }

        public string Variant3 { get; set; }

        public string FrameMaturity { get; set; }

        [StringLength(255)]
        public string VehicelComments { get; set; }

        public string Tracks { get; set; }

        public string Recliner { get; set; }

        public string HA { get; set; }
        [StringLength(50)]
        public string Ballfix { get; set; }

        public string KEZE { get; set; }
        
        public string Quotation { get; set; }

        public DateTime? QuotationTime { get; set; }

        public string IBP { get; set; }

        public DateTime? IBPTime { get; set; }

        public string Creator { get; set; }

        public DateTime? CreateTime { get; set; }
    }

    public class ADLCreateViewModel: ADLViewModel
    {
        public IEnumerable<SelectListItem> Quotations { get; set; }
    }

    public enum EnumActions
    {
        New,
        Modify,
        View
    }
}