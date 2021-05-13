using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using EService.Domain.DomainModels.Users;

namespace EService.Application.Interfaces
{
    public interface IUsersInterface
    {
        Task<IEnumerable<GetUserListModel>> GetUsersListAsync();
    }
}