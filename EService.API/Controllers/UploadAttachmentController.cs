using AutoMapper;
using System.Threading.Tasks;
using EService.API.DTO.Applications;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using EService.Domain.DomainModels.UploadAttachments;
using Microsoft.AspNetCore.Http;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using Microsoft.AspNetCore.Authorization;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class UploadAttachmentController : BaseController
    {
        private readonly IUploadAttachments _uploadAttachments;
        private readonly IMapper _mapper;
        private readonly Custom_Implementation.UploadAttachmentController CustomUploadAttachmentController;
        public UploadAttachmentController(IUploadAttachments uploadAttachments, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _uploadAttachments = uploadAttachments;
            _mapper = mapper;
            CustomUploadAttachmentController = new Custom_Implementation.UploadAttachmentController(uploadAttachments, mapper, userProvider, languageProvider);
        }
        [HttpGet]
        public async Task<IActionResult> GetAsync([FromQuery] GetAttachmentDTO model)
        {
            return await CustomUploadAttachmentController.GetAsync(model);
        }

        [HttpGet("GetAttachmentById")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAttachmentByIdAsync(int attachmentId)
        {
            return await CustomUploadAttachmentController.GetAttachmentByIdAsync(attachmentId);
        }

        [HttpPost]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> Post([FromForm] BaseUploadAttachmentDTO model)
        {
            return await CustomUploadAttachmentController.Post(model);
        }
        [HttpDelete]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> DeleteAsync(int attachmentId)
        {
            return await CustomUploadAttachmentController.DeleteAsync(attachmentId);
        }

        [HttpPost("UploadActionAttachments")]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> UploadActionAttachmentsAsync([FromForm] BaseUploadActionAttachmentDTO model)
        {
            return await CustomUploadAttachmentController.UploadActionAttachmentsAsync(model);
        }
        [HttpGet("GetActionAttachmentById")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetActionAttachmentByIdAsync([FromQuery] GetActionAttachmentDTO model)
        {
            return await CustomUploadAttachmentController.GetActionAttachmentByIdAsync(model);
        }

        [HttpDelete("DeleteActionAttachment")]
        [ProducesResponseType(typeof(void), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> DeleteActionAttachmentAsync([FromQuery] GetActionAttachmentDTO model)
        {
            return await CustomUploadAttachmentController.DeleteActionAttachmentAsync(model);
        }
    }
}
