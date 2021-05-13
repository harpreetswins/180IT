using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddServiceDTO
    {
        public int? Id { get; set; }
        public List<Service> Service { get; set; }
    }
    public class Service
    {
        public string ServiceName { get; set; }
        public int GroupId { get; set; }
        public int OrderNumber { get; set; }
        public int StartStageId { get; set; }
        public bool IsProfile { get; set; }
        public int LanguageId { get; set; }
        public string Description { get; set; }
    }
}
