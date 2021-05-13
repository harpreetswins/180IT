using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class CurrentApplicationStatus
    {
        public string StatusName { get; set; }
    }
    public class BaseCurrentApplicationStatus : CurrentApplicationStatusDTO
    {
        public string UserId { get; set; }
        public string CreatorName { get; set; }
    }
    public class CurrentApplicationStatusDTO
    {
        public int ApplicationId { get; set; }        
    }
}
