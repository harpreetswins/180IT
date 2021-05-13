using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Services
{
    public class ResourceKeyValuesModel
    {
        public int Id { get; set; }
        public string Category { get; set; }
        public string Key { get; set; }
        public string Value { get; set; }
    }
}
