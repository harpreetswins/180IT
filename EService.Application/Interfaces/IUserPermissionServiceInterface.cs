using EService.Domain.DomainModels.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IUserPermissionServiceInterface
    {
        Task<UserPermissionServiceModel> UserPermissionsForServiceAsync(CheckServicePermissionDTO model);
    }
}
