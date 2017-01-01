using System;
using System.Collections.Generic;
using System.Data;
using Orchard.ContentManagement.Drivers;
using Orchard.ContentManagement.MetaData;
using Orchard.ContentManagement.MetaData.Builders;
using Orchard.Core.Contents.Extensions;
using Orchard.Data.Migration;

namespace Faurecia.ADL {
    public class Migrations : DataMigrationImpl {

        public int Create() {

            // Creating table ActivityTypeRecord
            SchemaBuilder.CreateTable("ActivityTypeRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("ActivityType", DbType.String)
                .Column("CostCenter", DbType.String)
                .Column("RMBHour", DbType.String)
                .Column("Comment", DbType.String)
                .Column("DisplayGroup", DbType.String)
                .Column("TotalGroup", DbType.String)
                .Column("IsUsed", DbType.Boolean)
            );

            // Creating table HourRatioRecord
            SchemaBuilder.CreateTable("HourRatioRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("Year", DbType.Int32)
                .Column("Jan", DbType.Double)
                .Column("Feb", DbType.Double)
                .Column("Mar", DbType.Double)
                .Column("Apr", DbType.Double)
                .Column("May", DbType.Double)
                .Column("Jun", DbType.Double)
                .Column("Jul", DbType.Double)
                .Column("Aug", DbType.Double)
                .Column("Sep", DbType.Double)
                .Column("Oct", DbType.Double)
                .Column("Nov", DbType.Double)
                .Column("Dev", DbType.Double)
                .Column<int>("ActivityTypeRecord_Id")
            );

            SchemaBuilder.CreateTable("WorkingHourRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("Year", DbType.Int32,col=>col.Unique())
                .Column("Jan", DbType.Double)
                .Column("Feb", DbType.Double)
                .Column("Mar", DbType.Double)
                .Column("Apr", DbType.Double)
                .Column("May", DbType.Double)
                .Column("Jun", DbType.Double)
                .Column("Jul", DbType.Double)
                .Column("Aug", DbType.Double)
                .Column("Sep", DbType.Double)
                .Column("Oct", DbType.Double)
                .Column("Nov", DbType.Double)
                .Column("Dev", DbType.Double)
            );
            // Creating table ADLCostRecord
            SchemaBuilder.CreateTable("ADLCostRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
				.Column("Year", DbType.Int32)
				.Column("Jan", DbType.Double)
				.Column("Feb", DbType.Double)
				.Column("Mar", DbType.Double)
				.Column("Apr", DbType.Double)
				.Column("May", DbType.Double)
				.Column("Jun", DbType.Double)
				.Column("Jul", DbType.Double)
				.Column("Aug", DbType.Double)
				.Column("Sep", DbType.Double)
				.Column("Oct", DbType.Double)
				.Column("Nov", DbType.Double)
				.Column("Dev", DbType.Double)
                .Column<int>("ActivityTypeRecord_Id")
                .Column<int>("ADLRecord_Id")
            );

			// Creating table ADLWorkingHourRecord
			SchemaBuilder.CreateTable("ADLWorkingHourRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("Year", DbType.Int32)
				.Column("Jan", DbType.Double)
				.Column("Feb", DbType.Double)
				.Column("Mar", DbType.Double)
				.Column("Apr", DbType.Double)
				.Column("May", DbType.Double)
				.Column("Jun", DbType.Double)
				.Column("Jul", DbType.Double)
				.Column("Aug", DbType.Double)
				.Column("Sep", DbType.Double)
				.Column("Oct", DbType.Double)
				.Column("Nov", DbType.Double)
				.Column("Dev", DbType.Double)
                .Column<int>("ADLRecord_Id")
            );

			// Creating table ADLHourRatioRecord
			SchemaBuilder.CreateTable("ADLHourRatioRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
				.Column("Year", DbType.Int32)
				.Column("Jan", DbType.Double)
				.Column("Feb", DbType.Double)
				.Column("Mar", DbType.Double)
				.Column("Apr", DbType.Double)
				.Column("May", DbType.Double)
				.Column("Jun", DbType.Double)
				.Column("Jul", DbType.Double)
				.Column("Aug", DbType.Double)
				.Column("Sep", DbType.Double)
				.Column("Oct", DbType.Double)
				.Column("Nov", DbType.Double)
				.Column("Dev", DbType.Double)
                .Column<int>("ActivityTypeRecord_Id")
                .Column<int>("ADLRecord_Id")
            );

			// Creating table ADLHeadCountRecord
			SchemaBuilder.CreateTable("ADLHeadCountRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
				.Column("Year", DbType.Int32)
				.Column("Jan", DbType.Double)
				.Column("Feb", DbType.Double)
				.Column("Mar", DbType.Double)
				.Column("Apr", DbType.Double)
				.Column("May", DbType.Double)
				.Column("Jun", DbType.Double)
				.Column("Jul", DbType.Double)
				.Column("Aug", DbType.Double)
				.Column("Sep", DbType.Double)
				.Column("Oct", DbType.Double)
				.Column("Nov", DbType.Double)
				.Column("Dev", DbType.Double)
                .Column<int>("ActivityTypeRecord_Id")
                .Column<int>("ADLRecord_Id")
            );

			// Creating table ADLRecord
			SchemaBuilder.CreateTable("ADLRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("ProjectNo", DbType.String)
				.Column("VersionNo", DbType.Int32)
				.Column("Name", DbType.String)
				.Column("Customer", DbType.String)
				.Column("Currency", DbType.String)
				.Column("ProgramManager", DbType.String)
				.Column("ProgramController", DbType.String)
				.Column("Type", DbType.String)
				.Column("StartDate", DbType.DateTime)
				.Column("OfferDate", DbType.DateTime)
				.Column("ProtoDate", DbType.DateTime)
				.Column("PTRDate", DbType.DateTime)
				.Column("SOPDate", DbType.DateTime)
				.Column("MockUp", DbType.DateTime)
				.Column("Award", DbType.DateTime)
				.Column("MileStoneComments", DbType.String)
				.Column("Variant1", DbType.String)
				.Column("Variant2", DbType.String)
				.Column("Variant3", DbType.String)
				.Column("FrameMaturity", DbType.String)
				.Column("VehicelComments", DbType.String)
				.Column("Tracks", DbType.String)
                .Column("Status",DbType.String)
                .Column("Phase",DbType.String)
                .Column("Recliner", DbType.String)
				.Column("HA", DbType.String)
				.Column("Ballfix", DbType.String)
				.Column("KEZE", DbType.String)
				.Column("QuotationComments", DbType.String)
				.Column("Quotation", DbType.String)
				.Column("QuotationTime", DbType.DateTime)
				.Column("IBPComments", DbType.String)
				.Column("IBP", DbType.String)
				.Column("IBPTime", DbType.DateTime)
                .Column("IsLastest",DbType.Boolean)
                .Column("Creator", DbType.String)
				.Column("CreateTime", DbType.DateTime)
                .Column("Editor", DbType.String)
				.Column("EditTime", DbType.DateTime)
			);



            return 1;
        }
    }
}