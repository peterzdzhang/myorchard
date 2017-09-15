using Orchard.Themes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Faurecia.FTL.Controllers
{

    [HandleError, Themed]
    public class CreateController : Controller
    {
        // GET: Create
        public ActionResult Index()
        {
            return View();
        }
    }
}