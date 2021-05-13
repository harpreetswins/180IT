using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class GetPaymentDetailsDTO
    {
        public string OrderNumber { get; set; }
        public int LanguageId { get; set; }
        public int Action { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }
    public class PaymentDetailDTO
    {
        public string MerchantID { get; set; }
        public string OrderNumber { get; set; }
        public string Lang { get; set; }
        public int Action { get; set; }
        public string SecureHashKey { get; set; }
    }

    public class PaymentDetailResponseDTO
    {
        public string OrderNumber { get; set; }
        public int LanguageId { get; set; }
        public string StatusMessage { get; set; }
        public string Status { get; set; }
        public decimal? EDirhamFees { get; set; }
        public string URN { get; set; }
        public decimal? TransactionAmount { get; set; }
        public string Services { get; set; }
        public string PaymentMethodType { get; set; }
        public string Success { get; set; }
        public int ErrorID { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }

    public class PaymentDetailResponse
    {
        public string OrderNumber { get; set; }
        public int LanguageId { get; set; }
        public string StatusMessage { get; set; }
        public string Status { get; set; }
        public decimal? EDirhamFees { get; set; }
        public string URN { get; set; }
        public decimal? TransactionAmount { get; set; }
        public List<service> Services { get; set; }
        public string PaymentMethodType { get; set; }
        public string Success { get; set; }
        public int ErrorID { get; set; }
    }

    public partial class service
    {
        public string ServiceCode { get; set; }
        public string Quantity { get; set; }
        public string Amount { get; set; }
        public string TotalAmount { get; set; }
        public string Tax { get; set; }
    }
}
