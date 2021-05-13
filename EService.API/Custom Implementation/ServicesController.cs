using System.Threading.Tasks;
using AutoMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class ServicesController
    {
        private readonly IServiceInterface _serviceInterface;
        private readonly IUserPermissionServiceInterface _userPermissionServiceInterface;
        private readonly IMapper _mapper;
        private readonly Default_Implementation.ServicesController DefaultServicesController;

        public ServicesController(IServiceInterface serviceInterface, IUserPermissionServiceInterface userPermissionServiceInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) 
        {
            _mapper = mapper;
            _serviceInterface = serviceInterface;
            _userPermissionServiceInterface = userPermissionServiceInterface;
            DefaultServicesController = new Default_Implementation.ServicesController(serviceInterface, userPermissionServiceInterface, mapper, userProvider, languageProvider);
        }

        public async Task<IActionResult> Get()
        {
            return await DefaultServicesController.Get(); 
        }
        public async Task<IActionResult> CheckPermissionAsync([FromQuery] CheckServicePermissionDTO model)
        {
            return await DefaultServicesController.CheckPermissionAsync(model);
        }
        public async Task<IActionResult> GetServiceProfileDataAsync([FromQuery] ServiceProfileDataDTO model)
        {
            return await DefaultServicesController.GetServiceProfileDataAsync(model);
        }
        public async Task<IActionResult> GetSearchRelatedRecordsAsync([FromQuery] ServiceRelatedDataDTO model)
        {
            return await DefaultServicesController.GetSearchRelatedRecordsAsync(model);
        }
    }
}
