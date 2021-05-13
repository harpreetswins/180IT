using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.Services
{
    public interface IServiceRepository
    {
        Task<SpResponse> AddAsync(ServiceModel model);
        Task<IEnumerable<GetGroupServiceModel>> ServiceListAsync();
        Task<ServiceProfileData> GetServiceProfileDataAsync(BaseServiceProfileDataDTO model);
        Task<ServiceRelatedData> GetSearchRelatedRecordsAsync(BaseServiceRelatedDataDTO model);
    }
}
