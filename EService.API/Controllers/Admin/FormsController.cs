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
    public class FormsController : BaseController
    {
        private readonly IFormsInterface _formsInterface;
        private readonly IMapper _mapper;
        public FormsController(IFormsInterface formsInterface, IMapper mapper,IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _formsInterface = formsInterface;
            _mapper = mapper;
        }

        [HttpPost("AddUpdateForms")]
        public async Task<IActionResult> Post(AddUpdateFormsDTO dto)
        {
            AddUpdateFormsModel model = new DTOMapper<AddUpdateFormsDTO, AddUpdateFormsModel>().Serialize(dto);
            AdminSpResponse addFormsResult = await _formsInterface.AddUpdateFormsAsync(model);
            return Ok(new { addFormsResult });
        }

        [HttpGet("GetStageForms")]
        public async Task<IActionResult> GetStageFormsAsync()
        {
            return Ok(await _formsInterface.GetStageFormsAsync());
        }

        [HttpPost("LinkUnlinkStageForms")]
        public async Task<IActionResult> LinkUnlinkStageForms(LinkUnlinkStageFormDTO dto)
        {
            LinkUnlinkStageFormsModel payload = _mapper.Map<LinkUnlinkStageFormDTO, LinkUnlinkStageFormsModel>(dto);
            AdminSpResponse result = await _formsInterface.LinkUnlinkStageFormsAsync(payload);
            return Ok(new { result });
        }

        [HttpPost("AddUpdateFormSections")]
        public async Task<IActionResult> AddUpdateFormSectionsAsync(AddUpdateFormSectionDTO dto)
        {
            AddUpdateFormSectionModel model = new DTOMapper<AddUpdateFormSectionDTO, AddUpdateFormSectionModel>().Serialize(dto);
            AdminSpResponse addFormSectionsResult = await _formsInterface.AddUpdateFormSectionsAsync(model);
            return Ok(new { addFormSectionsResult });
        }

        [HttpGet("GetFormSectionsByFormId")]
        public async Task<IActionResult> GetFormSectionsByFormIdAsync([FromQuery] GetFormSectionsByFormIdDTO dto)
        {
            return Ok(await _formsInterface.GetFormSectionsByFormIdAsync(dto));
        }

        [HttpGet("GetLookupFieldTypes")]
        public async Task<IActionResult> GetLookupFieldTypesAsync()
        {
            return Ok(await _formsInterface.GetLookupFieldTypesAsync());
        }

        [HttpDelete("DeleteFormSection")]
        public async Task<IActionResult> DeleteFormSectionAsync([FromQuery] DeleteFormSectionModel model)
        {
            AdminSpResponse deleteFormSectionResult = await _formsInterface.DeleteFormSectionAsync(model);
            return Ok(new { deleteFormSectionResult });
        }

        [HttpPost("AddUpdateFormSectionAttachments")]
        public async Task<IActionResult> AddUpdateFormSectionAttachmentsAsync(AddUpdateFormSectionAttachmentsDTO dto)
        {
            AddUpdateFormSectionAttachmentsModel model = new DTOMapper<AddUpdateFormSectionAttachmentsDTO, AddUpdateFormSectionAttachmentsModel>().Serialize(dto);
            AdminSpResponse addFormSectionAttachmentsResult = await _formsInterface.AddUpdateFormSectionAttachmentsAsync(model);
            return Ok(new { addFormSectionAttachmentsResult });
        }

        [HttpDelete("DeleteFormSectionAttachments")]
        public async Task<IActionResult> DeleteFormSectionAttachmentsAsync([FromQuery] DeleteFormSectionAttachmentsModel model)
        {
            AdminSpResponse deleteFormSectionAttachmentsResult = await _formsInterface.DeleteFormSectionAttachmentsAsync(model);
            return Ok(new { deleteFormSectionAttachmentsResult });
        }

        [HttpPost("AddUpdateStageFormMode")]
        public async Task<IActionResult> AddUpdateStageFormModeAsync(AddUpdateStageFormModeDTO dto)
        {
            AddUpdateStageFormModeModel payload = _mapper.Map<AddUpdateStageFormModeDTO, AddUpdateStageFormModeModel>(dto);
            AdminSpResponse result = await _formsInterface.AddUpdateStageFormModeAsync(payload);
            return Ok(new { result });
        }
    }
}
