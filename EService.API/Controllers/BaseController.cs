using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using System;

namespace EService.API.Controllers
{
    public class BaseController : ControllerBase
    {
        protected readonly IUserProvider _userProvider;
        protected readonly ILanguageProvider _languageProvider;

        public BaseController(IUserProvider userProvider, ILanguageProvider languageProvider)
        {
            _userProvider = userProvider;
            _languageProvider = languageProvider;
        }
    }
}