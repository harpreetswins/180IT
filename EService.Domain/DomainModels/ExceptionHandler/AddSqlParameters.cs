using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;

namespace EService.Domain.DomainModels.ExceptionHandler
{
    public class SqlParameters
    {
        public void Add(object input)
        {
            foreach (PropertyInfo prop in input.GetType().GetProperties())
            {
                
            }
            //return instance;
        }
    }
}
