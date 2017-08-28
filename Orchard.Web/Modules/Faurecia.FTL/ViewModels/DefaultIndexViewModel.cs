using Faurecia.FTL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.ViewModels
{
    public class DefaultIndexViewModel
    {
        public DefaultIndexViewModel()
        {
            Projects = new List<ProjectIndexEntry>();
            Options = new ProjectIndexOptions();
        }
        public IList<ProjectIndexEntry> Projects { get; set; }
        public ProjectIndexOptions Options { get; set; }
        public dynamic Pager { get; set; }
    }

    public class ProjectIndexEntry
    {
        public ProjectRecord ProjectRecord { get; set; }
        public bool IsChecked { get; set; }
        public int Id { get; set; }
    }

    public class ProjectIndexOptions
    {
        public virtual string Project { get; set; }
        public virtual string Customer { get; set; }
        public virtual DateTime? CreateTime1 { get; set; }
        public virtual DateTime? CreateTime2 { get; set; }
        public virtual string Product { get; set; }
        public ProjectOrder Order { get; set; }
        public ProjectFilter Filter { get; set; }
    }

    public enum ProjectOrder
    {
        Project,
        Customer,
        Product,
        CreateTime
    }

    public enum ProjectFilter
    {
    }
}