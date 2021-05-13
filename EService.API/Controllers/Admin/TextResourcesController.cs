using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using EService.API.DTO.Admin;
using EService.API.Infrastructure.CustomMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces.Admin;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Controllers.Admin
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize(Roles = "Admin")]
    public class TextResourcesController : BaseController
    {
        private readonly ITextResourcesInterface _textResourcesInterface;
        public TextResourcesController(ITextResourcesInterface textResourcesInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _textResourcesInterface = textResourcesInterface;
        }
        [HttpPost("AddUpdateTextResources")]
        public async Task<IActionResult> Post(AddUpdateTextResourcesDTO dto)
        {
            AddUpdateTextResourcesModel model = new DTOMapper<AddUpdateTextResourcesDTO, AddUpdateTextResourcesModel>().Serialize(dto);
            AdminSpResponse addUpdateTextResourcesResult = await _textResourcesInterface.AddUpdateTextResourcesAsync(model);
            return Ok(new { addUpdateTextResourcesResult });
        }
    }
}