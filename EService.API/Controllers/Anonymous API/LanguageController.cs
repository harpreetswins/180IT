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
    public class LanguageController : BaseController
    {
        private readonly ILanguageInterface _languageInterface;
        private readonly Default_Implementation.LanguageController DefaultLanguageController;
        public LanguageController(ILanguageInterface languageInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _languageInterface = languageInterface;
            DefaultLanguageController = new Default_Implementation.LanguageController(languageInterface, userProvider, languageProvider);
        }
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Get()
        {
            return await DefaultLanguageController.Get();
        }
    }
}
