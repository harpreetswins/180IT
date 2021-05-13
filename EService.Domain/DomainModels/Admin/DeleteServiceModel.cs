using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class DeleteServiceModel
    {
        public int ServiceId { get; set; }
        public int? DeletedBy { get; set; }
    }
}
