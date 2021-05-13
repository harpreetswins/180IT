using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class ReorderStagesModel
    {
        public int ServiceId { get; set; }
        public int StageId { get; set; }
        public int PreviousOrderNo { get; set; }
        public int NewOrderNo { get; set; }

    }
}
