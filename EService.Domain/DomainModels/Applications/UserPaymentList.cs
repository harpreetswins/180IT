using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class UserPaymentList
    {
        public string ApplicationNumber { get; set; }
        public string OrderNumber { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
        public string Status { get; set; }
        public string ServiceName { get; set; }
        public string PaymentType { get; set; }
        public string TotalRows { get; set; }
    }

    public class UserPaymentListDTO : BaseUserPaymentListDTO
    {
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }
    public class BaseUserPaymentListDTO
    {
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public DateTime? Start { get; set; }
        public DateTime? End { get; set; }
        public string? Search { get; set; }
    }
}
