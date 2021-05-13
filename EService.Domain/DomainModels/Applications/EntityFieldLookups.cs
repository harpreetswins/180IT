using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class EntityFieldLookups
    {
        public int EntityFieldId { get; set; }
        public int? FormSectionId { get; set; }
        public int FieldTypeId { get; set; }
        public string FieldTypeName { get; set; }
        public string EntityData { get; set; }
    }
    public class BaseEntityFieldLookups : EntityFieldLookupsDTO
    {
        public int LanguageId { get; set; }
    }
    public class EntityFieldLookupsDTO
    {
        public int FormId { get; set; }
        public int ServiceId { get; set; }
    }    
}
