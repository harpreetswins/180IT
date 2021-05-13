using EService.Domain.DomainModels.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IResourceKeyValues
    {
        Task<IEnumerable<ResourceKeyValuesModel>> ResourceKeyValuesListAsync(GetResourceKeyValuesDTO getResourceKeyValuesModel);
    }
}
