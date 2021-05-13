using System;
using System.Collections.Generic;
using System.Text;

namespace EService.Domain.DomainModels.ExceptionHandler
{
    public class SqlExceptionHandler : System.Exception
    {
        public string StoreProcedure { get; set; }
        public string Exception { get; set; }
        public string Params { get; set; }

        public SqlExceptionHandler(string message, string sp, string param)
        {
            StoreProcedure = sp;
            Exception = message;
            Params = param;
        }
    }
}
