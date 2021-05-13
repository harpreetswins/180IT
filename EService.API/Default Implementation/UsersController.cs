using System.Threading.Tasks;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Default_Implementation
{
    public class UsersController : BaseController
    {
        private readonly IUsersInterface _usersInterface;
        public UsersController(IUsersInterface usersInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _usersInterface = usersInterface;
        }

        [HttpGet("GetUsersList")]
        public async Task<IActionResult> GetUsersListAsync()
        {
            return Ok(await _usersInterface.GetUsersListAsync());
        }
    }
}
