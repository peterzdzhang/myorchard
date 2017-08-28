using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.Models
{
    public class ProjectRevisionRecord
    {
        public virtual int Id { get; set; }

        public virtual string ProgramPhase { get; set; }
        public virtual string MiniorRevision { get; set; }
        public virtual string Status { get; set; }
        public virtual string CustomerSpecificationName { get; set; }
        public virtual string CustomerReleaseDate { get; set; }
        public virtual string ReviewDate { get; set; }
        public virtual string ReviewedBy { get; set; }
        public virtual string Comments { get; set; }
        public virtual string Owner { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime EditTime { get; set; }
        public virtual string Editor { get; set; }
        public virtual ProjectRecord ProjectRecord { get; set; }
    }
}