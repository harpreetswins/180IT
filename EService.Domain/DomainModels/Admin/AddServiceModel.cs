using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class AddServiceModel
    {     
        //public int GroupId { get; set; }
        //public int OrderNumber { get; set; }
        //public int StartStageId { get; set; }
        public int? Id { get; set; }
        public string Service { get; set; }
    }
}
