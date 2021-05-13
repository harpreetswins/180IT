using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddStageActionsDTO
    {
        public int StageId { get; set; }
        public int? StageActionId { get; set; }
        public List<StageAction> StageAction { get; set; }
    }

    public class StageAction
    {
        public string StageActionName { get; set; }
        public int ActionTypeId { get; set; }
        public int StageId { get; set; }
        public int DestinationStageId { get; set; }
        public int LanguageId { get; set; }
        public string Description { get; set; }
        public string Roles { get; set; }
    }
}
