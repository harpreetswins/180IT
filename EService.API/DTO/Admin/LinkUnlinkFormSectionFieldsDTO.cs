using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class LinkUnlinkFormSectionFieldsDTO
    {
        public int EntityFieldId { get; set; }
        public int FormSectionId { get; set; }
        public bool Status { get; set; }
    }
}
