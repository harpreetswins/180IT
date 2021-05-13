using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Middlewares.LanguageMiddleware
{
    public class LanguageProvider : ILanguageProvider
    {
        private readonly IHttpContextAccessor _context;

        public LanguageProvider(IHttpContextAccessor context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public int GetLanguageId()
        {
            return Convert.ToInt32(_context.HttpContext.Request.Headers["LanguageId"]);
        }
    }
}
