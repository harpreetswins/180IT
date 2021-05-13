using System;

namespace EService.API.Infrastructure.Middlewares.Exceptions
{
    public class BadRequestException : Exception
    {
        public BadRequestException(string message) : base(message)
        { }
    }
}