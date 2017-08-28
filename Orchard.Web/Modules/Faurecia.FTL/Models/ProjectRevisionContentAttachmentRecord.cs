using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.Models
{
    public class ProjectRevisionContentAttachmentRecord
    {
        public virtual int Id { get; set; }

        public virtual string Category { get; set; }
        public virtual string Name { get; set; }
        public virtual string Path { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual ProjectRevisionContentRecord ProjectRevisionContentRecord { get; set; }
    }
}