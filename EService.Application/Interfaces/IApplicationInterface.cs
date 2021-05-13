using System;
using System.Collections.Generic;
using System.Text;
using EService.Domain.DomainModels.Response;
using EService.Domain.DomainModels.Applications;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IApplicationInterface
    {
        Task<SpResponse> AddApplicationAsync(ApplicationModel model);
        Task<ApplicationFormModel> ApplicationFormsAsync(BaseApplicationFormDTO model);
        Task<SpResponse> ExecuteActionAsync(ExecuteActionModel model);
        Task<CurrentStageModel> ApplicationCurrentStageAsync(int ApplicationId);
        Task<UserApplicationDetails> UserApplicationDetailsAsync(UserApplicationDetailsDTO model);
        Task<IEnumerable<UserApplicationList>> UserApplicationListAsync(UserApplicationListDTO model);
        Task<UserApplicationCategories> UserApplicationCategoriesAsync(UserApplicationCategoriesDTO model);
        Task<UserApplicationCertificateCategories> UserApplicationCertificateCategoriesAsync(UserApplicationCategoriesDTO model);
        Task<IEnumerable<EntityFieldLookups>> EntityFieldLookupsAsync(EntityFieldLookupsDTO model);
        Task<IEnumerable<EntityFieldLookups>> GetChildEntityFieldLookupsAsync(ChildEntityFieldLookupsDTO model);
        Task<IEnumerable<CurrentApplicationStatus>> CurrentApplicationStatusAsync(BaseCurrentApplicationStatus model);
        Task<IEnumerable<UserIdModel>> GetUserIdAsync(string userId);
        Task<IEnumerable<ChildFormModel>> ApplicationChildFormAsync(ChildFormDTO model);
        Task<IEnumerable<EntityFieldLookups>> CascadedLookupsAsync(CascadedLookupDTO model);
        Task<IEnumerable<ActivityLogModel>> ActivityLogsAsync(ActivityLogDTO model);
        Task<ApplicationsCountsModel> GetApplicationsCountsAsync(ApplicationsCountsDTO model);
    }
}
