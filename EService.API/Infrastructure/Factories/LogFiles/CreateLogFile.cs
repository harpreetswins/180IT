using EService.API.Infrastructure.Factories.PathProvider;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Factories.LogFiles
{
    public class CreateLogFile
    {
        public static void CreateFileIfNotExist(IPathProvider pathProvider)
        {
           string FolderPath= pathProvider.MapPath("Logs");
            if(!string.IsNullOrEmpty(FolderPath))
            {
                string FileName = string.Concat(DateTime.Now.ToString("MMMM_dd_yyyy"),".txt");
                string FilePath= Path.Combine(FolderPath, FileName);
                if (!File.Exists(FilePath))
                    File.Create(FilePath).Close();
            }
        }
        public static void Log(IPathProvider pathProvider,string message)
        {
            string FolderPath = pathProvider.MapPath("Logs");
            string FileName = string.Concat(DateTime.Now.ToString("MMMM_dd_yyyy"), ".txt");
            string FilePath = Path.Combine(FolderPath, FileName);

          
           
            using (StreamWriter writer = File.AppendText(FilePath))
            {
                writer.WriteLine("");
                writer.WriteLine($"#########################   {DateTime.Now.ToString("dddd dd MMMM hh:mm:ss")}    ##################################");
                writer.WriteLine(message);
                writer.Dispose();

            }
        }
    }
}
