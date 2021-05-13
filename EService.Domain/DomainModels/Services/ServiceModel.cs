using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Services
{
    public class ServiceModel
    {

        [JsonProperty]
        public string Name { get; set; }
        [JsonProperty]
        public string Description { get; set; }
    }
}
