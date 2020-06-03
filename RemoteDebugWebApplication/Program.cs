using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace RemoteDebugWebApplication
{
  public class Program
  {
    public static void Main(string[] args)
    {
      CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder =>
            {
              var hostUrl = webBuilder.GetSetting("hosturl");
              if (string.IsNullOrEmpty(hostUrl))
                hostUrl = "http://0.0.0.0:5000";

              webBuilder.UseStartup<Startup>()
                .UseKestrel()
                .UseUrls(hostUrl);
            });
  }
}
