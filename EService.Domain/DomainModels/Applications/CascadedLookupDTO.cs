using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class CascadedLookupDTO
    {
        public int EntityFieldId { get; set; }
        public int Value { get; set; }
        public int? LookupParentId { get; set; }
    }
    public class BaseCascadedLookup : CascadedLookupDTO
    {
        public int LanguageId { get; set; }
    }
}
