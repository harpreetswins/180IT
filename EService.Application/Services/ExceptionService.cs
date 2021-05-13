using EService.Application.Interfaces;
using EService.Domain.DomainModels.Exception.Exception;
using EService.Domain.DomainModels.Exception.Models;
using EService.Domain.DomainModels.Response;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class ExceptionService : IExceptionService
    {
        private readonly IExceptionInterface _exceptionRepository;
        public ExceptionService(IExceptionInterface exceptionRepository)
        {
            _exceptionRepository = exceptionRepository;
        }
        public async Task SaveLogs(ExceptionModel model)
        {
             await _exceptionRepository.SaveLogs(model);
        }
    }
}
