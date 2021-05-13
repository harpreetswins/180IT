using System;
using System.Collections.Generic;
using System.Text;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Applications;
using System.Threading.Tasks;
using EService.Domain.Interfaces.Applications;

namespace EService.Application.Services
{
    public class ApplicationService : IApplicationInterface
    {
        private readonly IApplicationRepository _applicationRepository;
        public ApplicationService(IApplicationRepository applicationRepository)
        {
            _applicationRepository = applicationRepository;
        }
        public async Task<SpResponse> AddApplicationAsync(ApplicationModel model)
        {
            return await _applicationRepository.AddApplicationAsync(model);
        }

        public async Task<IEnumerable<ChildFormModel>> ApplicationChildFormAsync(ChildFormDTO model)
        {            
            return await _applicationRepository.ApplicationChildFormAsync(model);
        } 

        public async Task<CurrentStageModel> ApplicationCurrentStageAsync(int ApplicationId)
        {
            return await _applicationRepository.ApplicationCurrentStageAsync(ApplicationId);
        }

        public async Task<ApplicationFormModel> ApplicationFormsAsync(BaseApplicationFormDTO model)
        {
            return await _applicationRepository.ApplicationFormsAsync(model);
        }

        public async Task<IEnumerable<CurrentApplicationStatus>> CurrentApplicationStatusAsync(BaseCurrentApplicationStatus model)
        {
            return await _applicationRepository.CurrentApplicationStatusAsync(model);
        }

        public async Task<IEnumerable<EntityFieldLookups>> EntityFieldLookupsAsync(EntityFieldLookupsDTO model)
        {
            return await _applicationRepository.EntityFieldLookupsAsync(model);
        }

        public async Task<IEnumerable<EntityFieldLookups>> GetChildEntityFieldLookupsAsync(ChildEntityFieldLookupsDTO model)
        {
            return await _applicationRepository.GetChildEntityFieldLookupsAsync(model);
        }

        public async Task<SpResponse> ExecuteActionAsync(ExecuteActionModel model)
        {
            return await _applicationRepository.ExecuteActionAsync(model);
        }

        public async Task<IEnumerable<UserIdModel>> GetUserIdAsync(string userId)
        {
            return await _applicationRepository.GetUserIdAsync(userId);
        }

        public async Task<UserApplicationCategories> UserApplicationCategoriesAsync(UserApplicationCategoriesDTO model)
        {
            return await _applicationRepository.UserApplicationCategoriesAsync(model);
        }
        public async Task<UserApplicationCertificateCategories> UserApplicationCertificateCategoriesAsync(UserApplicationCategoriesDTO model)
        {
            return await _applicationRepository.UserApplicationCertificateCategoriesAsync(model);
        }
        

        public async Task<UserApplicationDetails> UserApplicationDetailsAsync(UserApplicationDetailsDTO model)
        {
            return await _applicationRepository.UserApplicationDetailsAsync(model);
        }

        public async Task<IEnumerable<UserApplicationList>> UserApplicationListAsync(UserApplicationListDTO model)
        {
            return await _applicationRepository.UserApplicationListAsync(model);
        }

        public async Task<IEnumerable<EntityFieldLookups>> CascadedLookupsAsync(CascadedLookupDTO model)
        {
            return await _applicationRepository.CascadedLookupsAsync(model);
        }

        public async Task<IEnumerable<ActivityLogModel>> ActivityLogsAsync(ActivityLogDTO model)
        {
            return await _applicationRepository.ActivityLogsAsync(model);
        }

        public async Task<ApplicationsCountsModel> GetApplicationsCountsAsync(ApplicationsCountsDTO model)
        {
            return await _applicationRepository.GetApplicationsCountsAsync(model);
        }
    }
}
