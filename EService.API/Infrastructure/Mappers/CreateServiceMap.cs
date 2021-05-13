using AutoMapper;
using EService.API.DTO.Admin;
using EService.API.DTO.Applications;
using EService.API.DTO.Services;
using EService.Domain.DomainModels.Admin;
using EService.Domain.DomainModels.Applications;
using EService.Domain.DomainModels.Groups;
using EService.Domain.DomainModels.Services;
using EService.Domain.DomainModels.UploadAttachments;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EService.API.Infrastructure.Mappers
{
    public class CreateServiceMap:Profile
    {
        public CreateServiceMap()
        {
            CreateMap<CreateServiceDTO, ServiceModel>().ReverseMap();
            CreateMap<CreateApplicationDTO, ApplicationModel>().ReverseMap();
            CreateMap<ExecuteActionDTO, ExecuteActionModel>().ReverseMap();
            CreateMap<UploadAttachmentDTO, UploadAttachmentModel>().ReverseMap();
            CreateMap<GroupDTO, GroupModel>().ReverseMap();
            CreateMap<AddServiceDTO, AddServiceModel>().ReverseMap();
            CreateMap<LinkUnlinkStageFormDTO, LinkUnlinkStageFormsModel>().ReverseMap();
            CreateMap<UploadActionAttachmentDTO, UploadActionAttachmentsModel>().ReverseMap();
            CreateMap<LinkUnlinkFormSectionFieldsDTO, LinkUnlinkFormSectionFieldsModel>().ReverseMap();
            CreateMap<AddUpdateStageFormModeDTO, AddUpdateStageFormModeModel>().ReverseMap();
        }
    }
}
