using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EService.API.Controllers;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Applications;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Default_Implementation
{
    public class PaymentController : BaseController
    {
        private readonly IPaymentInterface _paymentInterface;
        public PaymentController(IPaymentInterface paymentInterface, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _paymentInterface = paymentInterface;
        }

        [HttpGet("GetApplicationPaymentURL")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetPaymentURLAsync([FromQuery] BaseGetPaymentURLDTO model)
        {
            GetPaymentURLDTO dto = new GetPaymentURLDTO();

            int LanguageId = _languageProvider.GetLanguageId();
            dto.ApplicationId = model.ApplicationId;
            dto.UserId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.LanguageId = LanguageId;
            dto.StageActionId = model.StageActionId;
            return Ok(await _paymentInterface.GetPaymentURLAsync(dto));
        }

        [HttpGet("GetApplicationPaymentDetails")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetPaymentDetailsAsync([FromQuery] string OrderNumber)
        {
            GetPaymentDetailsDTO dto = new GetPaymentDetailsDTO();

            int LanguageId = _languageProvider.GetLanguageId();
            dto.OrderNumber = OrderNumber;
            dto.LanguageId = LanguageId;
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            return Ok(await _paymentInterface.GetPaymentDetailsAsync(dto));
        }

        [HttpGet("GetUserPaymentLists")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetUserPaymentListAsync([FromQuery] BaseUserPaymentListDTO model)
        {
            UserPaymentListDTO dto = new UserPaymentListDTO();
            dto.CreatorId = this._userProvider.GetUserId();
            dto.CreatorName = this._userProvider.GetUserName();
            dto.PageNumber = model.PageNumber;
            dto.PageSize = model.PageSize;
            dto.Start = model.Start;
            dto.End = model.End;
            dto.Search = model.Search;
            return Ok(await _paymentInterface.UserPaymentListAsync(dto));
        }
    }
}
