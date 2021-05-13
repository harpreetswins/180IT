using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class ReorderServicesModel
    {
        public int GroupId { get; set; }
        public int ServiceId { get; set; }
        public int PreviousOrderNo { get; set; }
        public int NewOrderNo { get; set; }
    }
}
