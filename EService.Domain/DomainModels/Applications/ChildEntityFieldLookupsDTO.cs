using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class ChildEntityFieldLookupsDTO
    {
        public int FormSectionParentId { get; set; }
        public int ServiceId { get; set; }
    }
    public class BaseChildEntityFieldLookups : ChildEntityFieldLookupsDTO
    {
        public int LanguageId { get; set; }
    }
}
