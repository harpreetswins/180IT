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
    public class ServiceController : BaseController
    {
        private readonly IAddServiceInterface _addServiceInterface;
        private readonly IMapper _mapper;
        public ServiceController(IAddServiceInterface addServiceInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _addServiceInterface = addServiceInterface;
            _mapper = mapper;
        }

        [HttpGet("GetServicesById")]
        public async Task<IActionResult> GetAsync(int ServiceId)
        {
            return Ok(await _addServiceInterface.GetServicesById(ServiceId));
        }

        [HttpPost]
        public async Task<IActionResult> Post(AddServiceDTO dto)
        {
            AddServiceModel model = new DTOMapper<AddServiceDTO, AddServiceModel>().Serialize(dto);
            AdminSpResponse addServiceResult = await _addServiceInterface.AddServiceAsync(model);
            return Ok(new { addServiceResult });
        }

        [HttpPut]
        public async Task<IActionResult> Put(AddServiceDTO dto)
        {
            AddServiceModel model = new DTOMapper<AddServiceDTO, AddServiceModel>().Serialize(dto);
            AdminSpResponse updateServiceResult = await _addServiceInterface.UpdateServicesAsync(model);
            return Ok(new { updateServiceResult });
        }

        [HttpDelete]
        public async Task<IActionResult> Delete([FromQuery] DeleteServiceModel model)
        {
            AdminSpResponse deleteServiceResult = await _addServiceInterface.DeleteService(model);
            return Ok(new { deleteServiceResult });
        }

        [HttpPut("ReorderServices")]
        public async Task<IActionResult> ReorderServices([FromQuery] ReorderServicesModel model)
        {
            AdminSpResponse reorderServiceResult = await _addServiceInterface.ReorderServicesAsync(model);
            return Ok(new { reorderServiceResult });
        }

        [HttpGet("GetAllStageTypes")]
        public async Task<IActionResult> GetAllStageTypesAsync()
        {
            return Ok(await _addServiceInterface.GetAllStageTypesAsync());
        }

        [HttpGet("GetStageActionTypes")]
        public async Task<IActionResult> GetStageActionTypesAsync(int ServiceId)
        {
            return Ok(await _addServiceInterface.GetStageActionTypesAsync(ServiceId));
        }

        [HttpPost("AddStageActions")]
        public async Task<IActionResult> AddStageActionsAsync(AddStageActionsDTO dto)
        {
            AddStageActionModel model = new DTOMapper<AddStageActionsDTO, AddStageActionModel>().Serialize(dto);
            AdminSpResponse addStageActionResult = await _addServiceInterface.AddStageActionsAsync(model);
            return Ok(new { addStageActionResult });
        }

        [HttpPut("UpdateStageActions")]
        public async Task<IActionResult> UpdateStageActionsAsync(AddStageActionsDTO dto)
        {
            AddStageActionModel model = new DTOMapper<AddStageActionsDTO, AddStageActionModel>().Serialize(dto);
            AdminSpResponse updateStageActionResult = await _addServiceInterface.UpdateStageActionsAsync(model);
            return Ok(new { updateStageActionResult });
        }

        [HttpDelete("DeleteStageActions")]
        public async Task<IActionResult> DeleteStageActionsAsync(int stageActionId)
        {
            AdminSpResponse deleteStageActionResult = await _addServiceInterface.DeleteStageActionsAsync(stageActionId);
            return Ok(new { deleteStageActionResult });
        }

        [HttpGet("GetStageActionByStageId")]
        public async Task<IActionResult> GetStageActionByStageIdAsync(int stageId)
        {
            return Ok(await _addServiceInterface.GetStageActionByStageIdAsync(stageId));
        }

        [HttpGet("GetStagesByServiceId")]
        public async Task<IActionResult> GetStagesByServiceIdAsync(int serviceId)
        {
            return Ok(await _addServiceInterface.GetStagesByServiceIdAsync(serviceId));
        }

        [HttpPost("AddUpdateStages")]
        public async Task<IActionResult> AddUpdateStagesAsync(AddUpdateStagesDTO dto)
        {
            AddUpdateStagesModel model = new DTOMapper<AddUpdateStagesDTO, AddUpdateStagesModel>().Serialize(dto);
            AdminSpResponse addUpdateStagesResult = await _addServiceInterface.AddUpdateStagesAsync(model);
            return Ok(new { addUpdateStagesResult });
        }

        [HttpDelete("DeleteStages")]
        public async Task<IActionResult> DeleteStagesAsync(int stageId)
        {
            AdminSpResponse deleteStagesResult = await _addServiceInterface.DeleteStagesAsync(stageId);
            return Ok(new { deleteStagesResult });
        }
        [HttpPut("ReorderStages")]
        public async Task<IActionResult> ReorderStagesAsync([FromQuery] ReorderStagesModel model)
        {
            AdminSpResponse reorderStagesResult = await _addServiceInterface.ReorderStagesAsync(model);
            return Ok(new { reorderStagesResult });
        }
    }
}
