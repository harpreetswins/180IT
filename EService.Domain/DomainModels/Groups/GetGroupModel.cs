using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Groups
{
    public class GetGroupModel
    {
        public int GroupId { get; set; }       
        public int? ParentId { get; set; }
        public int OrderNumber { get; set; }
        public int LanguageId { get; set; }
        public string GroupName { get; set; }
        public string GroupDescription { get; set; }
    }
}
