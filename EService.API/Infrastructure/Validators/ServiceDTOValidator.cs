using EService.API.DTO.Services;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Validators
{
    public class ServiceDTOValidator: AbstractValidator<CreateServiceDTO>
    {
        public ServiceDTOValidator()
        {
            RuleFor(x => x.Name).NotEmpty();
            RuleFor(x => x.Description).NotEmpty();
        }
    }
}
