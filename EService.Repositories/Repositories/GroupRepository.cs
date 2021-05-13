using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.Interfaces.Admin;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories.Admin
{
    public class GroupRepository : GenericRepository, IGroupRepository
    {
        public GroupRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<GroupsResponse> AddGroupAsync(GroupModel model)
        {
            return await CommandAsync<GroupsResponse>("admin.sp_AddGroups", model);
        }

        public async Task<AdminSpResponse> DeleteGroup(DeleteGroupModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_DeleteGroup", model);
        }

        public async Task<IEnumerable<GetGroupsAndServices>> GetGroupsAndServices()
        {
            return await Query<GetGroupsAndServices>("sp_GetGroupsAndServices");
        }

        public async Task<IEnumerable<GetGroupModel>> GetGroupsById(int GroupId)
        {
            return await CollectionsAsync<GetGroupModel>("admin.sp_GetGroupsById", new { GroupId});
        }

        public async Task<AdminSpResponse> ReorderGroupAsync(ReorderGroupModel model)
        {
            return await CommandAsync<AdminSpResponse>("admin.sp_ReorderGroups", model);
        }

        public async Task<GroupsResponse> UpdateGroupAsync(GroupModel model)
        {
            return await CommandAsync<GroupsResponse>("admin.sp_AddGroups", model);
        }
    }
}
