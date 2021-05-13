using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Users
{
    public class GetUserListModel
    {
        public int Id {get; set;}
        public string ExternalId {get; set;}
        public string UserName { get; set; }
    }
}