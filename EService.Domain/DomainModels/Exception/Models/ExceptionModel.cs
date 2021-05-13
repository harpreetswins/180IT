using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Exception.Models
{
    public class ExceptionModel
    {
        public string ExceptionId { get; set; }
        public string Browser { get; set; }
        public string Status { get; set; }
        public string Error { get; set; }
        //public string UserId { get; set; }
        //public int ApplicationId { get; set; }
        //public int ServiceId { get; set; }
    }
}
