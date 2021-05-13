using System.Threading.Tasks;
using AutoMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class GetGroupsController
    {
        private readonly IGroupInterface _groupInterface;
        private readonly IMapper _mapper;
        private readonly Default_Implementation.GetGroupsController DefaultGetGroupsController;
        public GetGroupsController(IGroupInterface groupInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider)  
        {
            _groupInterface = groupInterface;
            _mapper = mapper;
            DefaultGetGroupsController = new Default_Implementation.GetGroupsController(groupInterface, mapper, userProvider, languageProvider);
        }
        public async Task<IActionResult> Get()
        {
            return await DefaultGetGroupsController.Get();
        }
    }
}
