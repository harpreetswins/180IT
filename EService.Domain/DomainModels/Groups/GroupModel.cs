using EService.Domain.DomainModels.Services;
using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Groups
{
    public class GroupModel
    {
        public int? Id { get; set; }
        public string Groups { get; set; }
    }
    public class GetGroupServiceModel
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string ParentName { get; set; }
        public int ParentId { get; set; }
        public int GroupOrder { get; set; }
        public string Services { get; set; }

    }
}
