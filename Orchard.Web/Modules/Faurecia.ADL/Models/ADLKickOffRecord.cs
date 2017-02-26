using Orchard.ContentManagement.Records;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.Models
{
    public class ADLKickOffRecord
    {
        public virtual int Id { get; set; }
        public virtual int Year { get; set; }
        public virtual int Month { get; set; }
        public virtual string Name { get; set; }
        public virtual string Content { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public ADLRecord ADLRecord { get; set; }
    }
}