using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateFormsDTO
    {
        public int StageId { get; set; }
        public List<Forms> Forms { get; set; }
    }
    public class Forms
    {
        public int FormId { get; set; }
        public string Name { get; set; }
        public int LanguageId { get; set; }
        public int EntityId { get; set; }
    }
}
