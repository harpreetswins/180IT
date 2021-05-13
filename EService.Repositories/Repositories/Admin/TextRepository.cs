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
    public class TextRepositoryRepository : GenericRepository, ITextResourcesRepository
    {
        public TextRepositoryRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<AdminSpResponse> AddUpdateTextResourcesAsync(AddUpdateTextResourcesModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditTextResourceValues", model);
        }
    }
}