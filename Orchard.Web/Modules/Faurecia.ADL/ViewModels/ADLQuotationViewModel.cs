using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.ViewModels
{
    public class ADLQuotationViewModel: ADLViewModel
    {
        public ADLQuotationViewModel()
        {
            Years = new List<int>();
            IBPs = new List<SelectListItem>();
        }
    }
}