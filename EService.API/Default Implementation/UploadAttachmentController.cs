using System.IO;
using AutoMapper;
using System.Threading.Tasks;
using EService.API.DTO.Applications;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using EService.Domain.DomainModels.UploadAttachments;
using EService.Domain.DomainModels.Response;
using Microsoft.AspNetCore.Http;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;

namespace EService.API.Default_Implementation
{
    public class UploadAttachmentController : BaseController
    {
        private readonly IUploadAttachments _uploadAttachments;
        private readonly IMapper _mapper;
        public UploadAttachmentController(IUploadAttachments uploadAttachments, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _uploadAttachments = uploadAttachments;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> GetAsync([FromQuery] GetAttachmentDTO model)
        {
            return Ok(await _uploadAttachments.GetAttachmentAsync(model));
        }

        [HttpGet("GetAttachmentById")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAttachmentByIdAsync(int attachmentId)
        {
            return Ok(await _uploadAttachments.GetAttachmentByIdAsync(attachmentId));
        }

        [HttpPost]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> Post([FromForm] BaseUploadAttachmentDTO model)
        {
            UploadAttachmentDTO DTO = new UploadAttachmentDTO();
            using (var target = new MemoryStream())
            {
                model.files.CopyTo(target);
                DTO.Image = target.ToArray();
            }
            DTO.FileName = model.files.FileName;
            DTO.Extension = model.files.ContentType;
            DTO.Size = model.files.Length;
            DTO.MimeType = model.files.Name;
            DTO.ApplicationId = model.ApplicationId;
            DTO.ApplicationStageId = model.ApplicationStageId;
            DTO.AttachmentTypeId = model.AttachmentTypeId;
            DTO.AttachmentId = model.AttachmentId;
            DTO.CreatorId = this._userProvider.GetUserId();
            DTO.CreatorName = this._userProvider.GetUserName();
            DTO.ItemIndex = model.ItemIndex;
            UploadAttachmentModel payload = _mapper.Map<UploadAttachmentDTO, UploadAttachmentModel>(DTO);
            SpResponse uploadResult = await _uploadAttachments.UploadAttachmentAsync(payload);
            return Ok(new { uploadResult });
        }
        [HttpDelete]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> DeleteAsync(int attachmentId)
        {
            SpResponse deleteResult = await _uploadAttachments.DeleteAsync(attachmentId);
            return Ok(new { deleteResult });
        }

        [HttpPost("UploadActionAttachments")]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> UploadActionAttachmentsAsync([FromForm] BaseUploadActionAttachmentDTO model)
        {
            UploadActionAttachmentDTO DTO = new UploadActionAttachmentDTO();
            using (var target = new MemoryStream())
            {
                model.files.CopyTo(target);
                DTO.Image = target.ToArray();
            }
            DTO.FileName = model.files.FileName;
            DTO.Extension = model.files.ContentType;
            DTO.Size = model.files.Length;
            DTO.MimeType = model.files.Name;
            DTO.ApplicationId = model.ApplicationId;
            DTO.ApplicationStageId = model.ApplicationStageId;
            DTO.CreatorId = this._userProvider.GetUserId();
            DTO.CreatorName = this._userProvider.GetUserName();
            DTO.ItemIndex = model.ItemIndex;
            DTO.ActionTypeId = model.ActionTypeId;
            DTO.AppStageActionId = model.AppStageActionId;
            UploadActionAttachmentsModel payload = _mapper.Map<UploadActionAttachmentDTO, UploadActionAttachmentsModel>(DTO);
            SpResponse uploadActionResult = await _uploadAttachments.UploadActionAttachmentAsync(payload);
            return Ok(new { uploadActionResult });
        }
        [HttpGet("GetActionAttachmentById")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetActionAttachmentByIdAsync([FromQuery] GetActionAttachmentDTO model)
        {
            return Ok(await _uploadAttachments.GetActionAttachmentByIdAsync(model));
        }

        [HttpDelete("DeleteActionAttachment")]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> DeleteActionAttachmentAsync([FromQuery] GetActionAttachmentDTO model)
        {
            SpResponse deleteActionAttachmentResult = await _uploadAttachments.DeleteActionAttachmentAsync(model);
            return Ok(new { deleteActionAttachmentResult });
        }
    }
}
