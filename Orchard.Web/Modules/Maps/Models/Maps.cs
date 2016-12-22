using Orchard.ContentManagement;
using Orchard.ContentManagement.Records;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Maps.Models
{
    public class MapRecord:ContentPartRecord
    {
        public virtual double Latitude { get; set; }
        public virtual double Longitude { get; set; } 
    }


    public class MapPart : ContentPart<MapRecord>
    {
        [Required]
        public double Latitude
        {
            get { return Retrieve(r => r.Latitude,0); }
            set { Store(r => r.Latitude, value); }
        }
        [Required]
        public double Longitude
        {
            get { return Retrieve(r => r.Longitude,0); }
            set { Store(r => r.Longitude, value); }
        }
    }
}