using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class AddStageActionModel
    {
        public int StageId { get; set; }
        public int? StageActionId { get; set; }
        public string StageAction { get; set; }
    }
}
