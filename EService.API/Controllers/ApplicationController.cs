using AutoMapper;
using System.Threading.Tasks;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Mvc;
using EService.API.DTO.Services;
using Microsoft.AspNetCore.Http;
using EService.API.DTO.Applications;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using Microsoft.AspNetCore.Authorization;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class ApplicationController : BaseController
    {
        private readonly IApplicationInterface _applicationInterface;
        private readonly IMapper _mapper;
        private readonly Custom_Implementation.ApplicationController CustomApplicationController;
        public ApplicationController(IApplicationInterface applicationInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _applicationInterface = applicationInterface;
             CustomApplicationController = new Custom_Implementation.ApplicationController(applicationInterface, mapper, userProvider, languageProvider);
            _mapper = mapper;
        }
            
        [HttpGet]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAsync([FromQuery] ApplicationFormDTO model)
        {
            return await CustomApplicationController.GetAsync(model);
        }

        [HttpGet("GetApplicationChildForm")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationChildForm([FromQuery] ChildFormDTO model)
        {
            return await CustomApplicationController.GetApplicationChildForm(model);
        }

        [HttpGet("ApplicationCurrentStage")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> Get(int ApplicationId)
        {
            return await CustomApplicationController.GetApplicationCurrentStage(ApplicationId);
        }
        [HttpPost]
        public async Task<IActionResult> Post(BaseCreateApplicationDTO model)
        {
            return await CustomApplicationController.Post(model);
        }
        [HttpPost("ExecuteAction")]
        public async Task<IActionResult> Post(BaseExecuteActionDTO model)
        {           
            return await CustomApplicationController.ExcuteAction(model);         
        }
        [HttpGet("UserApplicationDetails")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationDetailsAsync([FromQuery] int ApplicationId)
        {
            return await CustomApplicationController.GetUserApplicationDetailsAsync(ApplicationId);
        }
        [HttpGet("UserApplicationLists")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationListAsync([FromQuery] BaseUserApplicationListDTO model)
        {
            return await CustomApplicationController.GetUserApplicationListAsync(model);
        }
        [HttpGet("UserApplicationCategories")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationCategoriesAsync(string mode)
        {
            return await CustomApplicationController.GetUserApplicationCategoriesAsync(mode);
        }

         [HttpGet("UserApplicationCertificateCategories")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserApplicationCertificateCategoriesAsync(string mode)
        {
            return await CustomApplicationController.GetUserApplicationCertificateCategoriesAsync(mode);
        }

        [HttpGet("EntityFieldLookups")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> EntityFieldLookupsAsync([FromQuery] EntityFieldLookupsDTO model)
        {
            return await CustomApplicationController.EntityFieldLookupsAsync(model);
        }

        [HttpGet("GetChildEntityFieldLookups")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetChildEntityFieldLookups([FromQuery] ChildEntityFieldLookupsDTO model)
        {
            return await CustomApplicationController.GetChildEntityFieldLookups(model);
        }

        [HttpGet("CurrentApplicationStatus")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> CurrentApplicationStatusAsync([FromQuery] CurrentApplicationStatusDTO model)
        {
            return await CustomApplicationController.CurrentApplicationStatusAsync(model);
        }

        [HttpGet("CascadedLookups")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> CascadedLookupsAsync([FromQuery] CascadedLookupDTO model)
        {
            return await CustomApplicationController.CascadedLookupsAsync(model);
        }
        [HttpGet("GetApplicationActivityLogs")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationActivityLogsAsync([FromQuery] int ApplicationId)
        {
            return await CustomApplicationController.GetApplicationActivityLogsAsync(ApplicationId);
        }

        [HttpGet("GetApplicationsCounts")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetApplicationsCountsAsync()
        {
            return await CustomApplicationController.GetApplicationsCountsAsync();
        }
    }
}
