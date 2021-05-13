using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateFormSectionDTO
    {
        public int? Id { get; set; }
        public List<FormSection> FormSection { get; set; }
    }

    public class FormSection
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int FormId { get; set; }
        public string Settings { get; set; }
        public int LanguageId { get; set; }
    }
}
