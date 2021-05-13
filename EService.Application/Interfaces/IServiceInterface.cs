using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IServiceInterface
    {
        Task<SpResponse> AddServiceAsync(ServiceModel model);
        Task<IEnumerable<GetGroupServiceModel>> ServiceListAsync();
        Task<ServiceProfileData> GetServiceProfileDataAsync(BaseServiceProfileDataDTO model);
        Task<ServiceRelatedData> GetSearchRelatedRecordsAsync(BaseServiceRelatedDataDTO model);
    }
}
