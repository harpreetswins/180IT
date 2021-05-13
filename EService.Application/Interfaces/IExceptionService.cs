using EService.Domain.DomainModels.Exception.Models;
using EService.Domain.DomainModels.Response;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IExceptionService
    {
        Task SaveLogs(ExceptionModel model);
    }
}
