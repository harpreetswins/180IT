using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Middlewares.LanguageMiddleware
{
    public interface ILanguageProvider
    {
        int GetLanguageId();
    }
}