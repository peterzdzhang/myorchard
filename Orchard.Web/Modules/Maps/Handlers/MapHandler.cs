using Maps.Models;
using Orchard.ContentManagement.Handlers;
using Orchard.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Maps.Handlers
{
    public class MapHandler:ContentHandler
    {
        public MapHandler(IRepository<MapRecord> repository)
        {
            Filters.Add(StorageFilter.For(repository));
        }
    }
}