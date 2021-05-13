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
    public class EntityController : BaseController
    {
        private readonly IEntityInterface _entityInterface;
        private readonly IMapper _mapper;
        public EntityController(IEntityInterface entityInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _entityInterface = entityInterface;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            return Ok(await _entityInterface.GetAllEntities());
        }

        [HttpPost("AddUpdateEntities")]
        public async Task<IActionResult> Post(AddUpdateEntitiesDTO dto)
        {
            AddUpdateEntitiesModel model = new DTOMapper<AddUpdateEntitiesDTO, AddUpdateEntitiesModel>().Serialize(dto);
            AdminSpResponse addEntitiesResult = await _entityInterface.AddUpdateEntitiesAsync(model);
            return Ok(new { addEntitiesResult });
        }

        [HttpGet("GetAdminRoles")]
        public async Task<IActionResult> GetAdminRolesAsync()
        {
            return Ok(await _entityInterface.GetAdminRolesAsync());
        }

        [HttpPost("AddUpdateEntityFields")]
        public async Task<IActionResult> AddUpdateEntityFieldsAsync(AddUpdateEntityFieldsDTO dto)
        {
            AddUpdateEntityFieldsModel model = new DTOMapper<AddUpdateEntityFieldsDTO, AddUpdateEntityFieldsModel>().Serialize(dto);
            AdminSpResponse addEntityFieldsResult = await _entityInterface.AddUpdateEntityFieldsAsync(model);
            return Ok(new { addEntityFieldsResult });
        }

        [HttpPost("LinkUnlinkFormSectionFields")]
        public async Task<IActionResult> LinkUnlinkFormSectionFieldsAsync(LinkUnlinkFormSectionFieldsDTO dto)
        {
            LinkUnlinkFormSectionFieldsModel payload = _mapper.Map<LinkUnlinkFormSectionFieldsDTO, LinkUnlinkFormSectionFieldsModel>(dto);
            AdminSpResponse result = await _entityInterface.LinkUnlinkFormSectionFieldsAsync(payload);
            return Ok(new { result });
        }

        [HttpGet("GetFieldConstraintTypes")]
        public async Task<IActionResult> GetFieldConstraintTypesAsync()
        {
            return Ok(await _entityInterface.GetFieldConstraintTypesAsync());
        }
    }
}
