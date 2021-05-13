using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class GetFormSectionsByFormIdModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string FormSectionName { get; set; }
        public string FormSectionFields { get; set; }
        public string EntityFields { get; set; }
        public string FormSectionAttachments { get; set; }
    }
    public class GetFormSectionsByFormIdDTO
    {
        public int FormId { get; set; }
        public int EntityId { get; set; }
    }
}
