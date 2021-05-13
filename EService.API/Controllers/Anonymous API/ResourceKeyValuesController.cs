using System.Threading.Tasks;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    public class ResourceKeyValuesController : BaseController
    {
        private readonly IResourceKeyValues _resourceKeyValues;
        private readonly Custom_Implementation.ResourceKeyValuesController CustomResourceKeyValuesController;
        public ResourceKeyValuesController(IResourceKeyValues resourceKeyValues, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _resourceKeyValues = resourceKeyValues;
            CustomResourceKeyValuesController = new Custom_Implementation.ResourceKeyValuesController(resourceKeyValues, userProvider, languageProvider);
        }

        [HttpGet]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        [AllowAnonymous]
        public async Task<IActionResult> Get([FromQuery] string CategoryName)
        {
            return await CustomResourceKeyValuesController.Get(CategoryName);
        }
    }
}
