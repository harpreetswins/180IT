using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces.Admin
{
    public interface IEntityInterface
    {
        Task<IEnumerable<GetAllEntities>> GetAllEntities();
        Task<AdminSpResponse> AddUpdateEntitiesAsync(AddUpdateEntitiesModel model);
        Task<IEnumerable<AdminRolesModel>> GetAdminRolesAsync();
        Task<AdminSpResponse> AddUpdateEntityFieldsAsync(AddUpdateEntityFieldsModel model);
        Task<AdminSpResponse> LinkUnlinkFormSectionFieldsAsync(LinkUnlinkFormSectionFieldsModel model);
        Task<IEnumerable<GetFieldConstraintTypesModel>> GetFieldConstraintTypesAsync();
    }
}
