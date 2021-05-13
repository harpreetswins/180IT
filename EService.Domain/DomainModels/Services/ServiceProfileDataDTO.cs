using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Services
{
    public class ServiceProfileDataDTO
    {
        public int ServiceId { get; set; }
        public int? ProfileAppId { get; set; }
    }
    public class BaseServiceProfileDataDTO : ServiceProfileDataDTO
    {
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }
    public class ServiceRelatedDataDTO
    {
        public int FormSectionFieldId { get; set; }
    }
       public class BaseServiceRelatedDataDTO : ServiceRelatedDataDTO
    {
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
    }
}
