using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IGroupInterface
    {
        Task<GroupsResponse> AddGroupAsync(GroupModel model);
        Task<IEnumerable<GetGroupModel>> GetGroupsById(int GroupId);
        Task<AdminSpResponse> DeleteGroup(DeleteGroupModel model);
        Task<IEnumerable<GetGroupsAndServices>> GetGroupsAndServices();
        Task<GroupsResponse> UpdateGroupAsync(GroupModel model);
        Task<AdminSpResponse> ReorderGroupAsync(ReorderGroupModel model);
    }
}
