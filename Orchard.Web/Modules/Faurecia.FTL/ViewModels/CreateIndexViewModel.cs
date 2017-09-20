using Faurecia.FTL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.ViewModels
{
    public class CreateIndexViewModel
    {
        public CreateIndexViewModel()
        {
        }
        public FTLHeadViewModel Head { get; set; }
        
        public int Code { get; set; }

        public string Message { get; set; }
    }
    
    public class FTLHeadViewModel
    {
        public FTLHeadViewModel() { }
        [Required]
        public int Id { get; set; }
        [Required]
        [StringLength(50)]
        public string Project { get; set; }
        [Required]
        public int Version { get; set; }
        [Required]
        public ProjectPhase Phase { get; set; }
        [StringLength(50)]
        public string Market { get; set; }
        [StringLength(50)]
        public string Customer { get; set; }
        [StringLength(50)]
        public string Mechanism { get; set; }
        [StringLength(50)]
        public string Product { get; set; }
        [StringLength(50)]
        public string Model { get; set; }
        [StringLength(50)]
        public string Seat { get; set; }
        [StringLength(50)]
        public string Owner { get; set; }

        public string Creator { get; set; }

        public string Editor { get; set; }

        public DateTime CreateTime { get; set; }

        public DateTime EditTime { get; set; }
    }
    
}