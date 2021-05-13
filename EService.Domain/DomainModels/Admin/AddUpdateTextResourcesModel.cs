using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class AddUpdateTextResourcesModel
    {
        public string Category {get; set;}
        public string Key {get; set;}
        public string Values {get; set;}
    }
}