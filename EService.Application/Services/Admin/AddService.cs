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
    public class AddService : IAddServiceInterface
    {
        private readonly IAddServiceRepository _addServiceRepository;
        public AddService(IAddServiceRepository addServiceRepository)
        {
            _addServiceRepository = addServiceRepository;
        }
        public async Task<AdminSpResponse> AddServiceAsync(AddServiceModel model)
        {
            return await _addServiceRepository.AddServicesAsync(model);
        }

        public async Task<AdminSpResponse> DeleteService(DeleteServiceModel model)
        {
            return await _addServiceRepository.DeleteService(model);
        }

        public async Task<IEnumerable<GetAllStageTypes>> GetAllStageTypesAsync()
        {
            return await _addServiceRepository.GetAllStageTypesAsync();
        }

        public async Task<IEnumerable<GetServiceModel>> GetServicesById(int ServiceId)
        {
            return await _addServiceRepository.GetServicesById(ServiceId);
        }

        public async Task<IEnumerable<GetStageActionTypes>> GetStageActionTypesAsync(int ServiceId)
        {
            return await _addServiceRepository.GetStageActionTypesAsync(ServiceId);
        }

        public async Task<AdminSpResponse> ReorderServicesAsync(ReorderServicesModel model)
        {
            return await _addServiceRepository.ReorderServicesAsync(model);
        }
        public async Task<AdminSpResponse> UpdateServicesAsync(AddServiceModel model)
        {
            return await _addServiceRepository.UpdateServicesAsync(model);
        }
        public async Task<AdminSpResponse> AddStageActionsAsync(AddStageActionModel model)
        {
            return await _addServiceRepository.AddStageActionsAsync(model);
        }
        public async Task<AdminSpResponse> UpdateStageActionsAsync(AddStageActionModel model)
        {
            return await _addServiceRepository.UpdateStageActionsAsync(model);
        }

        public async Task<IEnumerable<GetStageActionByStageIdModel>> GetStageActionByStageIdAsync(int stageId)
        {
            return await _addServiceRepository.GetStageActionByStageIdAsync(stageId);
        }

        public async Task<IEnumerable<GetStagesByServiceIdModel>> GetStagesByServiceIdAsync(int serviceId)
        {
            return await _addServiceRepository.GetStagesByServiceIdAsync(serviceId);
        }

        public async Task<AdminSpResponse> AddUpdateStagesAsync(AddUpdateStagesModel model)
        {
            return await _addServiceRepository.AddUpdateStagesAsync(model);
        }

        public async Task<AdminSpResponse> DeleteStageActionsAsync(int stageActionId)
        {
            return await _addServiceRepository.DeleteStageActionsAsync(stageActionId);
        }
        public async Task<AdminSpResponse> DeleteStagesAsync(int stageId)
        {
            return await _addServiceRepository.DeleteStagesAsync(stageId);
        }

        public async Task<AdminSpResponse> ReorderStagesAsync(ReorderStagesModel model)
        {
            return await _addServiceRepository.ReorderStagesAsync(model);
        }
    }
}
