using Faurecia.ADL.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.ViewModels
{
    public class ADLDiffViewModel 
    {
        public ADLDiffViewModel()
        {
            ViewModels = new List<ADLViewModel>();
            Ids = new List<string>();
        }
        public IList<string> Ids { get; set; }
        public IList<ADLViewModel> ViewModels { get; set; }
    }
}