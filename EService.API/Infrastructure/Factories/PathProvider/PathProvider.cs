using Microsoft.AspNetCore.Hosting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Factories.PathProvider
{
    public class PathProvider : IPathProvider
    {
        private IWebHostEnvironment _hostEnvironment;

        public PathProvider(IWebHostEnvironment environment)
        {
            _hostEnvironment = environment;
        }

        public string MapPath(string path)
        {
            string filePath = Path.Combine(_hostEnvironment.ContentRootPath, path);
            return filePath;
        }
    }
}
