using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Groups
{
    public class GetGroupsAndServices
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int ParentId { get; set; }
        public int OrderNumber { get; set; }
        public string ChildGroups { get; set; }
        public string GroupServices { get; set; }
    }
}
