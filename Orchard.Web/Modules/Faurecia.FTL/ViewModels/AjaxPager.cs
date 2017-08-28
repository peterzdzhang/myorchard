using Orchard.Settings;
using Orchard.UI.Navigation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.ViewModels
{
    public class AjaxPager: Pager
    {
        /// <summary>
        /// Constructs a new pager.
        /// </summary>
        /// <param name="site">The site settings.</param>
        /// <param name="pagerParameters">The pager parameters.</param>
        public AjaxPager(ISite site, PagerParameters pagerParameters) 
            : this(site, pagerParameters.Page, pagerParameters.PageSize) {
        }

        /// <summary>
        /// Constructs a new pager.
        /// </summary>
        /// <param name="site">The site settings.</param>
        /// <param name="page">The page parameter.</param>
        /// <param name="pageSize">The page size parameter.</param>
        public AjaxPager(ISite site, int? page, int? pageSize) 
            : base(site, page, pageSize)
        {
        }

        public string UpdateTargetId { get; set; }
    }
}