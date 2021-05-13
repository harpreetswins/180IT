using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Middlewares.JwtMiddleware
{
    public interface IUserProvider
    {
        string GetUserId();
        List<string> GetUserRoles();
        string GetUserName();
    }
}

public class Roles
{
    public string Role { get; set; }
}