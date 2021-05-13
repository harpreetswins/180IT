using System.Threading.Tasks;
using AutoMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class ServicesController : BaseController
    {
        private readonly IServiceInterface _serviceInterface;
        private readonly IUserPermissionServiceInterface _userPermissionServiceInterface;
        private readonly IMapper _mapper;
        private readonly Custom_Implementation.ServicesController CustomServicesController;
        public ServicesController(IServiceInterface serviceInterface, IUserPermissionServiceInterface userPermissionServiceInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _mapper = mapper;
            _serviceInterface = serviceInterface;
            _userPermissionServiceInterface = userPermissionServiceInterface;
            CustomServicesController = new Custom_Implementation.ServicesController(serviceInterface, userPermissionServiceInterface, mapper, userProvider, languageProvider);
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            return await CustomServicesController.Get();
        }

        [HttpGet("CheckPermission")]
        public async Task<IActionResult> CheckPermissionAsync([FromQuery] CheckServicePermissionDTO model)
        {
            return await CustomServicesController.CheckPermissionAsync(model);
        }

        [HttpGet("GetServiceProfileData")]
        public async Task<IActionResult> GetServiceProfileDataAsync([FromQuery] ServiceProfileDataDTO model)
        {
            return await CustomServicesController.GetServiceProfileDataAsync(model);
        }
        
        [HttpGet("GetSearchRelatedRecords")]
        public async Task<IActionResult> GetSearchRelatedRecordsAsync([FromQuery] ServiceRelatedDataDTO model)
        {
            return await CustomServicesController.GetSearchRelatedRecordsAsync(model);
        }
    }
}
