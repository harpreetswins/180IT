using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class LinkUnlinkFormSectionFieldsModel
    {
        public int EntityFieldId { get; set; }
        public int FormSectionId { get; set; }
        public bool Status { get; set; }
    }
}
