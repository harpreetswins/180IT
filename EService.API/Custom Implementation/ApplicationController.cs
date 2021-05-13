using System.Threading.Tasks;
using AutoMapper;
using EService.API.DTO.Applications;
using EService.API.DTO.Services;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class ApplicationController
    {
        private readonly IApplicationInterface _applicationInterface;
        private readonly Default_Implementation.ApplicationController DefaultApplicationController;

        public ApplicationController(IApplicationInterface applicationInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider)
        {
            _applicationInterface = applicationInterface;
            DefaultApplicationController = new Default_Implementation.ApplicationController(applicationInterface, mapper, userProvider, languageProvider);
        }
        public async Task<IActionResult> GetAsync([FromQuery] ApplicationFormDTO model)
        {
            return await DefaultApplicationController.GetAsync(model);
        }
        public async Task<IActionResult> GetApplicationChildForm([FromQuery] ChildFormDTO model)
        {
            return await DefaultApplicationController.GetApplicationChildForm(model);
        }
        public async Task<IActionResult> GetApplicationCurrentStage(int ApplicationId)
        {
            return await DefaultApplicationController.GetApplicationCurrentStage(ApplicationId);
        }
        public async Task<IActionResult> Post(BaseCreateApplicationDTO model)
        {
            return await DefaultApplicationController.Post(model);
        }
        public async Task<IActionResult> ExcuteAction(BaseExecuteActionDTO model)
        {           
            return await DefaultApplicationController.ExecuteActionAsync(model);
        }
        public async Task<IActionResult> GetUserApplicationDetailsAsync([FromQuery] int ApplicationId)
        {
            return await DefaultApplicationController.GetUserApplicationDetailsAsync(ApplicationId);
        }
        public async Task<IActionResult> GetUserApplicationListAsync([FromQuery] BaseUserApplicationListDTO model)
        {
            return await DefaultApplicationController.GetUserApplicationListAsync(model);
        }
        public async Task<IActionResult> GetUserApplicationCategoriesAsync(string mode)
        {
            return await DefaultApplicationController.GetUserApplicationCategoriesAsync(mode);
        }
        public async Task<IActionResult> GetUserApplicationCertificateCategoriesAsync(string mode)
        {
            return await DefaultApplicationController.GetUserApplicationCertificateCategoriesAsync(mode);
        }
        public async Task<IActionResult> EntityFieldLookupsAsync([FromQuery] EntityFieldLookupsDTO model)
        {
            return await DefaultApplicationController.EntityFieldLookupsAsync(model);
        }
        public async Task<IActionResult> GetChildEntityFieldLookups([FromQuery] ChildEntityFieldLookupsDTO model)
        {
            return await DefaultApplicationController.GetChildEntityFieldLookups(model);            
        }
        public async Task<IActionResult> CurrentApplicationStatusAsync([FromQuery] CurrentApplicationStatusDTO model)
        {
            return await DefaultApplicationController.CurrentApplicationStatusAsync(model);
        }
        public async Task<IActionResult> CascadedLookupsAsync([FromQuery] CascadedLookupDTO model)
        {
            return await DefaultApplicationController.CascadedLookupsAsync(model);
        }
        public async Task<IActionResult> GetApplicationActivityLogsAsync([FromQuery] int ApplicationId)
        {
            return await DefaultApplicationController.GetApplicationActivityLogsAsync(ApplicationId);
        }
        public async Task<IActionResult> GetApplicationsCountsAsync()
        {
            return await DefaultApplicationController.GetApplicationsCountsAsync();
        }
    }
}
