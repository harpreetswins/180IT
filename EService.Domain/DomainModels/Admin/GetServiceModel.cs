using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class GetServiceModel
    {
        public int Id { get; set; } 
        public int LanguageId { get; set; }
        public string ServiceName { get; set; }
        public string ServiceDescription { get; set; }
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int OrderNumber { get; set; }
        public int StartStageID { get; set; }
    }
}
