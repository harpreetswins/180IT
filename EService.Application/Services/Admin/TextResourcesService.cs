using EService.Application.Interfaces.Admin;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using EService.Domain.Interfaces.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services.Admin
{
    public class TextResourcesService : ITextResourcesInterface
    {
        private readonly ITextResourcesRepository _textResourcesRepository;
        public TextResourcesService(ITextResourcesRepository textResourcesRepository)
        {
            _textResourcesRepository = textResourcesRepository;
        }

        public async Task<AdminSpResponse> AddUpdateTextResourcesAsync(AddUpdateTextResourcesModel model)
        {
            return await _textResourcesRepository.AddUpdateTextResourcesAsync(model);
        }
    }
}