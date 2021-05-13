using EService.Application.Interfaces.Admin;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.Interfaces.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services.Admin
{
    public class FormsService : IFormsInterface
    {
        private readonly IFormsRepository _formsRepository;
        public FormsService(IFormsRepository formsRepository)
        {
            _formsRepository = formsRepository;
        }
        public async Task<AdminSpResponse> AddUpdateFormsAsync(AddUpdateFormsModel model)
        {
            return await _formsRepository.AddUpdateFormsAsync(model);
        }

        public async Task<AdminSpResponse> AddUpdateFormSectionAttachmentsAsync(AddUpdateFormSectionAttachmentsModel model)
        {
            return await _formsRepository.AddUpdateFormSectionAttachmentsAsync(model);
        }

        public async Task<AdminSpResponse> AddUpdateFormSectionsAsync(AddUpdateFormSectionModel model)
        {
            return await _formsRepository.AddUpdateFormSectionsAsync(model);
        }

        public async Task<AdminSpResponse> AddUpdateStageFormModeAsync(AddUpdateStageFormModeModel model)
        {
            return await _formsRepository.AddUpdateStageFormModeAsync(model);
        }

        public async Task<AdminSpResponse> DeleteFormSectionAsync(DeleteFormSectionModel model)
        {
            return await _formsRepository.DeleteFormSectionAsync(model);
        }

        public async Task<AdminSpResponse> DeleteFormSectionAttachmentsAsync(DeleteFormSectionAttachmentsModel model)
        {
            return await _formsRepository.DeleteFormSectionAttachmentsAsync(model);
        }

        public async Task<IEnumerable<GetFormSectionsByFormIdModel>> GetFormSectionsByFormIdAsync(GetFormSectionsByFormIdDTO dto)
        {
            return await _formsRepository.GetFormSectionsByFormIdAsync(dto);
        }

        public async Task<IEnumerable<GetLookupFieldTypesModel>> GetLookupFieldTypesAsync()
        {
            return await _formsRepository.GetLookupFieldTypesAsync();
        }

        public async Task<IEnumerable<GetStageFormsModel>> GetStageFormsAsync()
        {
            return await _formsRepository.GetStageFormsAsync();
        }

        public async Task<AdminSpResponse> LinkUnlinkStageFormsAsync(LinkUnlinkStageFormsModel model)
        {
            return await _formsRepository.LinkUnlinkStageFormsAsync(model);
        }
    }
}
