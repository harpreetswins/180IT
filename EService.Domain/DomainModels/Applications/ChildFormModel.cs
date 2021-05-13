using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ChildFormModel
    {
        public string ChildFormFields { get; set; }
    }

    public class ChildFormDTO
    {
        public int ApplicationId { get; set; }
        public int EntityId { get; set; }
        public int FormSectionFieldId { get; set; }
    }
}
