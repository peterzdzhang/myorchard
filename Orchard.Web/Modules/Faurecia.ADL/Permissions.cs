using Orchard.Environment.Extensions.Models;
using Orchard.Security.Permissions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.ADL
{
    public class Permissions: IPermissionProvider
    {
        public static readonly Permission MaintainWorkingHour = new Permission { Description = "Maintain working hours", Name = "MaintainWorkingHours" };

        public virtual Feature Feature { get; set; }

        public IEnumerable<Permission> GetPermissions()
        {
            return new[] {
                MaintainWorkingHour,
            };
        }

        public IEnumerable<PermissionStereotype> GetDefaultStereotypes()
        {
            return new[] {
                new PermissionStereotype {
                    Name = "Administrator",
                    Permissions = new[] { MaintainWorkingHour }
                },
            };
        }
    }
}