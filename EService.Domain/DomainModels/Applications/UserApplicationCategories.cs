using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Applications
{
    public class UserApplicationCategories
    {
        public int Status { get; set; }
        public string ApplicationCategories { get; set; }
    }
     public class UserApplicationCertificateCategories
    {
        public int Status { get; set; }
        public string CertificateCategories { get; set; }
    }
    public class UserApplicationCategoriesDTO
    {
        public string UserId { get; set; }
        public string CreatorName { get; set; }
        public string Mode {get; set;}
        public string Role {get; set;}
    }
}
