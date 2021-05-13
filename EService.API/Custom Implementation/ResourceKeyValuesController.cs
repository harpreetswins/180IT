using System.Threading.Tasks;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class ResourceKeyValuesController
    {
        private readonly IResourceKeyValues _resourceKeyValues;
        private readonly Default_Implementation.ResourceKeyValuesController DefaultResourceKeyValuesController;
        public ResourceKeyValuesController(IResourceKeyValues resourceKeyValues, IUserProvider userProvider, ILanguageProvider languageProvider) 
        {
            _resourceKeyValues = resourceKeyValues;
            DefaultResourceKeyValuesController = new Default_Implementation.ResourceKeyValuesController(resourceKeyValues, userProvider, languageProvider);
        }
        public async Task<IActionResult> Get([FromQuery] string CategoryName)
        {
            return await DefaultResourceKeyValuesController.Get(CategoryName);
        }
    }
}
