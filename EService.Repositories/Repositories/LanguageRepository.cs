using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories
{
    public class LanguageRepository : GenericRepository, ILanguageRepository
    {
        public LanguageRepository(IConfiguration configuration) : base(configuration) { }
        public async Task<IEnumerable<LanguageModel>> LanguageListAsync()
        {
            return await CollectionsAsync<LanguageModel>("sp_GetAllLanguages");
        }
    }
}
