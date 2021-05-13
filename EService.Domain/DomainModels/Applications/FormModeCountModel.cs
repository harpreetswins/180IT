using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ApplicationsCountsModel
    {
        public string Mode { get; set; }
    }
    public class ApplicationsCountsDTO
    {
        public string UserId { get; set; }
        public string CreatorName { get; set; }
        public string Role { get; set; }
    }
}
