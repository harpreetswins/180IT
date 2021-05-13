using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class GetStageActionByStageIdModel
    {
        public int StageActionId { get; set; }
        public string StageActionName { get; set; }
        public int OrderNumber { get; set; }
        public string StageName { get; set; }
        public string DestinationStageName { get; set; }
    }
}
