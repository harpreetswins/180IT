using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Admin
{
    public class AddUpdateFormSectionAttachmentsDTO
    {
        public int? Id { get; set; }
        public List<SectionAttachments> SectionAttachments { get; set; }
    }

    public class SectionAttachments
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int AttachmentTypeId { get; set; }
        public int FormSectionId { get; set; }
        public int LanguageId { get; set; }
    }
}
