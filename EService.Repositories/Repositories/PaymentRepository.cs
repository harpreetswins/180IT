using Admin.Data.GenericRepository;
using EService.Domain.DomainModels.Applications;
using EService.Domain.Interfaces.Applications;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace EService.Repositories.Repositories
{
    public class PaymentRepository : GenericRepository, IPaymentRepository
    {
        public PaymentRepository(IConfiguration configuration) : base(configuration) { }

        public async Task<UpdatedDetailsResponse> GetPaymentDetailsAsync(PaymentDetailResponseDTO model)
        {
            return await SingleAsync<UpdatedDetailsResponse>("sp_GetUpdateTransactionDetail", model);
        }

        public async Task<GetPaymentURL> GetPaymentURLAsync(GetPaymentURLDTO model)
        {
            return await SingleAsync<GetPaymentURL>("sp_GetApplicationPaymentDetail", model);
        }

        public async Task<IEnumerable<UserPaymentList>> UserPaymentListAsync(UserPaymentListDTO model)
        {
            return await Query<UserPaymentList>("sp_GetUserPaymentList", model);
        }
    }
}
