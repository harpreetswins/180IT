using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.UploadAttachments
{
    public class GetAttachmentModel : GetAttachmentDTO
    {
        public string Name { get; set; }
        public string Extension { get; set; }
        public byte[] FileName { get; set; }
    }
    public class GetAttachmentDTO
    {
        public int ApplicationId { get; set; }
        public int ApplicationStageId { get; set; }
        public int AttachmentId { get; set; }
    }
}
