using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Applications
{
    public class UploadActionAttachmentDTO : BaseUploadActionAttachmentDTO
    {
        public string FileName { get; set; }
        public string Extension { get; set; }
        public decimal Size { get; set; }
        public string MimeType { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
        public byte[] Image { get; set; }
    }

    public class BaseUploadActionAttachmentDTO 
    {
        public int ApplicationId { get; set; }
        public int ActionTypeId { get; set; }
        public int? AppStageActionId { get; set; }
        public int ApplicationStageId { get; set; }
        public int? ItemIndex { get; set; }
        public IFormFile files { get; set; }
    }
}
