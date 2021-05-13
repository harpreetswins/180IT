using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.Admin
{
    public interface IFormsRepository
    {
        Task<AdminSpResponse> AddUpdateFormsAsync(AddUpdateFormsModel model);
        Task<IEnumerable<GetStageFormsModel>> GetStageFormsAsync();
        Task<AdminSpResponse> LinkUnlinkStageFormsAsync(LinkUnlinkStageFormsModel model);
        Task<AdminSpResponse> AddUpdateFormSectionsAsync(AddUpdateFormSectionModel model);
        Task<IEnumerable<GetFormSectionsByFormIdModel>> GetFormSectionsByFormIdAsync(GetFormSectionsByFormIdDTO dto);
        Task<IEnumerable<GetLookupFieldTypesModel>> GetLookupFieldTypesAsync();
        Task<AdminSpResponse> DeleteFormSectionAsync(DeleteFormSectionModel model);
        Task<AdminSpResponse> AddUpdateFormSectionAttachmentsAsync(AddUpdateFormSectionAttachmentsModel model);
        Task<AdminSpResponse> DeleteFormSectionAttachmentsAsync(DeleteFormSectionAttachmentsModel model);
        Task<AdminSpResponse> AddUpdateStageFormModeAsync(AddUpdateStageFormModeModel model);
    }
}
