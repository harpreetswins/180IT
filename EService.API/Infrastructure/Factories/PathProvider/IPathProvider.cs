using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Factories.PathProvider
{
    public interface IPathProvider
    {
        string MapPath(string path);
    }
}
