using Faurecia.ADL.ViewModels;
using Orchard;
using Orchard.DisplayManagement;
using Orchard.Localization;
using Orchard.Logging;
using Orchard.Security;
using Orchard.Settings;
using Orchard.Themes;
using Orchard.UI.Navigation;
using Orchard.Users.Models;
using Orchard.Users.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Orchard.ContentManagement;
using Orchard.Roles.ViewModels;
using Orchard.Roles.Services;

namespace Faurecia.ADL.Controllers
{
    [HandleError, Themed]
    public class UserRoleController : Controller
    {
        private readonly ISiteService _siteService;
        private readonly IMembershipService _membershipService;
        private readonly IRoleService _roleService;
        private readonly IAuthorizationService _authorizationService;

        public IOrchardServices Services { get; set; }
        public UserRoleController(IOrchardServices orchardService
                        ,ISiteService siteService
                        ,IShapeFactory shapeFactory
                        ,IMembershipService membershipService
                        , IRoleService roleService
                        , IAuthorizationService authorizationService)
        {
            Services = orchardService;
            _siteService = siteService;
            _membershipService = membershipService;
            _roleService = roleService;
            _authorizationService = authorizationService;

            Logger = NullLogger.Instance;
            T = NullLocalizer.Instance;
            Shape = shapeFactory;
        }

        dynamic Shape { get; set; }
        public Localizer T { get; set; }
        public ILogger Logger { get; set; }
        // GET: UserRole
        public ActionResult Index(UserIndexOptions options, PagerParameters pagerParameters)
        {
            if (!Services.Authorizer.Authorize(Orchard.Users.Permissions.ManageUsers, T("Not authorized to list users")))
                return new HttpUnauthorizedResult();

            var pager = new AjaxPager(_siteService.GetSiteSettings(), pagerParameters);

            // default options
            if (options == null)
                options = new UserIndexOptions();

            var users = Services.ContentManager.Query<UserPart, UserPartRecord>();

            switch (options.Filter)
            {
                case UsersFilter.Approved:
                    users = users.Where(u => u.RegistrationStatus == UserStatus.Approved);
                    break;
                case UsersFilter.Pending:
                    users = users.Where(u => u.RegistrationStatus == UserStatus.Pending);
                    break;
                case UsersFilter.EmailPending:
                    users = users.Where(u => u.EmailStatus == UserStatus.Pending);
                    break;
            }

            if (!string.IsNullOrWhiteSpace(options.Search))
            {
                users = users.Where(u => u.UserName.Contains(options.Search) || u.Email.Contains(options.Search));
            }

            var pagerShape = Shape.Pager(pager).TotalItemCount(users.Count());

            switch (options.Order)
            {
                case UsersOrder.Name:
                    users = users.OrderBy(u => u.UserName);
                    break;
                case UsersOrder.Email:
                    users = users.OrderBy(u => u.Email);
                    break;
                case UsersOrder.CreatedUtc:
                    users = users.OrderBy(u => u.CreatedUtc);
                    break;
                case UsersOrder.LastLoginUtc:
                    users = users.OrderBy(u => u.LastLoginUtc);
                    break;
            }

            var results = users
                .Slice(pager.GetStartIndex(), pager.PageSize)
                .ToList();

            var model = new UsersIndexViewModel
            {
                Users = results
                    .Select(x => new UserEntry { User = x.Record })
                    .ToList(),
                Options = options,
                Pager = pagerShape
            };

            // maintain previous route data when generating page links
            var routeData = new RouteData();
            routeData.Values.Add("Options.Filter", options.Filter);
            routeData.Values.Add("Options.Search", options.Search);
            routeData.Values.Add("Options.Order", options.Order);

            pagerShape.RouteData(routeData);

            return View("UserIndex",model);
        }


        public ActionResult RoleIndex()
        {
            if (!Services.Authorizer.Authorize(Orchard.Roles.Permissions.ManageRoles, T("Not authorized to manage roles")))
                return new HttpUnauthorizedResult();

            var model = new RolesIndexViewModel { Rows = _roleService.GetRoles().OrderBy(r => r.Name).ToList() };

            return View("RoleIndex",model);
        }
    }
}