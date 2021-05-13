using EService.Application.Interfaces;
using EService.Domain.DomainModels.Services;
using EService.Domain.Interfaces.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class LanguageService : ILanguageInterface
    {
        private readonly ILanguageRepository _languageRepository;
        public LanguageService(ILanguageRepository languageRepository)
        {
            _languageRepository = languageRepository;
        }
        public async Task<IEnumerable<LanguageModel>> LanguageListAsync()
        {
            return await _languageRepository.LanguageListAsync();
        }
    }
}
