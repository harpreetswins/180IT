using AutoMapper;
using System.Threading.Tasks;
using EService.API.DTO.Applications;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;
using EService.Domain.DomainModels.UploadAttachments;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;

namespace EService.API.Custom_Implementation
{
    public class UploadAttachmentController
    {
        private readonly IUploadAttachments _uploadAttachments;
        private readonly IMapper _mapper;
        private readonly Default_Implementation.UploadAttachmentController DefaultUploadAttachmentController;
        public UploadAttachmentController(IUploadAttachments uploadAttachments, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) 
        {
            _uploadAttachments = uploadAttachments;
            _mapper = mapper;
            DefaultUploadAttachmentController = new Default_Implementation.UploadAttachmentController(uploadAttachments, mapper, userProvider, languageProvider);
        }

        public async Task<IActionResult> GetAsync([FromQuery] GetAttachmentDTO model)
        {
            return await DefaultUploadAttachmentController.GetAsync(model);
        }
        public async Task<IActionResult> GetAttachmentByIdAsync(int attachmentId)
        {
            return await DefaultUploadAttachmentController.GetAttachmentByIdAsync(attachmentId);
        }
        public async Task<IActionResult> Post([FromForm] BaseUploadAttachmentDTO model)
        {
            return await DefaultUploadAttachmentController.Post(model);
        }
        public async Task<IActionResult> DeleteAsync(int attachmentId)
        {
            return await DefaultUploadAttachmentController.DeleteAsync(attachmentId);
        }
        public async Task<IActionResult> UploadActionAttachmentsAsync([FromForm] BaseUploadActionAttachmentDTO model)
        {
            return await DefaultUploadAttachmentController.UploadActionAttachmentsAsync(model);
        }
        public async Task<IActionResult> GetActionAttachmentByIdAsync([FromQuery] GetActionAttachmentDTO model)
        {
            return await DefaultUploadAttachmentController.GetActionAttachmentByIdAsync(model);
        }
        public async Task<IActionResult> DeleteActionAttachmentAsync([FromQuery] GetActionAttachmentDTO model)
        {
            return await DefaultUploadAttachmentController.DeleteActionAttachmentAsync(model);
        }
    }
}
