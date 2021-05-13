using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ExecuteActionModel
    {
        public int ApplicationId { get; set; }
        public int StageActionId { get; set; }
        public string UserId { get; set; }
        public string CreatorName { get; set; }
        public string Comments { get; set; }
        public string Data { get; set; } 
        public string Users { get; set; }
    }
}
