using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.Response.Admin
{
    public class AdminSpResponse
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Status { get; set; }        
        public string Message { get; set; }
    }
    public class GroupsResponse : AdminSpResponse
    {
        public string? OrderNumber { get; set; }
    }
}
