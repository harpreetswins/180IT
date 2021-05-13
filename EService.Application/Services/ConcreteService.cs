using EService.Application.Interfaces;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class ConcreteService : IServiceInterface
    {
        private readonly IServiceRepository _serviceRepository;
        public ConcreteService(IServiceRepository serviceRepository)
        {
            _serviceRepository = serviceRepository;
        }
        public async Task<SpResponse> AddServiceAsync(ServiceModel model)
        {
           return await _serviceRepository.AddAsync(model);
        }

        public async Task<ServiceProfileData> GetServiceProfileDataAsync(BaseServiceProfileDataDTO model)
        {
            return await _serviceRepository.GetServiceProfileDataAsync(model);
        }

        public async Task<IEnumerable<GetGroupServiceModel>> ServiceListAsync()
        {
            return await _serviceRepository.ServiceListAsync();
        }
        public async Task<ServiceRelatedData> GetSearchRelatedRecordsAsync(BaseServiceRelatedDataDTO model)
        {
            return await _serviceRepository.GetSearchRelatedRecordsAsync(model);
        }
    }
}
