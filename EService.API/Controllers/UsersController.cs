using System.Threading.Tasks;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class UsersController : BaseController
    {
        private readonly IUsersInterface _usersInterface;
        private readonly Custom_Implementation.UsersController CustomUsersController;
        public UsersController(IUsersInterface usersInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _usersInterface = usersInterface;
            CustomUsersController = new Custom_Implementation.UsersController(usersInterface, userProvider, languageProvider);
        }

        [HttpGet("GetUsersList")]
        public async Task<IActionResult> GetUsersListAsync()
        {
            return await CustomUsersController.GetUsersListAsync();
        }
    }
}
