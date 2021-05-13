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
    public class EntityRepository : GenericRepository, IEntityRepository
    {
        public EntityRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<AdminSpResponse> AddUpdateEntitiesAsync(AddUpdateEntitiesModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditEntities", model);
        }

        public async Task<AdminSpResponse> AddUpdateEntityFieldsAsync(AddUpdateEntityFieldsModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AddEditEntityFields", model);
        }

        public async Task<IEnumerable<AdminRolesModel>> GetAdminRolesAsync()
        {
            return await CollectionsAsync<AdminRolesModel>("admin.sp_AdminGetRoles");
        }

        public async Task<IEnumerable<GetAllEntities>> GetAllEntities()
        {
            return await CollectionsAsync<GetAllEntities>("admin.sp_GetAllEntities");
        }

        public async Task<IEnumerable<GetFieldConstraintTypesModel>> GetFieldConstraintTypesAsync()
        {
            return await CollectionsAsync<GetFieldConstraintTypesModel>("admin.sp_GetFieldConstraintTypes");
        }

        public async Task<AdminSpResponse> LinkUnlinkFormSectionFieldsAsync(LinkUnlinkFormSectionFieldsModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_AdminLinkUnlinkFormSectionFields", model);
        }
    }
}
