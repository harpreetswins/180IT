using EService.Application.Interfaces;
using EService.Application.Interfaces.Admin;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.DomainModels.Users;
using EService.Domain.Interfaces.Admin;
using EService.Domain.Interfaces.User;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class UsersServices : IUsersInterface
    {
        private readonly IUsersRepository _usersRepository;
        public UsersServices(IUsersRepository usersRepository)
        {
            _usersRepository = usersRepository;
        }

        public async Task<IEnumerable<GetUserListModel>> GetUsersListAsync()
        {
            return await _usersRepository.GetUsersListAsync();
        }
    }
}