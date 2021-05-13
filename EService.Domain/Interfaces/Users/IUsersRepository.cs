using EService.Domain.DomainModels.Users;
using EService.Domain.DomainModels.Response.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.User
{
    public interface IUsersRepository
    {        
        Task<IEnumerable<GetUserListModel>> GetUsersListAsync();
    }
}