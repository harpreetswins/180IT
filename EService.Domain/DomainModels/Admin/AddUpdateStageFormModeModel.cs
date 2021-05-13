using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class AddUpdateStageFormModeModel
    {
        public int StageId {get; set;}
        public int FormId {get; set;}
        public int FormModeId {get; set;}
    }
}