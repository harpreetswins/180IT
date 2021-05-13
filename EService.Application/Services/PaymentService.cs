using EService.Application.Interfaces;
using EService.Domain.DomainModels.Applications;
using EService.Domain.Interfaces.Applications;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace EService.Application.Services
{
    public class PaymentService : IPaymentInterface
    {
        private readonly IPaymentRepository _paymentRepository;
        private readonly IConfiguration _configuration;

        public PaymentService(IPaymentRepository paymentRepository, IConfiguration configuration)
        {
            _paymentRepository = paymentRepository;
            _configuration = configuration;
        }

        public async Task<GetPaymentURLResponse> GetPaymentURLAsync(GetPaymentURLDTO model)
        {
            var merchantID = _configuration["Payments:MerchantID"];
            var confirmationURL = _configuration["Payments:ConfirmationURL"];
            var secureHashKey = _configuration["Payments:SecureHashKey"];
            var paymentAPIUrl = _configuration["Payments:PaymentAPIURL"];
            var lang = "";
            if (model.LanguageId == 1)
            {
                lang = "en";
            }
            else
            {
                lang = "ar";
            }

            var paymentDetailsResponse = await _paymentRepository.GetPaymentURLAsync(model);

            var servicecode = ""; int? quantity = 0; string? amount = "";
            var service_code = ""; string? quantityy = ""; string? amountt = "";

            GetPaymentURLResponse result = new GetPaymentURLResponse();

            if (paymentDetailsResponse.Message == "Failed" || paymentDetailsResponse.Message == "New")
            {
                dynamic service_data = JsonConvert.DeserializeObject(paymentDetailsResponse.Services);
                foreach (var src in service_data)
                {
                    foreach (var ss in src)
                    {
                        if (ss.Name == "ServiceCode")
                            servicecode = ss.Value;
                        if (ss.Name == "Quantity")
                            quantity = ss.Value;
                        if (ss.Name == "Amount")
                            amount = ss.Value;
                    }
                    service_code += servicecode;
                    amountt += Convert.ToString(amount);
                    quantityy += Convert.ToString(quantity);
                }

                StringBuilder buffer = new StringBuilder(secureHashKey + "" + paymentDetailsResponse.ApplicationNumber + "" + service_code + "" + amountt + "" + quantityy + "" + confirmationURL + "" + lang + "" + merchantID + "" + paymentDetailsResponse.OrderNumber);

                var hashkey = GetStringHash(secureHashKey, buffer);

                GetPaymentResponse paymentResponse = new GetPaymentResponse();
                paymentResponse.MerchantID = merchantID;
                paymentResponse.Services = paymentDetailsResponse.Services;
                paymentResponse.ConfirmationURL = confirmationURL;
                paymentResponse.Lang = lang;
                paymentResponse.ApplicationNumber = paymentDetailsResponse.ApplicationNumber;
                paymentResponse.OrderNumber = paymentDetailsResponse.OrderNumber;
                paymentResponse.SecureHash = hashkey;

                var client = new RestClient(paymentAPIUrl);
                client.Timeout = -1;
                var request = new RestRequest(Method.POST);
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", "{\r\n    \"merchantID\" : \"" + merchantID + "\",\r\n    \"services\" : " + paymentDetailsResponse.Services + " ,\r\n    \"confirmationURL\" : \"" + confirmationURL + "\",\r\n    \"lang\" : \"" + lang + "\",\r\n    \"applicationNumber\" : \"" + paymentDetailsResponse.ApplicationNumber + "\",\r\n    \"orderNumber\" : \"" + paymentDetailsResponse.OrderNumber + "\",\r\n    \"secureHash\" : \"" + hashkey + "\"\r\n}\r\n", ParameterType.RequestBody);
                IRestResponse response = client.Execute(request);

                var resp = JsonConvert.DeserializeObject<GetPaymentURLResponse>(response.Content);
                result.ErrorID = resp.ErrorID;
                result.RedirectURL = resp.RedirectURL;
            }

            if(paymentDetailsResponse.Message == "Check")
            {
                GetPaymentDetailsDTO paymentDetailsDTO = new GetPaymentDetailsDTO();
                paymentDetailsDTO.OrderNumber = paymentDetailsResponse.OrderNumber;
                paymentDetailsDTO.LanguageId = model.LanguageId;
                var new_result = await GetPaymentDetails(paymentDetailsDTO);
                var resultt = await _paymentRepository.GetPaymentDetailsAsync(new_result);
            }
           
            result.OrderNumber = paymentDetailsResponse.OrderNumber;
            result.Status = paymentDetailsResponse.Status;
            result.Message = paymentDetailsResponse.Message;

            return result;
        }

        public static string GetStringHash(string SECRET_KEY, StringBuilder buffer)
        {
            var data = buffer.ToString();

            var keyByte = Encoding.UTF8.GetBytes(SECRET_KEY);
            var messageBytes = Encoding.UTF8.GetBytes(data);
            var result = "";
            using (var hmacsha256 = new HMACSHA256(keyByte))
            {
                var hashmessage = hmacsha256.ComputeHash(messageBytes);
                result = ByteArrayToString(hashmessage);
            }
            var bytes = Encoding.UTF8.GetBytes(result);
            var hash = Convert.ToBase64String(bytes);
            return hash;
        }
        public static string ByteArrayToString(byte[] ba)
        {
            var hex = new StringBuilder(ba.Length * 2);
            foreach (var b in ba)
                hex.AppendFormat("{0:x2}", b);

            return hex.ToString();
        }

        public async Task<UpdatedDetailsResponse> GetPaymentDetailsAsync(GetPaymentDetailsDTO model)
        {
            var result = await GetPaymentDetails(model);
            var res = await _paymentRepository.GetPaymentDetailsAsync(result);
            return res;
        }

        public async Task<PaymentDetailResponseDTO> GetPaymentDetails(GetPaymentDetailsDTO model)
        {
            var merchantID = _configuration["Payments:MerchantID"];
            var secureHashKey = _configuration["Payments:SecureHashKey"];
            var paymentDetailAPIURL = _configuration["Payments:PaymentDetailAPIURL"];
            var lang = "";
            if (model.LanguageId == 1)
            {
                lang = "en";
            }
            else
            {
                lang = "ar";
            }

            StringBuilder buffer = new StringBuilder(secureHashKey + "" + model.Action + "" + merchantID + "" + model.OrderNumber);

            var hashkey = GetStringHash(secureHashKey, buffer);

            PaymentDetailDTO paymentDetailsDTO = new PaymentDetailDTO();
            paymentDetailsDTO.MerchantID = merchantID;
            paymentDetailsDTO.Action = model.Action;
            paymentDetailsDTO.Lang = lang;
            paymentDetailsDTO.OrderNumber = model.OrderNumber;
            paymentDetailsDTO.SecureHashKey = hashkey;

            var client = new RestClient(paymentDetailAPIURL);
            client.Timeout = -1;
            var request = new RestRequest(Method.POST);
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", "{\r\n    \"merchantID\" : \"" + merchantID + "\",\r\n    \"Action\" : \"" + model.Action + "\",\r\n    \"lang\" : \"" + lang + "\",\r\n    \"orderNumber\" : \"" + model.OrderNumber + "\",\r\n    \"secureHash\" : \"" + hashkey + "\"\r\n}\r\n", ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);

            var resp = response.Content.ToString();
            var result = JsonConvert.DeserializeObject<PaymentDetailResponse>(resp);

            PaymentDetailResponseDTO paymentDetailResponse = new PaymentDetailResponseDTO();
            paymentDetailResponse.LanguageId = model.LanguageId;
            paymentDetailResponse.OrderNumber = model.OrderNumber;
            paymentDetailResponse.Services = JsonConvert.SerializeObject(result.Services);
            paymentDetailResponse.StatusMessage = result.StatusMessage;
            paymentDetailResponse.Status = result.Status;
            paymentDetailResponse.EDirhamFees = result.EDirhamFees;
            paymentDetailResponse.URN = result.URN;
            paymentDetailResponse.TransactionAmount = result.TransactionAmount;
            paymentDetailResponse.PaymentMethodType = result.PaymentMethodType;
            paymentDetailResponse.Success = result.Success;
            paymentDetailResponse.ErrorID = result.ErrorID;
            paymentDetailResponse.LanguageId = result.LanguageId;
            paymentDetailResponse.CreatorId = model.CreatorId;
            paymentDetailResponse.CreatorName = model.CreatorName;

            return paymentDetailResponse;
        }

        public async Task<IEnumerable<UserPaymentList>> UserPaymentListAsync(UserPaymentListDTO model)
        {
            return await _paymentRepository.UserPaymentListAsync(model);
        }
    }
}
