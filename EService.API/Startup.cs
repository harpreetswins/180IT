using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using AutoMapper;
using EService.API.Infrastructure.Filters;
using FluentValidation.AspNetCore;
using EService.Application.Interfaces;
using EService.Application.Services;
using EService.Domain.Interfaces.Services;
using EService.Repositories.Repositories;
using Admin.Data.GenericRepository;
using EService.Domain.Interfaces.Applications;
using EService.Domain.Interfaces.UploadAttachments;
using EService.API.Infrastructure.Middlewares.ExceptionHandler;
using Excepticon.AspNetCore;
using Excepticon.Extensions;
using EService.Domain.DomainModels.Exception.Exception;
using EService.Repositories.Repositories.Exception;
using EService.API.Infrastructure.Factories.PathProvider;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Logging;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.Application.Interfaces.Admin;
using EService.Application.Services.Admin;
using EService.Domain.Interfaces.Admin;
using EService.Repositories.Repositories.Admin;
using System.Security.Cryptography.X509Certificates;
using IdentityServer4.AccessTokenValidation;
using EService.Domain.Interfaces.User;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;

namespace EService.API
{
    public class Startup
    {
        private readonly string corsPolicy = "corsPolicy";
        public IConfiguration Configuration { get; }
        public IWebHostEnvironment WebHostEnvironment { get; }

        public Startup(IConfiguration configuration, IWebHostEnvironment webHostEnvironment)
        {
            Configuration = configuration;
            WebHostEnvironment = webHostEnvironment;
        }

        public void ConfigureServices(IServiceCollection services)
        {
            IdentityModelEventSource.ShowPII = true;
            services.AddBrowserDetection();
            services.AddControllers();

            services.AddCors(o =>
            {
                o.AddPolicy(name: corsPolicy,
                              builder =>
                              {
                                  builder.AllowAnyOrigin()
                                      .AllowAnyMethod()
                                      .AllowAnyHeader();
                              });
            });

            //var JwtSigningCertificate = new X509Certificate2(WebHostEnvironment.ContentRootPath + @"\Resources\JwtSigningKey.cer");
            services.AddAuthentication("Bearer")
            .AddJwtBearer("Bearer", options =>
            {
                options.Authority = Configuration["Authority"];

                options.TokenValidationParameters.AuthenticationType = "at+jwt";

                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateAudience = false,
                    ValidateIssuerSigningKey = true,
                    //IssuerSigningKey = new X509SecurityKey(JwtSigningCertificate)
                };
            });

            services.AddAuthorization(options => options.AddPolicy("openid",
             authBuilder =>
             {
                 authBuilder.RequireRole("openid");
             }));


            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Version = "v1",
                    Title = "E-Services",
                });
            });

            services.AddExcepticon();
            services.AddTransient<GenericRepository>();
            services.AddTransient<IServiceInterface, ConcreteService>();
            services.AddTransient<IServiceRepository, ServiceRepository>();
            services.AddTransient<IResourceKeyValuesRepository, ResourceKeyValuesRepository>();
            services.AddTransient<IResourceKeyValues, ResourceKeyValuesService>();
            services.AddTransient<ILanguageRepository, LanguageRepository>();
            services.AddTransient<ILanguageInterface, LanguageService>();
            services.AddTransient<IApplicationRepository, ApplicationRepository>();
            services.AddTransient<IApplicationInterface, ApplicationService>();
            services.AddTransient<IUserPermissionServiceInterface, UserPermissionService>();
            services.AddTransient<IUserPermissionServiceRepository, UserPermissionForServiceRepository>();
            services.AddTransient<IUploadAttachments, UploadAttachmentService>();
            services.AddTransient<IUploadAttachmentRepository, UploadAttachmentRepository>();
            services.AddTransient<IUserProvider, UserProvider>();
            services.AddTransient<ILanguageProvider, LanguageProvider>();
            services.AddTransient<IGroupInterface, GroupService>();
            services.AddTransient<IGroupRepository, GroupRepository>();
            services.AddTransient<IAddServiceInterface, AddService>();
            services.AddTransient<IAddServiceRepository, AddServiceRepository>();
            services.AddTransient<IEntityInterface, EntityServices>();
            services.AddTransient<IEntityRepository, EntityRepository>();
            services.AddTransient<IPaymentInterface, PaymentService>();
            services.AddTransient<IPaymentRepository, PaymentRepository>();
            services.AddTransient<IFormsInterface, FormsService>();
            services.AddTransient<IFormsRepository, FormsRepository>();
            services.AddTransient<IUsersInterface, UsersServices>();
            services.AddTransient<IUsersRepository, UsersRepository>();
            services.AddTransient<ITextResourcesInterface, TextResourcesService>();
            services.AddTransient<ITextResourcesRepository, TextRepositoryRepository>();

            /** path provider **/
            services.AddSingleton<IPathProvider, PathProvider>();
            /** Save exception logs in database **/
            services.AddTransient<IExceptionInterface, ExceptionRepository>();
            services.AddTransient<IExceptionService, ExceptionService>();

            services.AddMvc(options =>
            {
                options.EnableEndpointRouting = false;
                options.Filters.Add(new ValidatonFilter());
            }).SetCompatibilityVersion(CompatibilityVersion.Latest).AddFluentValidation(options =>
            {
                options.RegisterValidatorsFromAssemblyContaining<Startup>();
            });

            services.AddApiVersioning(config =>
            {
                config.DefaultApiVersion = new ApiVersion(1, 0);
                config.AssumeDefaultVersionWhenUnspecified = true;
                config.ReportApiVersions = true;
            });
            services.AddAutoMapper(typeof(Startup));
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {


            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }


            app.UseMiddleware(typeof(ErrorHandlingMiddleware));

            app.UseExcepticon();
            app.UseHttpsRedirection();
            app.UseCors(corsPolicy);
           
            app.UseRouting();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "E-Services");
            });

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers().RequireAuthorization();

            });
        }
    }
}
