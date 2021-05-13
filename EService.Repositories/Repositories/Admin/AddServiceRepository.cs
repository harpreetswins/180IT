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
    public class AddServiceRepository : GenericRepository, IAddServiceRepository
    {
        public AddServiceRepository(IConfiguration configuration) : base(configuration) { }
        public async Task<AdminSpResponse> AddServicesAsync(AddServiceModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddServices", model);
        }

        public async Task<AdminSpResponse> DeleteService(DeleteServiceModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_DeleteService", model);
        }

        public async Task<IEnumerable<GetAllStageTypes>> GetAllStageTypesAsync()
        {
            return await CollectionsAsync<GetAllStageTypes>("admin.sp_GetAllStageTypes");
        }

        public async Task<IEnumerable<GetServiceModel>> GetServicesById(int ServiceId)
        {
            return await CollectionsAsync<GetServiceModel>("admin.sp_GetServicesById", new { ServiceId });
        }

        public async Task<IEnumerable<GetStageActionTypes>> GetStageActionTypesAsync(int ServiceId)
        {
            return await CollectionsAsync<GetStageActionTypes>("admin.sp_GetStageActionTypes", new { ServiceId });
        }

        public async Task<AdminSpResponse> ReorderServicesAsync(ReorderServicesModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_ReorderServices", model);
        }
        public async Task<AdminSpResponse> UpdateServicesAsync(AddServiceModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddServices", model);
        }

        public async Task<AdminSpResponse> AddStageActionsAsync(AddStageActionModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddUpdateStageActions", model);
        }

        public async Task<AdminSpResponse> UpdateStageActionsAsync(AddStageActionModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddUpdateStageActions", model);
        }

        public async Task<IEnumerable<GetStageActionByStageIdModel>> GetStageActionByStageIdAsync(int stageId)
        {
            return await CollectionsAsync<GetStageActionByStageIdModel>("admin.sp_GetStageActionsByStageId", new { stageId });
        }

        public async Task<IEnumerable<GetStagesByServiceIdModel>> GetStagesByServiceIdAsync(int serviceId)
        {
            return await CollectionsAsync<GetStagesByServiceIdModel>("admin.sp_GetStagesByServiceId", new { serviceId });
        }

        public async Task<AdminSpResponse> AddUpdateStagesAsync(AddUpdateStagesModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditStages", model);
        }

        public async Task<AdminSpResponse> DeleteStageActionsAsync(int stageActionId)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AdminDeleteStageActions", new { stageActionId });
        }
        public async Task<AdminSpResponse> DeleteStagesAsync(int stageId)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_DeleteStages", new { stageId });
        }

        public async Task<AdminSpResponse> ReorderStagesAsync(ReorderStagesModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_ReorderStages", model);
        }
    }
}
