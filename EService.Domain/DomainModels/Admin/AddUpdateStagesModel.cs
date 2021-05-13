using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class AddUpdateStagesModel
    {
        public int ServiceId { get; set; }
        public string Stages { get; set; }
    }
}
