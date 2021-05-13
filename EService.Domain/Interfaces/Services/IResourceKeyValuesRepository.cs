using EService.Domain.DomainModels.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.Services
{
    public interface IResourceKeyValuesRepository
    {
        Task<IEnumerable<ResourceKeyValuesModel>> ResourceKeyValuesListAsync(GetResourceKeyValuesDTO getResourceKeyValuesDTO);
    }
}
