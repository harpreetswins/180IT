using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories
{
    public class ResourceKeyValuesRepository : GenericRepository, IResourceKeyValuesRepository
    {
        public ResourceKeyValuesRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<IEnumerable<ResourceKeyValuesModel>> ResourceKeyValuesListAsync(GetResourceKeyValuesDTO getResourceKeyValuesModel)
        {
            return await Query<ResourceKeyValuesModel>("sp_GetResourceKeyValues",getResourceKeyValuesModel);
        }
    }
}
