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
using Orchard.Data;
using Orchard.Roles.Models;
using Orchard.Security.Permissions;

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

            if (Request.IsAjaxRequest())
            {
                return PartialView("_Users", model);
            }

            return View("UserIndex",model);
        }


        public ActionResult RoleIndex()
        {
            if (!Services.Authorizer.Authorize(Orchard.Roles.Permissions.ManageRoles, T("Not authorized to manage roles")))
                return new HttpUnauthorizedResult();

            var model = new RolesIndexViewModel { Rows = _roleService.GetRoles().OrderBy(r => r.Name).ToList() };
            if (Request.IsAjaxRequest())
            {
                return PartialView("_Roles", model);
            }
            return View("RoleIndex",model);
        }

        public ActionResult CreateRole()
        {
            if (!Services.Authorizer.Authorize(Orchard.Roles.Permissions.ManageRoles, T("Not authorized to manage roles")))
                return new HttpUnauthorizedResult();

            var viewModel = new RoleEditViewModel
            {
                Name = string.Empty,
                Id = 0,
                RoleCategoryPermissions = GetFaureciaPermissions(),
                CurrentPermissions = new List<string>()
            };
            return PartialView("_EditRole", viewModel);
        }
        
        public ActionResult EditRole(int id)
        {
            if (!Services.Authorizer.Authorize(Orchard.Roles.Permissions.ManageRoles, T("Not authorized to manage roles")))
                return new HttpUnauthorizedResult();


            var role = _roleService.GetRole(id);
            if (role == null)
            {
                return HttpNotFound();
            }

            var viewModel = new RoleEditViewModel
            {
                Name = role.Name,
                Id = role.Id,
                RoleCategoryPermissions = GetFaureciaPermissions(),
                CurrentPermissions = _roleService.GetPermissionsForRole(id)
            };

            //var simulation = UserSimulation.Create(role.Name);
            //viewModel.EffectivePermissions = viewModel.RoleCategoryPermissions
            //    .SelectMany(group => group.Value)
            //    .Where(permission => _authorizationService.TryCheckAccess(permission, simulation, null))
            //    .Select(permission => permission.Name)
            //    .Distinct()
            //    .ToList();
            
            return PartialView("_EditRole", viewModel);
        }

        public ActionResult DeleteRole(int id)
        {
            _roleService.DeleteRole(id);
            return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult RoleBulkAction(IList<int> ids, string actionName)
        {
            actionName = actionName == null ? string.Empty : actionName.Trim();
            if (actionName.Equals("Delete", StringComparison.InvariantCultureIgnoreCase))
            {
                foreach (var id in ids)
                {
                    _roleService.DeleteRole(id);
                }
                return Json(new { Code = 0, Message = T("Delete success.").Text }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { Code = 0, Message = T("success.").Text }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveRole()
        {
            if (!Services.Authorizer.Authorize(Orchard.Roles.Permissions.ManageRoles, T("Not authorized to manage roles")))
                return new HttpUnauthorizedResult();

            var viewModel = new RoleEditViewModel();
            TryUpdateModel(viewModel);

            if (String.IsNullOrEmpty(viewModel.Name))
            {
                return Json(new { Code = 1000, Message = T("Role name can't be empty.").Text }, JsonRequestBehavior.AllowGet);
            }

            if (viewModel.Id != 0)
            {
                var role = _roleService.GetRoleByName(viewModel.Name);
                if (role != null  && role.Id!=viewModel.Id)
                {
                    return Json(new { Code = 1001, Message = T("Role with same name already exists.").Text }, JsonRequestBehavior.AllowGet);
                }

                List<string> rolePermissions = new List<string>();
                foreach (string key in Request.Form.Keys)
                {
                    if (key.StartsWith("Checkbox.") && Request.Form[key] == "true")
                    {
                        string permissionName = key.Substring("Checkbox.".Length);
                        rolePermissions.Add(permissionName);
                    }
                }
                _roleService.UpdateRole(viewModel.Id, viewModel.Name, rolePermissions);
            }
            else
            {
                var role = _roleService.GetRoleByName(viewModel.Name);
                if (role != null)
                {
                    return Json(new { Code = 1001, Message = T("Role with same name already exists.").Text }, JsonRequestBehavior.AllowGet);
                }

                _roleService.CreateRole(viewModel.Name);
                foreach (string key in Request.Form.Keys)
                {
                    if (key.StartsWith("Checkbox.") && Request.Form[key] == "true")
                    {
                        string permissionName = key.Substring("Checkbox.".Length);
                        _roleService.CreatePermissionForRole(viewModel.Name, permissionName);
                    }
                }
            }
            return Json(new { Code = 0, Message = T("Save success.").Text }, JsonRequestBehavior.AllowGet);
        }


        private IDictionary<string, IEnumerable<Permission>> GetFaureciaPermissions()
        {
            var dic = _roleService.GetInstalledPermissions();

            var queries = from item in dic
                          where item.Key.StartsWith("Faurecia.")
                          select item;

            IDictionary<string, IEnumerable<Permission>> results = new Dictionary<string, IEnumerable<Permission>>();
            foreach(var item in queries)
            {
                results.Add(item.Key, item.Value);
            }

            return results;
        }
    }
}