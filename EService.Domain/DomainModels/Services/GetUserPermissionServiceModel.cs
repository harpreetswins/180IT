using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Services
{
    public class CheckServicePermissionDTO
    {
        public string ServiceId { get; set; }
        public int? StageActionId { get; set; }
    }
    public class BaseCheckServicePermissionDTO : CheckServicePermissionDTO
    {
        public string Role { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }
}
