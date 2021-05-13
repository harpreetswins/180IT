using EService.Domain.DomainModels.Applications;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Domain.Interfaces.Applications
{
    public interface IPaymentRepository
    {
        Task<GetPaymentURL> GetPaymentURLAsync(GetPaymentURLDTO model);
        Task<UpdatedDetailsResponse> GetPaymentDetailsAsync(PaymentDetailResponseDTO model);
        Task<IEnumerable<UserPaymentList>> UserPaymentListAsync(UserPaymentListDTO model);
    }
}
