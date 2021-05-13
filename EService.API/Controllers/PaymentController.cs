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

namespace EService.API.Controllers
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1.0", Deprecated = true)]
    [ApiVersion("1.1")]
    [ApiController]
    [Authorize]
    public class PaymentController : BaseController
    {
        private readonly IPaymentInterface _paymentInterface;
        private readonly Custom_Implementation.PaymentController CustomPaymentController;

        public PaymentController(IPaymentInterface paymentInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _paymentInterface = paymentInterface;
            CustomPaymentController = new Custom_Implementation.PaymentController(paymentInterface, userProvider, languageProvider);
        }

        [HttpGet("GetApplicationPaymentURL")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetPaymentURLAsync([FromQuery] BaseGetPaymentURLDTO model)
        {
            return await CustomPaymentController.GetPaymentURLAsync(model);
        }

        [HttpGet("GetApplicationPaymentDetails")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetPaymentDetailsAsync([FromQuery] string OrderNumber)
        {
            return await CustomPaymentController.GetPaymentDetailsAsync(OrderNumber);
        }

        [HttpGet("GetUserPaymentLists")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserPaymentListAsync([FromQuery] BaseUserPaymentListDTO model)
        {
            return await CustomPaymentController.GetUserPaymentListAsync(model);
        }
    }
}
