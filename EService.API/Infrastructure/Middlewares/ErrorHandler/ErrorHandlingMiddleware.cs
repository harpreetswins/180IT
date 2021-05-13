﻿using System;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using EService.API.Infrastructure.Factories.LogFiles;
using EService.API.Infrastructure.Factories.PathProvider;
using EService.API.Infrastructure.Middlewares.ErrorDetail;
using EService.API.Infrastructure.Middlewares.Exceptions;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Exception.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Shyjus.BrowserDetection;

namespace EService.API.Infrastructure.Middlewares.ExceptionHandler
{
    public class ErrorHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger _logger;
        private readonly IPathProvider _pathProvider;
        public ErrorHandlingMiddleware(RequestDelegate next, ILoggerFactory loggerFactory, IPathProvider pathProvider)
        {
            _next = next;
            _logger = loggerFactory.CreateLogger<ErrorHandlingMiddleware>();
            _pathProvider = pathProvider;
        }

        public async Task Invoke(HttpContext context, IWebHostEnvironment env, IBrowserDetector detector, IExceptionService exceptionService)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex, env, detector,exceptionService);
            }
        }

        private Task HandleExceptionAsync(HttpContext context, Exception exception, IWebHostEnvironment env, IBrowserDetector detector, IExceptionService _exceptionService)
        {
            CreateLogFile.CreateFileIfNotExist(_pathProvider);
            HttpStatusCode status;
            long ExceptionId = DateTime.Now.Ticks;
            string Message = String.Empty;
            string BrowserName = "static";//detector.Browser.Name?? null;
            string Log = String.Empty;

            var exceptionType = exception.GetType();
            Message = exception.Message;
            if (exception.Message.Contains("network-related"))
            {
                status = HttpStatusCode.InternalServerError;
                Log = JsonConvert.SerializeObject(new { Id = ExceptionId, Browser = BrowserName, Status = status, Error = Message });
            }
            else
            {
                if (exceptionType == typeof(BadRequestException))
                {
                    status = HttpStatusCode.BadRequest;
                    Log = JsonConvert.SerializeObject(new { Id = ExceptionId, Browser = BrowserName, Status = status, Error = JsonConvert.DeserializeObject<EServiceCustomException>(Message) });
                }
                else if (exceptionType == typeof(NotFoundException))
                {
                    status = HttpStatusCode.NotFound;
                    Log = JsonConvert.SerializeObject(new { Id = ExceptionId, Browser = BrowserName, Status = status, Error = Message });
                }
                else
                {
                    status = HttpStatusCode.InternalServerError;
                    Log = Message;
                }
                
                _exceptionService.SaveLogs(new ExceptionModel() { Browser = BrowserName, ExceptionId = ExceptionId.ToString(), Error = Message, Status = status.ToString() });
            }
            CreateLogFile.Log(_pathProvider, Log);
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)status;
            return context.Response.WriteAsync(Log);
        }

        private static string GetUserAgent(HttpContext context)
        {
            int HasValue = context.Request.Headers["User-Agent"].Count;
            if (HasValue > 0)
                return context.Request.Headers["User-Agent"][0];
            return String.Empty;
        }
    }
}
