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

        public static readonly Permission CompareHeadCount = new Permission { Description = "Compare head count", Name = "CompareHeadCount" };

        public virtual Feature Feature { get; set; }

        public IEnumerable<Permission> GetPermissions()
        {
            return new[] {
                MaintainWorkingHour,
                CompareHeadCount
            };
        }

        public IEnumerable<PermissionStereotype> GetDefaultStereotypes()
        {
            return new[] {
                new PermissionStereotype {
                    Name = "Administrator",
                    Permissions = new[] { MaintainWorkingHour }
                },
                 new PermissionStereotype {
                    Name = "Administrator",
                    Permissions = new[] { CompareHeadCount }
                },
            };
        }
    }
}