using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class UserApplicationDetails
    {
        public string ApplicationNumber { get; set; }
        public string StageName { get; set; }
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string ApplicationStatus { get; set; }
        public string AssignedTo { get; set; }
        public string Notes { get; set; }
        public string Instructions { get; set; }
    }
    public class UserApplicationDetailsDTO
    {
        public int ApplicationId { get; set; }
        public string UserId { get; set; }
        public string CreatorName { get; set; }
    }
}
