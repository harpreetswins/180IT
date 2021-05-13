using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.UploadAttachments;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.UploadAttachments
{
    public interface IUploadAttachmentRepository
    {
        Task<SpResponse> UploadAttachmentAsync(UploadAttachmentModel model);
        Task<IEnumerable<GetAttachmentModel>> GetAttachmentAsync(GetAttachmentDTO model);
        Task<SpResponse> DeleteAsync(int attachmentId);
        Task<GetAttachmentModel> GetAttachmentByIdAsync(int attachmentId);
        Task<SpResponse> UploadActionAttachmentAsync(UploadActionAttachmentsModel model);
        Task<GetActionAttachmentModel> GetActionAttachmentByIdAsync(GetActionAttachmentDTO model);
        Task<SpResponse> DeleteActionAttachmentAsync(GetActionAttachmentDTO model);
    }
}
