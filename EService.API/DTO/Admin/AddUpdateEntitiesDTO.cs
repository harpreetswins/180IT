using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateEntitiesDTO
    {
        public List<Entities> Entities { get; set; }
    }

    public class Entities
    {
        public int EntityId { get; set; }
        public string Name { get; set; }
        public int LanguageId { get; set; }
    }
}
