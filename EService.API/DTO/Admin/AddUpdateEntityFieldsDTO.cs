using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateEntityFieldsDTO
    {
        public int? Id { get; set; }
        public List<EntityFields> EntityFields { get; set; }
    }

    public class EntityFields
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int FieldTypeId { get; set; }
        public int FormSectionId { get; set; }
        public int EntityId { get; set; }
        public string ConstraintTypeId { get; set; }
        public int LanguageId { get; set; }
        public string Settings { get; set; }
        public bool IsPromoted { get; set; }
    }
}
