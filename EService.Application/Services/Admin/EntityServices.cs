using EService.Application.Interfaces.Admin;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.Interfaces.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services.Admin
{
    public class EntityServices : IEntityInterface
    {
        private readonly IEntityRepository _entityRepository;
        public EntityServices(IEntityRepository entityRepository)
        {
            _entityRepository = entityRepository;
        }

        public async Task<AdminSpResponse> AddUpdateEntitiesAsync(AddUpdateEntitiesModel model)
        {
            return await _entityRepository.AddUpdateEntitiesAsync(model);
        }

        public async Task<AdminSpResponse> AddUpdateEntityFieldsAsync(AddUpdateEntityFieldsModel model)
        {
            return await _entityRepository.AddUpdateEntityFieldsAsync(model);
        }

        public async Task<IEnumerable<AdminRolesModel>> GetAdminRolesAsync()
        {
            return await _entityRepository.GetAdminRolesAsync();
        }

        public async Task<IEnumerable<GetAllEntities>> GetAllEntities()
        {
            return await _entityRepository.GetAllEntities();
        }

        public async Task<IEnumerable<GetFieldConstraintTypesModel>> GetFieldConstraintTypesAsync()
        {
             return await _entityRepository.GetFieldConstraintTypesAsync();
        }

        public async Task<AdminSpResponse> LinkUnlinkFormSectionFieldsAsync(LinkUnlinkFormSectionFieldsModel model)
        {
            return await _entityRepository.LinkUnlinkFormSectionFieldsAsync(model);
        }
    }
}
