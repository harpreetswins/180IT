using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Middlewares.ErrorDetail
{
    public class EServiceCustomException
    {
        public string Error { get; set; }
        public int UserId { get; set; }
        public int ApplicationId { get; set; }
        public int ServiceId { get; set; }
        public int LanguageId { get; set; }
        public string ExceptionOn { get; set; } = DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss");

        public EServiceCustomException(string error, int applicationId, int serviceId, int userId, int languageId)
        {
            Error = error;
            UserId = userId;
            ServiceId = serviceId;
            LanguageId = languageId;
            ApplicationId = applicationId;
        }

        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }
}
