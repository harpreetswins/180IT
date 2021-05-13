using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class UserApplicationList
    {
        public int ApplicationStageId { get; set; }
        public int ApplicationId { get; set; }
        public string ApplicationNumber { get; set; }
        public string StatusName { get; set; }
        public string StageName { get; set; }
        public DateTime CreatedOn { get; set; }
        public string CreatedBy { get; set; }
        public string AssignedTo { get; set; }
        public int StageId { get; set; }
        public string TotalRows { get; set; }
        public int PercentCompleted { get; set; }
    }
    public class UserApplicationListDTO : BaseUserApplicationListDTO
    {
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
        public string Role {get; set;}
    }
    public class BaseUserApplicationListDTO
    {
        public int ServiceId { get; set; }
        public int StageId { get; set; }
        public int StageStatusId { get; set; }
        public string Mode {get; set;}
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public DateTime? Start { get; set; }
        public DateTime? End { get; set; }
        public string Search { get; set; }
    }
}
