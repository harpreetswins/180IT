using System.Threading.Tasks;
using AutoMapper;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Default_Implementation
{
    public class ServicesController : BaseController
    {
        private readonly IServiceInterface _serviceInterface;
        private readonly IUserPermissionServiceInterface _userPermissionServiceInterface;
        private readonly IMapper _mapper;
        public ServicesController(IServiceInterface serviceInterface, IUserPermissionServiceInterface userPermissionServiceInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _mapper = mapper;
            _serviceInterface = serviceInterface;
            _userPermissionServiceInterface = userPermissionServiceInterface;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            return Ok(await _serviceInterface.ServiceListAsync());
        }

        [HttpGet("CheckPermission")]
        public async Task<IActionResult> CheckPermissionAsync([FromQuery] CheckServicePermissionDTO model)
        {
            BaseCheckServicePermissionDTO dto = new BaseCheckServicePermissionDTO();
            var rolesList = this._userProvider.GetUserRoles();
            var roles = string.Join(",", rolesList);
            dto.ServiceId = model.ServiceId;
            dto.StageActionId = model.StageActionId;
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.Role = roles;
            return Ok(await _userPermissionServiceInterface.UserPermissionsForServiceAsync(dto));
        }

        [HttpGet("GetServiceProfileData")]
        public async Task<IActionResult> GetServiceProfileDataAsync([FromQuery] ServiceProfileDataDTO model)
        {
            BaseServiceProfileDataDTO dto = new BaseServiceProfileDataDTO();

            dto.ServiceId = model.ServiceId;
            dto.ProfileAppId = model.ProfileAppId;
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            return Ok(await _serviceInterface.GetServiceProfileDataAsync(dto));
        }
        [HttpGet("GetSearchRelatedRecords")]
        public async Task<IActionResult> GetSearchRelatedRecordsAsync([FromQuery] ServiceRelatedDataDTO model)
        {
            BaseServiceRelatedDataDTO dto = new BaseServiceRelatedDataDTO();

            dto.FormSectionFieldId = model.FormSectionFieldId;
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            return Ok(await _serviceInterface.GetSearchRelatedRecordsAsync(dto));
        }
    }
}
