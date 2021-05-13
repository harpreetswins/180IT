using System.Threading.Tasks;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class LanguageController 
    {
        private readonly ILanguageInterface _languageInterface;
        private readonly Default_Implementation.LanguageController DefaultLanguageController;
        public LanguageController(ILanguageInterface languageInterface, IUserProvider userProvider, ILanguageProvider languageProvider) 
        {
            _languageInterface = languageInterface;
            DefaultLanguageController = new Default_Implementation.LanguageController(languageInterface, userProvider, languageProvider);
        }
        public async Task<IActionResult> Get()
        {
            return await DefaultLanguageController.Get();
        }
    }
}
