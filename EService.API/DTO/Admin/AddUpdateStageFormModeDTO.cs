using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateStageFormModeDTO
    {
        public int StageId {get; set;}
        public int FormId {get; set;}
        public int FormModeId {get; set;}
    }
}