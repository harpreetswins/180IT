using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateStagesDTO
    {
        public int ServiceId { get; set; }
        public List<Stages> Stages { get; set; }
    }

    public class Stages
    {
        public int StageId { get; set; }
        public string Name { get; set; }
        public int LanguageId { get; set; }
        public int StageTypeId { get; set; }
    }
}
