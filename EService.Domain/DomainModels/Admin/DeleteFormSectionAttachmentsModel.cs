using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Admin
{
    public class DeleteFormSectionAttachmentsModel
    {
        public int AttachmentId {get; set;}
        public int FormSectionId {get; set;}
    }
}
