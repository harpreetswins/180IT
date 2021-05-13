using System;
using AutoMapper;
using System.Threading.Tasks;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Mvc;
using EService.API.DTO.Services;
using Microsoft.AspNetCore.Http;
using EService.API.DTO.Applications;
using EService.API.Infrastructure.CustomMapper;
using EService.API.Infrastructure.Middlewares.Exceptions;
using EService.API.Infrastructure.Middlewares.ErrorDetail;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;

namespace EService.API.Default_Implementation
{
    public class ApplicationController : BaseController
    {
        private readonly IApplicationInterface _applicationInterface;
        private readonly IMapper _mapper;
        public ApplicationController(IApplicationInterface applicationInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _applicationInterface = applicationInterface;
            _mapper = mapper;
        }
            
        [HttpGet]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAsync([FromQuery] ApplicationFormDTO model)
        {
            BaseApplicationFormDTO dto = new BaseApplicationFormDTO();
            var rolesList = this._userProvider.GetUserRoles();           
            var roles = string.Join(",", rolesList);
            dto.ApplicationId = model.ApplicationId;
            dto.StageId = model.StageId;
            dto.Role = roles;
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            return Ok(await _applicationInterface.ApplicationFormsAsync(dto));
        }

        [HttpGet("GetApplicationChildForm")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationChildForm([FromQuery] ChildFormDTO model)
        {
            return Ok(await _applicationInterface.ApplicationChildFormAsync(model));
        }

        [HttpGet("ApplicationCurrentStage")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationCurrentStage(int ApplicationId)
        {
            return Ok(await _applicationInterface.ApplicationCurrentStageAsync(ApplicationId));
        }
        [HttpPost]
        public async Task<IActionResult> Post(BaseCreateApplicationDTO model)
        {
            CreateApplicationDTO DTO = new CreateApplicationDTO();
            DTO.ClientIP = "1.0.0.0";
            DTO.CreatorId = this._userProvider.GetUserId();
            DTO.CreatorName = this._userProvider.GetUserName();
            DTO.ParentApplication = model.ParentApplication ?? 0;
            DTO.ServiceId = model.ServiceId;
            DTO.UserAgent = "Chrome";
            DTO.ProfileAppId = model.ProfileAppId;

            ApplicationModel payload = _mapper.Map<CreateApplicationDTO, ApplicationModel>(DTO);
            SpResponse addApplicationResult = await _applicationInterface.AddApplicationAsync(payload);
            return Ok(new { addApplicationResult });
        }
        [HttpPost("ExecuteAction")]
        public async Task<IActionResult> ExecuteActionAsync(BaseExecuteActionDTO model)
        {           
            ExecuteActionDTO DTO = new ExecuteActionDTO();
            DTO.ApplicationId = model.ApplicationId;
            DTO.StageActionId = model.StageActionId;
            DTO.UserId = this._userProvider.GetUserId();
            DTO.CreatorName = this._userProvider.GetUserName();
            DTO.Comments = model.Comments;
            DTO.Data = model.Data;
            DTO.Users = model.Users;
            ExecuteActionModel payload = new DTOMapper<ExecuteActionDTO, ExecuteActionModel>().Serialize(DTO);
            try
            {
                SpResponse executeActionResult = await _applicationInterface.ExecuteActionAsync(payload);
                return Ok(new { executeActionResult });
            }
            catch (Exception ex)
            {
                throw new BadRequestException(new EServiceCustomException(ex.Message, model.ApplicationId, 34, 2, 2).ToString());
            }           
        }
        [HttpGet("UserApplicationDetails")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationDetailsAsync([FromQuery] int ApplicationId)
        {
            UserApplicationDetailsDTO dto = new UserApplicationDetailsDTO();

            dto.ApplicationId = ApplicationId;
            dto.UserId = this._userProvider.GetUserId();   
            dto.CreatorName = this._userProvider.GetUserName();   
            return Ok(await _applicationInterface.UserApplicationDetailsAsync(dto));
        }
        [HttpGet("UserApplicationLists")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationListAsync([FromQuery] BaseUserApplicationListDTO model)
        {
            UserApplicationListDTO dto = new UserApplicationListDTO();
            var rolesList = this._userProvider.GetUserRoles();           
            var roles = string.Join(",", rolesList);
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.Role = roles;
            dto.Mode = model.Mode;
            dto.ServiceId = model.ServiceId;
            dto.StageId = model.StageId;
            dto.StageStatusId = model.StageStatusId;
            dto.PageNumber = model.PageNumber;
            dto.PageSize = model.PageSize;
            dto.Start = model.Start;
            dto.End = model.End;
            dto.Search = model.Search;
            return Ok(await _applicationInterface.UserApplicationListAsync(dto));
        }
        [HttpGet("UserApplicationCategories")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationCategoriesAsync(string mode)
        {
            UserApplicationCategoriesDTO dto = new UserApplicationCategoriesDTO();
            var rolesList = this._userProvider.GetUserRoles();           
            var roles = string.Join(",", rolesList);
            dto.UserId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.Mode = mode;
            dto.Role = roles;
            return Ok(await _applicationInterface.UserApplicationCategoriesAsync(dto));
        }

          [HttpGet("UserApplicationCertificateCategories")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationCertificateCategoriesAsync(string mode)
        {
            UserApplicationCategoriesDTO dto = new UserApplicationCategoriesDTO();
            var rolesList = this._userProvider.GetUserRoles();           
            var roles = string.Join(",", rolesList);
            dto.UserId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.Mode = mode;
            dto.Role = roles;
            return Ok(await _applicationInterface.UserApplicationCertificateCategoriesAsync(dto));
        }

        [HttpGet("EntityFieldLookups")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> EntityFieldLookupsAsync([FromQuery] EntityFieldLookupsDTO model)
        {
            BaseEntityFieldLookups dto = new BaseEntityFieldLookups();

            int LanguageId = _languageProvider.GetLanguageId();
            dto.FormId = model.FormId;
            dto.LanguageId = LanguageId;
            dto.ServiceId = model.ServiceId;
            return Ok(await _applicationInterface.EntityFieldLookupsAsync(dto));
        }

        [HttpGet("GetChildEntityFieldLookups")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetChildEntityFieldLookups([FromQuery] ChildEntityFieldLookupsDTO model)
        {
            BaseChildEntityFieldLookups dto = new BaseChildEntityFieldLookups();

            int LanguageId = _languageProvider.GetLanguageId();
            dto.FormSectionParentId = model.FormSectionParentId;
            dto.LanguageId = LanguageId;
            dto.ServiceId = model.ServiceId;
            return Ok(await _applicationInterface.GetChildEntityFieldLookupsAsync(dto));
        }

        [HttpGet("CurrentApplicationStatus")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> CurrentApplicationStatusAsync([FromQuery] CurrentApplicationStatusDTO model)
        {
            BaseCurrentApplicationStatus dto = new BaseCurrentApplicationStatus();

            dto.ApplicationId = model.ApplicationId;
            dto.UserId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            return Ok(await _applicationInterface.CurrentApplicationStatusAsync(dto));
        }

        [HttpGet("CascadedLookups")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> CascadedLookupsAsync([FromQuery] CascadedLookupDTO model)
        {
            BaseCascadedLookup dto = new BaseCascadedLookup();

            int LanguageId = _languageProvider.GetLanguageId();
            dto.EntityFieldId = model.EntityFieldId;
            dto.LanguageId = LanguageId;
            dto.Value = model.Value;
            dto.LookupParentId = model.LookupParentId;
            return Ok(await _applicationInterface.CascadedLookupsAsync(dto));
        }
        [HttpGet("GetApplicationActivityLogs")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationActivityLogsAsync([FromQuery] int ApplicationId)
        {
            ActivityLogDTO dto = new ActivityLogDTO();

            dto.ApplicationId = ApplicationId;
            dto.UserId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            return Ok(await _applicationInterface.ActivityLogsAsync(dto));
        }

        [HttpGet("GetApplicationsCounts")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationsCountsAsync()
        {
            ApplicationsCountsDTO dto = new ApplicationsCountsDTO();
            var rolesList = this._userProvider.GetUserRoles();           
            var roles = string.Join(",", rolesList);
            dto.UserId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.Role = roles;
            return Ok(await _applicationInterface.GetApplicationsCountsAsync(dto));
        }
    }
}
