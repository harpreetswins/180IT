using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Response.Admin;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.Admin
{
    public interface ITextResourcesRepository
    {
        Task<AdminSpResponse> AddUpdateTextResourcesAsync(AddUpdateTextResourcesModel model);
    }
}