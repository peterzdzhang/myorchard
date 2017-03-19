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
        public static readonly Permission MaintainHourRateBaseline = new Permission { Description = "Maintain hour rate baseline", Name = "MaintainHourRateBaseline" };
        public static readonly Permission MaintainHeadCount = new Permission { Description = "Maintain head count", Name = "MaintainHeadCount" };


     
        public static readonly Permission BudgetCreateNew = new Permission { Description = "Budget Create new", Name = "BudgetCreateNew"};
        public static readonly Permission BudgetCopyTo = new Permission { Description = "Budget Create new by copy", Name = "BudgetCopyTo" };
        public static readonly Permission BudgetDelete = new Permission { Description = "Budget Delete", Name = "BudgetDelete" };
        public static readonly Permission BudgetCompare = new Permission { Description = "Budget Compare", Name = "BudgetCompare" };
        public static readonly Permission BudgetQuotation = new Permission { Description = "Budget Quotation", Name = "BudgetQuotation" };
        public static readonly Permission BudgetIBP = new Permission { Description = "Budget IBP", Name = "BudgetIBP" };
        public static readonly Permission BudgetECR = new Permission { Description = "Budget ECR", Name = "BudgetECR" };
        public static readonly Permission BudgetView = new Permission { Description = "Budget View", Name = "BudgetView" };
        public static readonly Permission BudgetCompareHeadCount = new Permission { Description = "Budget Compare head count", Name = "BudgetCompareHeadCount" };
        public static readonly Permission BudgetCompareCost = new Permission { Description = "Budget Compare cost", Name = "BudgetCompareCost" };

        public static readonly Permission BudgetHome = new Permission
        {
            Description = "Budget Home",
            Name = "BudgetHome",
            ImpliedBy = new[] { BudgetCreateNew, BudgetCopyTo, BudgetDelete, BudgetCompare, BudgetQuotation, BudgetIBP, BudgetECR, BudgetView,BudgetCompareHeadCount,BudgetCompareCost }
        };

        public virtual Feature Feature { get; set; }

        public IEnumerable<Permission> GetPermissions()
        {
            return new[] {
                MaintainHourRateBaseline,
                MaintainWorkingHour,
                MaintainHeadCount,

                BudgetHome,
                BudgetCreateNew,
                BudgetCopyTo,
                BudgetDelete,
                BudgetQuotation,
                BudgetIBP,
                BudgetECR,
                BudgetCompare,
                BudgetView,

                BudgetCompareHeadCount,
                BudgetCompareCost
            };
        }

        public IEnumerable<PermissionStereotype> GetDefaultStereotypes()
        {
            return new[] {
                new PermissionStereotype {
                    Name = "Administrator",
                    Permissions = new[] {
                                            MaintainHourRateBaseline,
                                            MaintainWorkingHour,
                                            MaintainHeadCount,

                                            BudgetHome,
                                            BudgetCreateNew,
                                            BudgetCopyTo,
                                            BudgetDelete,
                                            BudgetQuotation,
                                            BudgetIBP,
                                            BudgetECR,
                                            BudgetCompare,
                                            BudgetView,

                                            BudgetCompareHeadCount,
                                            BudgetCompareCost
                                        }
                }
            };
        }
    }
}