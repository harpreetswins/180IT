using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class CurrentStageModel
    {
        public int Id { get; set; }
        public int StageStatusId { get; set; }
        public int StageActionId { get; set; }
    }
}
