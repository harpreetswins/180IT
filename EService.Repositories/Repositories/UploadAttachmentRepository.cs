using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.UploadAttachments;
using EService.Domain.Interfaces.UploadAttachments;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories
{
    public class UploadAttachmentRepository : GenericRepository, IUploadAttachmentRepository
    {
        public UploadAttachmentRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<SpResponse> DeleteAsync(int attachmentId)
        {
            return await CommandAsync<SpResponse>("sp_DeleteAttachment", new { attachmentId });
        }

        public async Task<IEnumerable<GetAttachmentModel>> GetAttachmentAsync(GetAttachmentDTO model)
        {
            return await Query<GetAttachmentModel>("sp_GetAttachment", model);
        }

        public async Task<GetAttachmentModel> GetAttachmentByIdAsync(int attachmentId)
        {
            return await SingleAsync<GetAttachmentModel>("sp_GetAttachmentById", new { attachmentId });
        }

        public async Task<SpResponse> UploadAttachmentAsync(UploadAttachmentModel model)
        {
            return await CommandAsync<SpResponse>("sp_UploadAttachments", model);
        }
        public async Task<SpResponse> UploadActionAttachmentAsync(UploadActionAttachmentsModel model)
        {
            return await CommandAsync<SpResponse>("sp_UploadActionAttachments", model);
        }

        public async Task<GetActionAttachmentModel> GetActionAttachmentByIdAsync(GetActionAttachmentDTO model)
        {
            return await SingleAsync<GetActionAttachmentModel>("sp_GetActionAttachmentById", model);
        }

        public async Task<SpResponse> DeleteActionAttachmentAsync(GetActionAttachmentDTO model)
        {
            return await CommandAsync<SpResponse>("sp_DeleteActionAttachment",model);
        }
    }
}
