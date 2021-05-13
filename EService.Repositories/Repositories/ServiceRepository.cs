using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories
{
    public class ServiceRepository : GenericRepository, IServiceRepository
    {
        public ServiceRepository(IConfiguration configuration) : base(configuration) { }

        /// <summary>
        /// Add new service in database table
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public async Task<SpResponse> AddAsync(ServiceModel model)
        {
           return await CommandAsync<SpResponse>("AddService", model);
        }

        public async Task<ServiceProfileData> GetServiceProfileDataAsync(BaseServiceProfileDataDTO model)
        {
            return await SingleAsync<ServiceProfileData>("sp_GetServiceProfileData", model);
        }
        public async Task<ServiceRelatedData> GetSearchRelatedRecordsAsync(BaseServiceRelatedDataDTO model)
        {
            return await SingleAsync<ServiceRelatedData>("sp_GetSearchRelatedRecords", model);
        }

        /// <summary>
        /// Get collections of Groups,SubGroups and Services
        /// </summary>
        /// <returns></returns>
        public async Task<IEnumerable<GetGroupServiceModel>> ServiceListAsync()
        {
            return await CollectionsAsync<GetGroupServiceModel>("sp_GetGroupServices");
        }
    }
}
