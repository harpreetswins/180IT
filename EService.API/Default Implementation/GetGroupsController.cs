using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using EService.API.Controllers;
using EService.API.DTO;
using EService.API.DTO.Admin;
using EService.API.Infrastructure.CustomMapper;
using EService.API.Infrastructure.Middlewares.JwtMiddleware;
using EService.API.Infrastructure.Middlewares.LanguageMiddleware;
using EService.Application.Interfaces;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Response.Admin;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EService.API.Default_Implementation
{
    public class GetGroupsController : BaseController
    {
        private readonly IGroupInterface _groupInterface;
        private readonly IMapper _mapper;
        public GetGroupsController(IGroupInterface groupInterface, IMapper mapper, IUserProvider userProvider, ILanguageProvider languageProvider) : base(userProvider, languageProvider)
        {
            _groupInterface = groupInterface;
            _mapper = mapper;
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Get()
        {
            return Ok(await _groupInterface.GetGroupsAndServices());
        }
    }
}
