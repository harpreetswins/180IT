using System.Threading.Tasks;
using AutoMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class GetGroupsController : BaseController
    {
        private readonly IGroupInterface _groupInterface;
        private readonly IMapper _mapper;
        private readonly Default_Implementation.GetGroupsController DefaultGetGroupsController;
        public GetGroupsController(IGroupInterface groupInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _groupInterface = groupInterface;
            _mapper = mapper;
            DefaultGetGroupsController = new Default_Implementation.GetGroupsController(groupInterface, mapper, userProvider, languageProvider);
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Get()
        {
            return await DefaultGetGroupsController.Get();
        }
    }
}
