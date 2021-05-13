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
    public class UserPermissionForServiceRepository : GenericRepository, IUserPermissionServiceRepository
    {
        public UserPermissionForServiceRepository(IConfiguration configuration) : base(configuration) { }
        public async Task<UserPermissionServiceModel> UserPermissionsForServiceAsync(CheckServicePermissionDTO model)
        {
            return await SingleAsync<UserPermissionServiceModel>("sp_GetUserPermissionForService", model);
        }
    }
}
