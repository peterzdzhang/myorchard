using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.Models
{
    public class ProjectRecord
    {
        public virtual int Id { get; set; }
        public virtual string Project { get; set; }
        public virtual string Version { get; set; }
        public virtual string Phase { get; set; }
        public virtual string Market { get; set; }
        public virtual string Customer { get; set; }
        public virtual string Mechanism { get; set; }
        public virtual string Product { get; set; }
        public virtual string Model { get; set; }
        public virtual string Seat { get; set; }
        public virtual string Owner { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime EditTime { get; set; }
        public virtual string Editor { get; set; }
    }
}