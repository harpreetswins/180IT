using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ActivityLogModel
    {
        public string ActivityLogs { get; set; }
    }
    public class ActivityLogDTO
    {
        public int ApplicationId { get; set; }
        public string UserId { get; set; }
        public string CreatorName { get; set; }
    }
}
