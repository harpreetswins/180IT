using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces.Admin
{
    public interface IAddServiceInterface
    {
        Task<AdminSpResponse> AddServiceAsync(AddServiceModel model);
        Task<IEnumerable<GetServiceModel>> GetServicesById(int ServiceId);
        Task<AdminSpResponse> DeleteService(DeleteServiceModel model);
        Task<AdminSpResponse> UpdateServicesAsync(AddServiceModel model);
        Task<AdminSpResponse> ReorderServicesAsync(ReorderServicesModel model);
        Task<IEnumerable<GetAllStageTypes>> GetAllStageTypesAsync();
        Task<IEnumerable<GetStageActionTypes>> GetStageActionTypesAsync(int ServiceId);
        Task<AdminSpResponse> AddStageActionsAsync(AddStageActionModel model);
        Task<AdminSpResponse> UpdateStageActionsAsync(AddStageActionModel model);
        Task<IEnumerable<GetStageActionByStageIdModel>> GetStageActionByStageIdAsync(int stageId);
        Task<IEnumerable<GetStagesByServiceIdModel>> GetStagesByServiceIdAsync(int serviceId);
        Task<AdminSpResponse> AddUpdateStagesAsync(AddUpdateStagesModel model);
        Task<AdminSpResponse> DeleteStageActionsAsync(int stageActionId);
        Task<AdminSpResponse> DeleteStagesAsync(int stageId);
        Task<AdminSpResponse> ReorderStagesAsync(ReorderStagesModel model);
    }
}
