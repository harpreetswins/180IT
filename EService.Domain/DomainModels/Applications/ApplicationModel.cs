using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ApplicationModel
    {
        public int ServiceId { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
        public string UserAgent { get; set; }
        public string ClientIP { get; set; }
        public int ParentApplication { get; set; }
        public int? ProfileAppId { get; set; }
    }
}
