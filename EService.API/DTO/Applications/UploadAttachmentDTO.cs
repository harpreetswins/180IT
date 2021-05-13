using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.DTO.Applications
{
    public class UploadAttachmentDTO : BaseUploadAttachmentDTO
    {
        public string FileName { get; set; }
        public string Extension { get; set; }
        public decimal Size { get; set; }
        public string MimeType { get; set; }
        public string CreatorId { get; set; }
        public string CreatorName { get; set; }
        public byte[] Image { get; set; }
    }
    public class BaseUploadAttachmentDTO
    {
        public int ApplicationId { get; set; }
        public int ApplicationStageId { get; set; }
        public int AttachmentTypeId { get; set; }
        public int AttachmentId { get; set; }
        public int? ItemIndex { get; set; }
        public IFormFile files { get; set; }
         
    }
}
