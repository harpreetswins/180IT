using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using EService.API.DTO;
using EService.API.DTO.Admin;
using EService.API.Infrastructure.CustomMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response.Admin;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class GroupController : BaseController
    {
        private readonly IGroupInterface _groupInterface;
        private readonly IMapper _mapper;
        public GroupController(IGroupInterface groupInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _groupInterface = groupInterface;
            _mapper = mapper;
        }

        [HttpGet("GetGroupsById")]
        public async Task<IActionResult> GetAsync(int GroupId)
        {
            return Ok(await _groupInterface.GetGroupsById(GroupId));
        }

        [HttpPost]
        public async Task<IActionResult> Post(GroupDTO dto)
        {
            GroupModel model = new DTOMapper<GroupDTO, GroupModel>().Serialize(dto);
            GroupsResponse addGroupResult = await _groupInterface.AddGroupAsync(model);
            return Ok(new { addGroupResult });
        }

        [HttpPut]
        public async Task<IActionResult> Put(GroupDTO dto)
        {
            GroupModel model = new DTOMapper<GroupDTO, GroupModel>().Serialize(dto);
            GroupsResponse updateGroupResult = await _groupInterface.UpdateGroupAsync(model);
            return Ok(new { updateGroupResult });
        }

        [HttpDelete]
        public async Task<IActionResult> Delete([FromQuery] DeleteGroupModel model)
        {
            AdminSpResponse deleteGroupResult = await _groupInterface.DeleteGroup(model);
            return Ok(new { deleteGroupResult });
        }

        [HttpPut("ReorderGroups")]
        public async Task<IActionResult> ReorderGroups([FromQuery] ReorderGroupModel model)
        {
            AdminSpResponse reorderGroupResult = await _groupInterface.ReorderGroupAsync(model);
            return Ok(new { reorderGroupResult });
        }
    }
}
