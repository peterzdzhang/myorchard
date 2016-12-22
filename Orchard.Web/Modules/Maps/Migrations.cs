using System;
using System.Collections.Generic;
using System.Data;
using Orchard.ContentManagement.Drivers;
using Orchard.ContentManagement.MetaData;
using Orchard.ContentManagement.MetaData.Builders;
using Orchard.Core.Contents.Extensions;
using Orchard.Data.Migration;
using Maps.Models;

namespace Maps {
    public class Migrations : DataMigrationImpl {

        public int Create() {
			// Creating table MapRecord
			SchemaBuilder.CreateTable("MapRecord", table => table
				.ContentPartRecord()
				.Column("Latitude", DbType.Double)
				.Column("Longitude", DbType.Double)
			);

            ContentDefinitionManager.AlterPartDefinition(typeof(MapPart).Name, cfg => cfg.Attachable());

            return 1;
        }
    }
}