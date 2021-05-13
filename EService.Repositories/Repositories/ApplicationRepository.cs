using System;
using System.Collections.Generic;
using System.Text;
using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Applications;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
using EService.Domain.Interfaces.Applications;

namespace EService.Repositories.Repositories
{
    public class ApplicationRepository : GenericRepository, IApplicationRepository
    {
        public ApplicationRepository(IConfiguration configuration) : base(configuration) { }
        public async Task<SpResponse> AddApplicationAsync(ApplicationModel model)
        {
            return await CommandAsync<SpResponse>("sp_AddApplications", model);
        }

        public async Task<CurrentStageModel> ApplicationCurrentStageAsync(int ApplicationId)
        {
            return await SingleAsync<CurrentStageModel>("sp_GetApplicationCurrentStage", new { ApplicationId }); 
        }

        public async Task<ApplicationFormModel> ApplicationFormsAsync(BaseApplicationFormDTO model)
        {
            return await SingleAsync<ApplicationFormModel>("sp_GetApplicationForm", model);
        }

        public async Task<IEnumerable<EntityFieldLookups>> EntityFieldLookupsAsync(EntityFieldLookupsDTO model)
        {
            return await Query<EntityFieldLookups>("sp_GetEntityFieldLookups", model);
        }
        public async Task<IEnumerable<EntityFieldLookups>> GetChildEntityFieldLookupsAsync(ChildEntityFieldLookupsDTO model)
        {
            return await Query<EntityFieldLookups>("sp_GetChildEntityFieldLookups", model);
        }

        public async Task<SpResponse> ExecuteActionAsync(ExecuteActionModel model)
        {
            return await CommandAsync<SpResponse>("sp_ExecuteActions", model);
        }

        public async Task<IEnumerable<CurrentApplicationStatus>> CurrentApplicationStatusAsync(BaseCurrentApplicationStatus model)
        {
            return await Query<CurrentApplicationStatus>("sp_CheckCurrentApplicationStatus", model);
        }

        public async Task<UserApplicationCategories> UserApplicationCategoriesAsync(UserApplicationCategoriesDTO model)
        {
            return await SingleAsync<UserApplicationCategories>("sp_GetUserApplicationCategories", model);
        }
        public async Task<UserApplicationCertificateCategories> UserApplicationCertificateCategoriesAsync(UserApplicationCategoriesDTO model)
        {
            return await SingleAsync<UserApplicationCertificateCategories>("sp_GetUserApplicationCertificateCategories", model);
        }
        public async Task<UserApplicationDetails> UserApplicationDetailsAsync(UserApplicationDetailsDTO model)
        {
            return await SingleAsync<UserApplicationDetails>("sp_GetUserApplicationsDetail", model);
        }

        public async Task<IEnumerable<UserApplicationList>> UserApplicationListAsync(UserApplicationListDTO model)
        {
            return await Query<UserApplicationList>("sp_GetUserApplicationsList", model);
        }

        public async Task<IEnumerable<UserIdModel>> GetUserIdAsync(string userId)
        {
            return await Query<UserIdModel>("sp_GetUserId", new { userId });
        }

        public async Task<IEnumerable<ChildFormModel>> ApplicationChildFormAsync(ChildFormDTO model)
        {
             return await CollectionsAsync<ChildFormModel>("sp_GetApplicationChildForm", model);                
        }

        public async Task<IEnumerable<EntityFieldLookups>> CascadedLookupsAsync(CascadedLookupDTO model)
        {
            return await CollectionsAsync<EntityFieldLookups>("sp_GetCascadedLookupValues", model);
        }

        public async Task<IEnumerable<ActivityLogModel>> ActivityLogsAsync(ActivityLogDTO model)
        {
            return await CollectionsAsync<ActivityLogModel>("sp_GetApplicationActivityLogs", model);
        }

        public async Task<ApplicationsCountsModel> GetApplicationsCountsAsync(ApplicationsCountsDTO model)
        {
            return await SingleAsync<ApplicationsCountsModel>("sp_GetApplicationsCounts", model);
        }
    }
}
