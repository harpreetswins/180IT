using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class GetPaymentURL
    {
        public int Id { get; set; }
        public string ApplicationNumber { get; set; }
        public string OrderNumber { get; set; }
        public string Services { get; set; }
        public string Status { get; set; }
        public string Message { get; set; }
    }
    public class GetPaymentURLResponse
    {
        public string OrderNumber { get; set; }
        public int? ErrorID { get; set; }
        public int? ResponseCode { get; set; }
        public string? RedirectURL { get; set; }
        public string Status { get; set; }
        public string Message { get; set; }
    }
    public class GetPaymentResponse
    {
        public string MerchantID { get; set; }
        public string Services { get; set; }
        public string ConfirmationURL { get; set; }
        public string Lang { get; set; }
        public string ApplicationNumber { get; set; }
        public string OrderNumber { get; set; }
        public string SecureHash { get; set; }
    }
    public class GetPaymentURLDTO : BaseGetPaymentURLDTO
    {
        public string UserId { get; set; }
        public string CreatorName { get; set; }
        public int LanguageId { get; set; }
    }

    public class BaseGetPaymentURLDTO
    {
        public int ApplicationId { get; set; }
        public int StageActionId { get; set; }
    }

    public class UpdatedDetailsResponse : Permissions
    {
        public string TransactionDetail { get; set; }
        public int Status { get; set; }
        public string SuccessMessage { get; set; }
        public string ErrorMessage { get; set; }
    }

}
