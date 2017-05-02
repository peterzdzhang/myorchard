using System;
using System.Collections.Generic;
using System.Data;
using Orchard.ContentManagement.Drivers;
using Orchard.ContentManagement.MetaData;
using Orchard.ContentManagement.MetaData.Builders;
using Orchard.Core.Contents.Extensions;
using Orchard.Data.Migration;
using Orchard.Roles.Services;

namespace Faurecia.ADL {
    public class Migrations : DataMigrationImpl {

        private readonly IRoleService _roleService;

        public Migrations(IRoleService roleService)
        {
            _roleService = roleService;
        }

        public int Create() {

            // Creating table ActivityTypeRecord
            SchemaBuilder.CreateTable("ActivityTypeRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("ActivityType", DbType.String)
                .Column("CostCenter", DbType.String)
                .Column("RMBHour", DbType.String)
                .Column("VersionNo", DbType.Int32)
                .Column("OriginalRecordId", DbType.Int32)
                .Column("Comment", DbType.String)
                .Column("DisplayGroup", DbType.String)
                .Column("TotalGroup", DbType.String)
                .Column("IsUsed", DbType.Boolean)
                .Column("CreateTime", DbType.DateTime)
                .Column("Creator", DbType.String)
                .Column("EditTime", DbType.DateTime)
                .Column("Editor", DbType.String)
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
                .Column("IsUsed", DbType.Boolean)
                .Column("CreateTime", DbType.DateTime)
                .Column("Creator", DbType.String)
                .Column("EditTime", DbType.DateTime)
                .Column("Editor", DbType.String)
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
                .Column<int>("VersionNo")
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

            // Creating table ADLKickOffRecord
            SchemaBuilder.CreateTable("ADLKickOffRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("Year", DbType.Int32)
                .Column("Month", DbType.Int32)
                .Column("Name", DbType.String)
                .Column("Content", DbType.String)
                .Column("CreateTime", DbType.DateTime)
                .Column("Creator", DbType.String)
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
                .Column("PTRDate", DbType.DateTime)
                .Column("MockUp", DbType.DateTime)
                .Column("OfferDate", DbType.DateTime)
                .Column("Award", DbType.DateTime)
                .Column("ProgramKickOff", DbType.DateTime)
                .Column("ProtoDate", DbType.DateTime)
                .Column("DV", DbType.DateTime)
                .Column("ToolingKickOff", DbType.DateTime)
                .Column("PV", DbType.DateTime)
                .Column("SOPDate", DbType.DateTime)
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
                .Column("WBSID", DbType.String)
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

            string tableDbName = SchemaBuilder.TableDbName("ActivityTypeRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET CreateTime='{1:yyyy-MM-dd}',EditTime='{1:yyyy-MM-dd}',Editor='',CREATOR=''"
                                                    , tableDbName
                                                    , DateTime.Now));


            tableDbName = SchemaBuilder.TableDbName("WorkingHourRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET IsUsed=1,CreateTime='{1:yyyy-MM-dd}',EditTime='{1:yyyy-MM-dd}',Editor='',CREATOR=''"
                                                    , tableDbName
                                                    , DateTime.Now));


            // Creating table ActualCostRecord
            SchemaBuilder.CreateTable("ActualCostRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("YearMonth", DbType.String)
                .Column("WBSID", DbType.String)
                .Column("WBSElement", DbType.String)
                .Column("CostValue", DbType.Double)
                .Column("Creator", DbType.String)
                .Column("CreateTime", DbType.DateTime)
                .Column("Editor", DbType.String)
                .Column("EditTime", DbType.DateTime)
            );

            SchemaBuilder.CreateTable("HeadCountRecord", table => table
               .Column<int>("Id", col => col.PrimaryKey().Identity())
               .Column("Year", DbType.Int32, col => col.Unique())
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
               .Column("IsUsed", DbType.Boolean)
               .Column("CreateTime", DbType.DateTime)
               .Column("Creator", DbType.String)
               .Column("EditTime", DbType.DateTime)
               .Column("Editor", DbType.String)
           );
            return 10;
        }


        public int UpdateFrom1()
        {
            // Creating table ADLKickOffRecord
            SchemaBuilder.CreateTable("ADLKickOffRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("Year", DbType.Int32)
                .Column("Month", DbType.Int32)
                .Column("Content", DbType.String)
                .Column("CreateTime", DbType.DateTime)
                .Column("Creator", DbType.String)
                .Column<int>("ADLRecord_Id")
            );
            return 2;
        }

        public int UpdateFrom2()
        {
            // alert table ActivityTypeRecord
            SchemaBuilder.AlterTable("ActivityTypeRecord", table =>
            {
                table.AddColumn("CreateTime", DbType.DateTime);
                table.AddColumn("Creator", DbType.String);
                table.AddColumn("EditTime", DbType.DateTime);
                table.AddColumn("Editor", DbType.String);
            });


            //// alert table ActivityTypeRecord
            SchemaBuilder.AlterTable("WorkingHourRecord", table =>
            {
                table.AddColumn("IsUsed", DbType.Boolean);
                table.AddColumn("CreateTime", DbType.DateTime);
                table.AddColumn("Creator", DbType.String);
                table.AddColumn("EditTime", DbType.DateTime);
                table.AddColumn("Editor", DbType.String);
            });

            string tableDbName = SchemaBuilder.TableDbName("ActivityTypeRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET CreateTime='{1:yyyy-MM-dd}',EditTime='{1:yyyy-MM-dd}',Editor='',CREATOR=''"
                                                    , tableDbName
                                                    , DateTime.Now));


            tableDbName = SchemaBuilder.TableDbName("WorkingHourRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET IsUsed=1,CreateTime='{1:yyyy-MM-dd}',EditTime='{1:yyyy-MM-dd}',Editor='',CREATOR=''"
                                                    , tableDbName
                                                    , DateTime.Now));
            return 3;
        }

        public int UpdateFrom3()
        {
            // alert table ActivityTypeRecord
            SchemaBuilder.AlterTable("ADLRecord", table =>
            {
                table.AddColumn("WBSID", DbType.String);
            });
            return 4;
        }

        public int UpdateFrom4()
        {
            // alert table ActivityTypeRecord
            SchemaBuilder.AlterTable("ADLKickOffRecord", table =>
            {
                table.AddColumn("Name", DbType.String);
            });
            return 5;
        }

        public int UpdateFrom5()
        {
            // Creating table ActualCostRecord
            SchemaBuilder.CreateTable("ActualCostRecord", table => table
                .Column<int>("Id", col => col.PrimaryKey().Identity())
                .Column("YearMonth", DbType.String)
                .Column("WBSID", DbType.String)
                .Column("WBSElement", DbType.String)
                .Column("CostValue", DbType.Double)
                .Column("Creator", DbType.String)
                .Column("CreateTime", DbType.DateTime)
                .Column("Editor", DbType.String)
                .Column("EditTime", DbType.DateTime)
            );

            SchemaBuilder.CreateTable("HeadCountRecord", table => table
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
             .Column("IsUsed", DbType.Boolean)
             .Column("CreateTime", DbType.DateTime)
             .Column("Creator", DbType.String)
             .Column("EditTime", DbType.DateTime)
             .Column("Editor", DbType.String)
         );
            return 6;
        }

        public int UpdateFrom6()
        {
            // alert table ADLRecord
            SchemaBuilder.AlterTable("ADLRecord", table =>
            {
                table.AddColumn("ProgramKickOff", DbType.DateTime);
                table.AddColumn("DV", DbType.DateTime);
                table.AddColumn("ToolingKickOff", DbType.DateTime);
                table.AddColumn("PV", DbType.DateTime);
            });
            
            return 7;
        }
        public int UpdateFrom7()
        {
            SchemaBuilder.AlterTable("ActivityTypeRecord", table =>
            {
                table.AddColumn("VersionNo", DbType.Int32);
            });

            var tableDbName = SchemaBuilder.TableDbName("ActivityTypeRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET VersionNo=1 WHERE IsUsed=1"
                                                    , tableDbName
                                                    , DateTime.Now));
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET VersionNo=0 WHERE IsUsed=0"
                                        , tableDbName
                                        , DateTime.Now));
            return 8;
        }
        public int UpdateFrom8()
        {
            SchemaBuilder.AlterTable("ActivityTypeRecord", table =>
            {
                table.AddColumn("OriginalRecordId", DbType.Int32);
            });

            var tableDbName = SchemaBuilder.TableDbName("ActivityTypeRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET OriginalRecordId=1 WHERE IsUsed=0"
                                                    , tableDbName
                                                    , DateTime.Now));
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET OriginalRecordId=0 WHERE IsUsed=1"
                                        , tableDbName
                                        , DateTime.Now));
            return 9;
        }
        public int UpdateFrom9()
        {
            SchemaBuilder.AlterTable("ADLHourRatioRecord", table =>
            {
                table.AddColumn("VersionNo", DbType.Int32);
            });

            var tableDbName = SchemaBuilder.TableDbName("ADLHourRatioRecord");
            SchemaBuilder.ExecuteSql(string.Format("Update {0} SET VersionNo=1"
                                                    , tableDbName
                                                    , DateTime.Now));
            return 10;
        }

        public int UpdateFrom10()
        {
            _roleService.CreateRole("Viewer");
            _roleService.CreateRole("Engineer");

            return 11;
        }
        public int UpdateFrom11()
        {
            _roleService.CreatePermissionForRole("Viewer", Faurecia.ADL.Permissions.BudgetHome.Name);
            _roleService.CreatePermissionForRole("Viewer", Faurecia.ADL.Permissions.BudgetCompare.Name);
            _roleService.CreatePermissionForRole("Viewer", Faurecia.ADL.Permissions.BudgetView.Name);
            _roleService.CreatePermissionForRole("Viewer", Faurecia.ADL.Permissions.BudgetCompareHeadCount.Name);
            _roleService.CreatePermissionForRole("Viewer", Faurecia.ADL.Permissions.BudgetCompareCost.Name);

            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetHome.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetCreateNew.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetCopyTo.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetDelete.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetQuotation.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetIBP.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetECR.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetCompare.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetView.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetCompareHeadCount.Name);
            _roleService.CreatePermissionForRole("Engineer", Faurecia.ADL.Permissions.BudgetCompareCost.Name);
            return 12;
        }
    }
}