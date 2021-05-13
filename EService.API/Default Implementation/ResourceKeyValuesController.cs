using System;
using System.Threading.Tasks;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Default_Implementation
{
    public class ResourceKeyValuesController : BaseController
    {
        private readonly IResourceKeyValues _resourceKeyValues;
        public ResourceKeyValuesController(IResourceKeyValues resourceKeyValues, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _resourceKeyValues = resourceKeyValues;
        }

        [HttpGet]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        [AllowAnonymous]
        public async Task<IActionResult> Get([FromQuery] string CategoryName)
        {
            GetResourceKeyValuesDTO dto = new GetResourceKeyValuesDTO();
           
            int LanguageId = _languageProvider.GetLanguageId();
            dto.CategoryName = CategoryName;
            dto.LanguageId = LanguageId;
            return Ok(await _resourceKeyValues.ResourceKeyValuesListAsync(dto));
        }
    }
}
