using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class UserPermissionService : IUserPermissionServiceInterface
    {
        private readonly IUserPermissionServiceRepository _userPermissionServiceRepository;
        public UserPermissionService(IUserPermissionServiceRepository userPermissionServiceRepository)
        {
            _userPermissionServiceRepository = userPermissionServiceRepository;
        }
        public async Task<UserPermissionServiceModel> UserPermissionsForServiceAsync(CheckServicePermissionDTO model)
        {
            return await _userPermissionServiceRepository.UserPermissionsForServiceAsync(model);
        }
    }
}
