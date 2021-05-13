using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Middlewares.JwtMiddleware
{
    public class UserProvider : IUserProvider
    {
        private readonly IHttpContextAccessor _context;

        public UserProvider(IHttpContextAccessor context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public string GetUserId()
        {
            return _context.HttpContext.User.Claims.First(i => i.Type == ClaimTypes.NameIdentifier).Value;
        }

        public string GetUserName()
        {
            return _context.HttpContext.User.Claims.First(i => i.Type == "FullName").Value;
        }

        public List<string> GetUserRoles()
        {
            List<string> roles = new List<string>();
            var role = _context.HttpContext.User.Claims.Where(i => i.Type == ClaimTypes.Role).ToList();
            foreach (var item in role)
            {
                roles.Add(item.Value);
            }
            return roles;
        }
    }
}
