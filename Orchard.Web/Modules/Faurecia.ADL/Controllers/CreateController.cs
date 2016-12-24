using Faurecia.ADL.Models;
using Faurecia.ADL.ViewModels;
using Orchard;
using Orchard.Core.Contents.Controllers;
using Orchard.Data;
using Orchard.DisplayManagement;
using Orchard.Localization;
using Orchard.Logging;
using Orchard.Settings;
using Orchard.Themes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class CreateController : Controller
    {
        private readonly IOrchardServices _orchardService;
        private readonly ISiteService _siteService;
        private readonly IRepository<ADLRecord> _adlRecords;

        public CreateController(IOrchardServices orchardService,
                        ISiteService siteService,
                        IShapeFactory shapeFactory,
                        IRepository<ADLRecord> adlRecords)
        {
            _siteService = siteService;
            _orchardService = orchardService;
            _adlRecords = adlRecords;
            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            New = shapeFactory;
        }

        dynamic New { get; set; }
        public ILogger Logger { get; set; }
        public Localizer T { get; set; }

        
    }
}