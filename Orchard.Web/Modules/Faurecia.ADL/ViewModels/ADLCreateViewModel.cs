﻿using Faurecia.ADL.Models;
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
            Head = new ADLHeadViewModel();
            Detail = new ADLDetailViewModel();
            Years = new List<int>();
            IBPs = new List<SelectListItem>();
        }
        public string RedirectToHref { get; set; }
        public EnumActions Action { get; set; }
        public string Message { get; set; }
        public int Code { get; set; }
        public IList<int> Years { get; set; }
        public ADLHeadViewModel Head { get; set; }
        public ADLDetailViewModel Detail { get; set; }


        public IEnumerable<SelectListItem> IBPs { get; set; }
        public IList<ActivityTypeEntry> ActivityTypes { get; set; }

        public IEnumerable<SelectListItem> Quotations { get; set; }
    }
    public class ADLCreateViewModel: ADLViewModel
    {
    }

    public enum EnumActions
    {
        New,
        Modify,
        View
    }
}