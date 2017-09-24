using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL.Models
{
    public class ProjectRevisionContentRecord
    {
        public virtual int Id { get; set; }

        public virtual string Catalogue { get; set; }
        public virtual string LifePhase { get; set; }
        public virtual string ProjectFunction { get; set; }
        public virtual string CustomerSpecificationReference { get; set; }
        public virtual string Chapter { get; set; }
        public virtual string Page { get; set; }
        public virtual string SpecificationSubjectEnglish { get; set; }
        public virtual string SpecificationSubjectChinese { get; set; }
        public virtual string ReferenceFiles { get; set; }
        public virtual string Criteria { get; set; }
        public virtual string SatisfactionLevel { get; set; }
        public virtual string TestConditions { get; set; }
        public virtual string ConcernedProduct { get; set; }
        public virtual string CommitmentLevel { get; set; }
        public virtual string TestConditions1 { get; set; }
        public virtual int Risk { get; set; }
        public virtual string Comments { get; set; }
        public virtual string Leader { get; set; }
        public virtual string DueDate { get; set; }
        public virtual string RelatedEvidence { get; set; }
        public virtual string CompetitorPerformance { get; set; }
        public virtual DateTime CreateTime { get; set; }
        public virtual string Creator { get; set; }
        public virtual DateTime EditTime { get; set; }
        public virtual string Editor { get; set; }
        public virtual ProjectRevisionRecord ProjectRevisionRecord { get; set; }
    }
}