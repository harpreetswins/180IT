using EService.Application.Interfaces;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.UploadAttachments;
using EService.Domain.Interfaces.UploadAttachments;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class UploadAttachmentService : IUploadAttachments
    {
        private readonly IUploadAttachmentRepository _uploadAttachmentRepository;
        public UploadAttachmentService(IUploadAttachmentRepository uploadAttachmentRepository)
        {
            _uploadAttachmentRepository = uploadAttachmentRepository;
        }

        public async Task<SpResponse> DeleteAsync(int attachmentId)
        {
            return await _uploadAttachmentRepository.DeleteAsync(attachmentId);
        }

        public async Task<IEnumerable<GetAttachmentModel>> GetAttachmentAsync(GetAttachmentDTO model)
        {
            return await _uploadAttachmentRepository.GetAttachmentAsync(model);
        }

        public async Task<GetAttachmentModel> GetAttachmentByIdAsync(int attachmentId)
        {
            return await _uploadAttachmentRepository.GetAttachmentByIdAsync(attachmentId);
        }

        public async Task<SpResponse> UploadAttachmentAsync(UploadAttachmentModel model)
        {
            return await _uploadAttachmentRepository.UploadAttachmentAsync(model);
        }
        public async Task<SpResponse> UploadActionAttachmentAsync(UploadActionAttachmentsModel model)
        {
            return await _uploadAttachmentRepository.UploadActionAttachmentAsync(model);
        }

        public async Task<GetActionAttachmentModel> GetActionAttachmentByIdAsync(GetActionAttachmentDTO model)
        {
            return await _uploadAttachmentRepository.GetActionAttachmentByIdAsync(model);
        }

        public async Task<SpResponse> DeleteActionAttachmentAsync(GetActionAttachmentDTO model)
        {
            return await _uploadAttachmentRepository.DeleteActionAttachmentAsync(model);
        }
    }
}
