using System;
using System.Collections.Generic;
using System.Text;
using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Users;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
using EService.Domain.Interfaces.User;

namespace EService.Repositories.Repositories
{
    public class UsersRepository : GenericRepository, IUsersRepository
    {
        public UsersRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<IEnumerable<GetUserListModel>> GetUsersListAsync()
        {
            return await CollectionsAsync<GetUserListModel>("sp_GetUserList");
        }
    }
}