using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Services
{
    public class CreateApplicationDTO: BaseCreateApplicationDTO
    {
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
        public string UserAgent { get; set; }
        public string ClientIP { get; set; }
    }
    public class BaseCreateApplicationDTO
    {
        public int ServiceId { get; set; }
        public int? ParentApplication { get; set; }
        public int? ProfileAppId { get; set; }
    }
}
