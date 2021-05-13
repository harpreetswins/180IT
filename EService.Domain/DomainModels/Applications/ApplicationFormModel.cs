using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ApplicationFormModel : Permissions
    {
        public int StageId { get; set; }
        public string ApplicationNumber { get; set; }
        public int OrderNumber { get; set; }
        public DateTime CreatedDate { get; set; }
        public int CreatorId { get; set; }
        public string Name { get; set; }
        public string StageName { get; set; }
        public int? ProfileAppId { get; set; }
        public int CurrentStatusId { get; set; }
        public string CurrentStatusName { get; set; }
        public string Forms { get; set; }
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string Actions { get; set; }
    }

    public class ApplicationFormDTO
    {
        public int ApplicationId { get; set; }
        public int? StageId { get; set; }
    }
    public class BaseApplicationFormDTO : ApplicationFormDTO
    {
        public string Role { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }

    public class Permissions
    {
        public bool IsPermission { get; set; }
    }
}
