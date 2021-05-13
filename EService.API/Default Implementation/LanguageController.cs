using System;
using System.Threading.Tasks;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.Exceptions;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Default_Implementation
{
    public class LanguageController : BaseController
    {
        private readonly ILanguageInterface _languageInterface;
        public LanguageController(ILanguageInterface languageInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _languageInterface = languageInterface;
        }
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Get()
        {
            try
            {
                return Ok(await _languageInterface.LanguageListAsync());
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }
    }
}
