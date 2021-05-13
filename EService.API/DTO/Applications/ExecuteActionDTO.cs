using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Applications
{
    public class ExecuteActionDTO : BaseExecuteActionDTO
    {
        public string UserId { get; set; }
        public string CreatorName { get; set; }
    }

    public class Data
    {
        public int entityFieldId { get; set; }
        public string value { get; set; }
        public IEnumerable<childrens> childrens { get; set; }
    }

    public class childrens
    {
        public int itemIndex { get; set; }
        public int entityFieldId { get; set; }
        public string value { get; set; }
    }

    public class BaseExecuteActionDTO
    {
        public int ApplicationId { get; set; }
        public int StageActionId { get; set; }
        public string Comments { get; set; }
        public IEnumerable<Data> Data { get; set; }
        public string Users { get; set; }
    }
}
