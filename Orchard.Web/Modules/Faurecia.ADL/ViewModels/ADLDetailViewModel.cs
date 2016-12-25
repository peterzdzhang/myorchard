using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class ADLDetailViewModel
    {
        
        public ADLDetailViewModel()
        {
            Entries = new List<ADLDetailEntry>();
        }

        public IList<ADLDetailEntry> Entries { get; set; }
    }

    public class ADLDetailEntry
    {
        public ADLDetailEntry()
        {
            HeadCounts = new List<HeadCountEntry>();
            HourRatios = new List<HourRatioEntry>();
            Costs = new List<CostEntry>();
            WorkingHours = new List<WorkingHourEntry>();
        }

        public int Year { get; set; }
        
        public IList<HeadCountEntry> HeadCounts { get; set; }
        public IList<HourRatioEntry> HourRatios { get; set; }
        public IList<CostEntry> Costs { get; set; }
        public IList<WorkingHourEntry> WorkingHours { get; set; }
    }


    public class ActivityTypeEntry
    {
        public int Id { get; set; }
        public string Comment { get; set; }
        public string RMBHour { get; set; }
        public string CostCenter { get; set; }
        public string ActivityType { get; set; }

        public override bool Equals(object obj)
        {
            var that = obj as ActivityTypeEntry;
            if (that == null) return false;
            if (this.ActivityType == that.ActivityType
                && this.RMBHour == that.RMBHour
                && this.CostCenter == that.CostCenter
                && this.Comment == that.Comment)
            {
                return true;
            }
            return base.Equals(obj);
        }

        public override int GetHashCode()
        {
            return this.ActivityType.GetHashCode()
                    + this.RMBHour.GetHashCode()
                    + this.CostCenter.GetHashCode()
                    + this.Comment.GetHashCode();
        }
    }

    public class HeadCountEntry
    {
        public int Id { get; set; }
        public ActivityTypeEntry ActivityType { get; set; }
        public int Year { get; set; }
        public double? Jan { get; set; }
        public double? Feb { get; set; }
        public double? Mar { get; set; }
        public double? Apr { get; set; }
        public double? May { get; set; }
        public double? Jun { get; set; }
        public double? Jul { get; set; }
        public double? Aug { get; set; }
        public double? Sep { get; set; }
        public double? Oct { get; set; }
        public double? Nov { get; set; }
        public double? Dev { get; set; }

        public double? Y1 { get; set; }
    }
    public class HourRatioEntry
    {
        public int Id { get; set; }
        public ActivityTypeEntry ActivityType { get; set; }
        public int Year { get; set; }
        public double? Jan { get; set; }
        public double? Feb { get; set; }
        public double? Mar { get; set; }
        public double? Apr { get; set; }
        public double? May { get; set; }
        public double? Jun { get; set; }
        public double? Jul { get; set; }
        public double? Aug { get; set; }
        public double? Sep { get; set; }
        public double? Oct { get; set; }
        public double? Nov { get; set; }
        public double? Dev { get; set; }

        public double? Y1 { get; set; }
    }
    public class CostEntry
    {
        public int Id { get; set; }
        public ActivityTypeEntry ActivityType { get; set; }
        public int Year { get; set; }
        public double? Jan { get; set; }
        public double? Feb { get; set; }
        public double? Mar { get; set; }
        public double? Apr { get; set; }
        public double? May { get; set; }
        public double? Jun { get; set; }
        public double? Jul { get; set; }
        public double? Aug { get; set; }
        public double? Sep { get; set; }
        public double? Oct { get; set; }
        public double? Nov { get; set; }
        public double? Dev { get; set; }

        public double? Y1 { get; set; }
    }
    public class WorkingHourEntry
    {
        public int Id { get; set; }
        public int Year { get; set; }
        public double? Jan { get; set; }
        public double? Feb { get; set; }
        public double? Mar { get; set; }
        public double? Apr { get; set; }
        public double? May { get; set; }
        public double? Jun { get; set; }
        public double? Jul { get; set; }
        public double? Aug { get; set; }
        public double? Sep { get; set; }
        public double? Oct { get; set; }
        public double? Nov { get; set; }
        public double? Dev { get; set; }

        public double? Y1 { get; set; }
    }
}