using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class AddUpdateEntityFieldsModel
    {
        public int? Id { get; set; }
        public string EntityFields { get; set; }
    }
}
