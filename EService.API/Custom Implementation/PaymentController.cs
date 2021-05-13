using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Custom_Implementation
{
    public class PaymentController
    {
        private readonly IPaymentInterface _paymentInterface;
        private readonly Default_Implementation.PaymentController DefaultPaymentController;

        public PaymentController(IPaymentInterface paymentInterface, IUserProvider userProvider, ILanguageProvider languageProvider)
        {
            _paymentInterface = paymentInterface;
            DefaultPaymentController = new Default_Implementation.PaymentController(paymentInterface, userProvider, languageProvider);
        }

        public async Task<IActionResult> GetPaymentURLAsync([FromQuery] BaseGetPaymentURLDTO model)
        {
            return await DefaultPaymentController.GetPaymentURLAsync(model);
        }

        public async Task<IActionResult> GetPaymentDetailsAsync([FromQuery] string OrderNumber)
        {
            return await DefaultPaymentController.GetPaymentDetailsAsync(OrderNumber);
        }

        public async Task<IActionResult> GetUserPaymentListAsync([FromQuery] BaseUserPaymentListDTO model)
        {
            return await DefaultPaymentController.GetUserPaymentListAsync(model);
        }
    }
}
