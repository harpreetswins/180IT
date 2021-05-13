using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Groups
{
    public class DeleteGroupModel
    {
        public int GroupId { get; set; }
        public int? DeletedBy { get; set; }
    }
}
