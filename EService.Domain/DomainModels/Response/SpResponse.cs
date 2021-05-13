using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Response
{
    public class SpResponse
    {
        public int Id { get; set; }
        public int Status { get; set; }
        public string SuccessMessage { get; set; }
        public string ErrorMessage { get; set; }
    }
}
