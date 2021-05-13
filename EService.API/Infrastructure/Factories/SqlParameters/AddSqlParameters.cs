using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Factories.SqlParameters
{
    public class AddSqlParameters<T>
    {
        public string Add(string sp,T input)
        {
            StringBuilder builder = new StringBuilder();
            foreach (PropertyInfo prop in input.GetType().GetProperties())
            {
                var value = typeof(T).GetProperty(prop.Name).GetValue(input);
                builder.Append($"@{prop.Name}={value},");
            }
            return string.Format("execute {0} {1}", sp, builder.ToString().Substring(0, builder.ToString().Length - 1));
        }
    }
}
