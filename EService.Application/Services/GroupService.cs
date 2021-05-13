using EService.Application.Interfaces;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.Interfaces.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services.Admin
{
    public class GroupService : IGroupInterface
    {
        private readonly IGroupRepository _groupRepository;
        public GroupService(IGroupRepository groupRepository)
        {
            _groupRepository = groupRepository;
        }
        public async Task<GroupsResponse> AddGroupAsync(GroupModel model)
        {
            return await _groupRepository.AddGroupAsync(model);
        }

        public async Task<AdminSpResponse> DeleteGroup(DeleteGroupModel model)
        {
            return await _groupRepository.DeleteGroup(model);
        }

        public async Task<IEnumerable<GetGroupsAndServices>> GetGroupsAndServices()
        {
            return await _groupRepository.GetGroupsAndServices();
        }

        public async Task<IEnumerable<GetGroupModel>> GetGroupsById(int GroupId)
        {
            return await _groupRepository.GetGroupsById(GroupId);
        }

        public async Task<AdminSpResponse> ReorderGroupAsync(ReorderGroupModel model)
        {
            return await _groupRepository.ReorderGroupAsync(model);
        }

        public async Task<GroupsResponse> UpdateGroupAsync(GroupModel model)
        {
            return await _groupRepository.UpdateGroupAsync(model);
        }
    }
}
