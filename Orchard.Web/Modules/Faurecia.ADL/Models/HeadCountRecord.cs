﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.Models
{
    public class HeadCountRecord
    {
        public virtual int Id { get; set; }
        public virtual int Year { get; set; }
        public virtual double? Jan { get; set; }
        public virtual double? Feb { get; set; }
        public virtual double? Mar { get; set; }
        public virtual double? Apr { get; set; }
        public virtual double? May { get; set; }
        public virtual double? Jun { get; set; }
        public virtual double? Jul { get; set; }
        public virtual double? Aug { get; set; }
        public virtual double? Sep { get; set; }
        public virtual double? Oct { get; set; }
        public virtual double? Nov { get; set; }
        public virtual double? Dev { get; set; }
        public virtual bool IsUsed { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime EditTime { get; set; }
        public virtual string Editor { get; set; }
    }
}