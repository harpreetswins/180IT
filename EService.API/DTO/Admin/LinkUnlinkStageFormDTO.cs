using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class LinkUnlinkStageFormDTO
    {
        public int StageId { get; set; }
        public int FormId { get; set; }
        public bool Status { get; set; }
    }
}
