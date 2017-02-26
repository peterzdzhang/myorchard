using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.Models
{
    public class ActualCostRecord
    {
        public virtual int Id { get; set; }
        public virtual string YearMonth { get; set; }
        public virtual string WBSID { get; set; }
        public virtual string WBSElement { get; set; }
        public virtual double? CostValue { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime EditTime { get; set; }
        public virtual string Editor { get; set; }
    }
}