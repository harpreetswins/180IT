using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class GroupDTO
    {
        public int? Id { get; set; }
        public List<Groups> Groups { get; set; }
    }

    public class Groups
    {
        public string GroupName { get; set; }
        public int? ParentGroupId { get; set; }
        public int OrderNumber { get; set; }
        public int LanguageId { get; set; }
        public string Description { get; set; }
    }
}
