using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.UploadAttachments
{
    public class GetActionAttachmentModel
    {
        public int ApplicationId { get; set; }
        public int ApplicationStageId { get; set; }
        public byte[] FileName { get; set; }
        public string Name { get; set; }
        public string Extension { get; set;}
    }
    public class GetActionAttachmentDTO
    {
        public int ApplicationId { get; set; }
        public int ActionAttachmentId { get; set; }
    }
}
