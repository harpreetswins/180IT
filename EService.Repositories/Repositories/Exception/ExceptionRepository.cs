using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Exception.Exception;
using EService.Domain.DomainModels.Exception.Models;
using EService.Domain.DomainModels.Response;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories.Exception
{
    public class ExceptionRepository : GenericRepository, IExceptionInterface
    {
        public ExceptionRepository(IConfiguration configuration) : base(configuration) { }
        public async Task SaveLogs(ExceptionModel model)
        {
            await CommandAsync<SpResponse>("sp_AddLog", model);
        }
    }
}
