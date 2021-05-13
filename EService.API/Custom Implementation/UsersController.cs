using System.Threading.Tasks;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class UsersController
    {
        private readonly IUsersInterface _usersInterface;
        private readonly Default_Implementation.UsersController DefaultUsersController;
        public UsersController(IUsersInterface usersInterface, IUserProvider userProvider, ILanguageProvider languageProvider)
        {
            _usersInterface = usersInterface;
            DefaultUsersController = new Default_Implementation.UsersController(usersInterface, userProvider, languageProvider);
        }
        public async Task<IActionResult> GetUsersListAsync()
        {
            return await DefaultUsersController.GetUsersListAsync();
        }
    }
}
