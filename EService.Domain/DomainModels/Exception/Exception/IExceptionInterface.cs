using EService.Domain.DomainModels.Exception.Models;
using EService.Domain.DomainModels.Response;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.DomainModels.Exception.Exception
{
    public interface IExceptionInterface
    {
        Task SaveLogs(ExceptionModel model);
    }
}
