using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class ResourceKeyValuesService : IResourceKeyValues
    {
        private readonly IResourceKeyValuesRepository _resourceKeyValuesRepository;
        public ResourceKeyValuesService(IResourceKeyValuesRepository resourceKeyValuesRepository)
        {
            _resourceKeyValuesRepository = resourceKeyValuesRepository;
        }
        public async Task<IEnumerable<ResourceKeyValuesModel>> ResourceKeyValuesListAsync(GetResourceKeyValuesDTO model)
        {
            return await _resourceKeyValuesRepository.ResourceKeyValuesListAsync(model);
        }
    }
}
