using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateTextResourcesDTO
    {
        public string Category {get; set;}
        public string Key {get; set;}
        public List<Values> Values {get; set;}
    }

    public class Values
    {
        public int Id {get; set;}
        public int LanguageId {get; set;}
        public string Value {get; set;}
    }
}