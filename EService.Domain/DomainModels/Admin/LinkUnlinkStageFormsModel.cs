using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class LinkUnlinkStageFormsModel
    {
        public int StageId { get; set; }
        public int FormId { get; set; }
        public bool Status { get; set; }
    }
}
