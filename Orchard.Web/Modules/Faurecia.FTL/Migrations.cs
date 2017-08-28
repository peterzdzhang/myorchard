using System;
using System.Collections.Generic;
using System.Data;
using Orchard.ContentManagement.Drivers;
using Orchard.ContentManagement.MetaData;
using Orchard.ContentManagement.MetaData.Builders;
using Orchard.Core.Contents.Extensions;
using Orchard.Data.Migration;
using Orchard.Roles.Services;

namespace Faurecia.FTL
{
    public class Migrations : DataMigrationImpl {

        private readonly IRoleService _roleService;

        public Migrations(IRoleService roleService)
        {
            _roleService = roleService;
        }

        public int Create() {
            
            SchemaBuilder.CreateTable("ProjectRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("Project", DbType.String)
                .Column("Market", DbType.String)
                .Column("Version", DbType.String)
                .Column("Customer", DbType.String)
                .Column("Mechanism", DbType.String)
                .Column("Product", DbType.String)
                .Column("Model", DbType.String)
                .Column("Seat", DbType.String)
                .Column("Owner", DbType.String)
                .Column("Phase", DbType.String)
                .Column("CreateTime", DbType.DateTime)
                .Column("Creator", DbType.String)
                .Column("EditTime", DbType.DateTime)
                .Column("Editor", DbType.String)
            );

            SchemaBuilder.CreateTable("ProjectRevisionRecord", table => table
               .Column<int>("Id", col => col.PrimaryKey().Identity())
               .Column("ProgramPhase", DbType.String)
               .Column("MiniorRevision", DbType.String)
               .Column("Status", DbType.String)
               .Column("CustomerSpecificationName", DbType.String)
               .Column("CustomerReleaseDate", DbType.String)
               .Column("ReviewDate", DbType.String)
               .Column("ReviewedBy", DbType.String)
               .Column("Comments", DbType.String)
               .Column("Owner", DbType.String)
               .Column("CreateTime", DbType.DateTime)
               .Column("Creator", DbType.String)
               .Column("EditTime", DbType.DateTime)
               .Column("Editor", DbType.String)
               .Column<int>("ProjectRecord_Id")
           );

           SchemaBuilder.CreateTable("ProjectRevisionAttachmentRecord", table => table
               .Column<int>("Id", col => col.PrimaryKey().Identity())
               .Column("Category", DbType.String)
               .Column("Name", DbType.String)
               .Column("Path", DbType.String)
               .Column("CreateTime", DbType.DateTime)
               .Column("Creator", DbType.String)
               .Column<int>("ProjectRevisionRecord_Id")
           );

            SchemaBuilder.CreateTable("ProjectRevisionContentRecord", table => table
               .Column<int>("Id", col => col.PrimaryKey().Identity())
               .Column("Catalogue", DbType.String)
               .Column("LifePhase", DbType.String)
               .Column("Function", DbType.String)
               .Column("CustomerSpecificationReference ", DbType.String)
               .Column("Chapter", DbType.String)
               .Column("Page", DbType.String)
               .Column("SpecificationSubjectEnglish", DbType.String)
               .Column("SpecificationSubjectChinese", DbType.String)
               .Column("ReferenceFiles", DbType.String)
               .Column("Criteria", DbType.String)
               .Column("SatisfactionLevel ", DbType.String)
               .Column("TestConditions", DbType.String)
               .Column("ConcernedProduct", DbType.String)
               .Column("CommitmentLevel", DbType.String)
               .Column("TestConditions1", DbType.String)
               .Column("Risk", DbType.Int32)
               .Column("Comments", DbType.String)
               .Column("Leader", DbType.String)
               .Column("DueDate", DbType.String)
               .Column("RelatedEvidence", DbType.String)
               .Column("CompetitorPerformance", DbType.String)
               .Column("CreateTime", DbType.DateTime)
               .Column("Creator", DbType.String)
               .Column("EditTime", DbType.DateTime)
               .Column("Editor", DbType.String)
               .Column<int>("ProjectRevisionRecord_Id")
           );

            SchemaBuilder.CreateTable("ProjectRevisionContentAttachmentRecord", table => table
              .Column<int>("Id", col => col.PrimaryKey().Identity())
              .Column("Category", DbType.String)
              .Column("Name", DbType.String)
              .Column("Path", DbType.String)
              .Column("CreateTime", DbType.DateTime)
              .Column("Creator", DbType.String)
              .Column<int>("ProjectRevisionContentRecord_Id")
            );
            return 1;
        }
    }
}