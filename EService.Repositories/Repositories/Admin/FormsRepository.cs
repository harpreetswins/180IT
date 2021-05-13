using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.Interfaces.Admin;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories.Admin
{
    public class FormsRepository : GenericRepository, IFormsRepository
    {
        public FormsRepository(IConfiguration configuration) : base(configuration) { }
        public async Task<AdminSpResponse> AddUpdateFormsAsync(AddUpdateFormsModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditForms", model);
        }

        public async Task<AdminSpResponse> AddUpdateFormSectionAttachmentsAsync(AddUpdateFormSectionAttachmentsModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditFormSectionAttachments", model);
        }

        public async Task<AdminSpResponse> AddUpdateFormSectionsAsync(AddUpdateFormSectionModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditFormSections", model);
        }

        public async Task<AdminSpResponse> AddUpdateStageFormModeAsync(AddUpdateStageFormModeModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditStageFormMode", model);
        }

        public async Task<AdminSpResponse> DeleteFormSectionAsync(DeleteFormSectionModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_DeleteFormSections", model);
        }

        public async Task<AdminSpResponse> DeleteFormSectionAttachmentsAsync(DeleteFormSectionAttachmentsModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_DeleteFormSectionAttachment", model);
        }

        public async Task<IEnumerable<GetFormSectionsByFormIdModel>> GetFormSectionsByFormIdAsync(GetFormSectionsByFormIdDTO dto)
        {
            return await CollectionsAsync<GetFormSectionsByFormIdModel>("admin.sp_AdminGetFormSectionsByFormId", dto);
        }

        public async Task<IEnumerable<GetLookupFieldTypesModel>> GetLookupFieldTypesAsync()
        {
            return await CollectionsAsync<GetLookupFieldTypesModel>("admin.sp_GetLookupFieldTypes");
        }

        public async Task<IEnumerable<GetStageFormsModel>> GetStageFormsAsync()
        {
            return await CollectionsAsync<GetStageFormsModel>("admin.sp_AdminGetStageForms");
        }

        public async Task<AdminSpResponse> LinkUnlinkStageFormsAsync(LinkUnlinkStageFormsModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AdminLinkUnlinkStageForms", model);
        }
    }
}
