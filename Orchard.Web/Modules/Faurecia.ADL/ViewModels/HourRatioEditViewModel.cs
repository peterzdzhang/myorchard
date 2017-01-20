using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class HourRatioEditViewModel
    {
        public HourRatioEditViewModel(){
        }

        [Required]
        [RegularExpression("^[0-9]{4,4}$", ErrorMessage = "Please input 4 digit integer.")]
        public int Year { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Jan { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Feb { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Mar { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Apr { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double May { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Jun { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Jul { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Aug { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Sep { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Oct { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$",ErrorMessage = "Please input numeric.")]
        public double Nov { get; set; }
        [Required]
        [RegularExpression("^[0-9]+.?[0-9]*$", ErrorMessage = "Please input numeric.")]
        public double Dev { get; set; }
    }
}