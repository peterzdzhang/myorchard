using Faurecia.ADL.Models;
using Orchard.Roles.ViewModels;
using Orchard.Users.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Faurecia.ADL.ViewModels
{
    public class UserViewModel: UserCreateViewModel
    {
        public UserViewModel()
        {
            Roles = new List<UserRoleEntry>();
        }

        public int Id { get; set; }

        public IList<UserRoleEntry> Roles { get; set; }
        
    }
    
}