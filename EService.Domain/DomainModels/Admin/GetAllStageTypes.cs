using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class GetAllStageTypes
    {
        public int Id { get; set; }
        public string StageTypeName { get; set; }
        public string StageTypes { get; set; }
    }
}
