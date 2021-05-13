using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class GetStagesByServiceIdModel
    {
        public int StageId { get; set; }
        public string StageName { get; set; }
        public int OrderNumber { get; set; }
        public string StageTypeName { get; set; }
        public string Forms { get; set; }
        public string Actions { get; set; }
        public string FormMode { get; set; }
    }
}
