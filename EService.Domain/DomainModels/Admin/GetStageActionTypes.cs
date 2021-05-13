using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class GetStageActionTypes
    {
        public int StageId { get; set; }
        public int Id { get; set; }
        public string ActionType { get; set; }
    }
}
