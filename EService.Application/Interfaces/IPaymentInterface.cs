using EService.Domain.DomainModels.Applications;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Interfaces
{
    public interface IPaymentInterface
    {
        Task<GetPaymentURLResponse> GetPaymentURLAsync(GetPaymentURLDTO model);
        Task<UpdatedDetailsResponse> GetPaymentDetailsAsync(GetPaymentDetailsDTO model);
        Task<IEnumerable<UserPaymentList>> UserPaymentListAsync(UserPaymentListDTO model);
    }
}
