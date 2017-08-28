using Orchard.Environment.Extensions.Models;
using Orchard.Security.Permissions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Faurecia.FTL
{
    public class Permissions: IPermissionProvider
    {
        public static readonly Permission FTLCreateNew = new Permission { Description = "FTL Create new", Name = "FTLCreateNew" };

        public static readonly Permission FTLHome = new Permission
        {
            Description = "FTL Home",
            Name = "FTLHome",
            ImpliedBy = new[] { FTLCreateNew }
        };

        public virtual Feature Feature { get; set; }

        public IEnumerable<Permission> GetPermissions()
        {
            return new[] {
                FTLHome,
                FTLCreateNew
            };
        }

        public IEnumerable<PermissionStereotype> GetDefaultStereotypes()
        {
            return new[] {
                new PermissionStereotype {
                    Name = "Administrator",
                    Permissions = new[] {
                                            FTLHome,
                                            FTLCreateNew
                                        }
                },
                new PermissionStereotype {
                    Name = "Engineer",
                    Permissions = new[] {
                                            FTLHome,
                                            FTLCreateNew
                                        }
                },
                new PermissionStereotype {
                    Name = "Viewer",
                    Permissions = new[] {
                                            FTLHome
                                        }
                }
            };
        }
    }
}