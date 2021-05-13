using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Groups
{
    public class ReorderGroupModel
    {
        public int GroupId { get; set; }
        public int PreviousOrderNo { get; set; }
        public int NewOrderNo { get; set; }
    }
}
