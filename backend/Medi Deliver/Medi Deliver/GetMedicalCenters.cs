using System.Net;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.CosmosRepository.Paging;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class GetMedicalCenters
    {
        private readonly ILogger _logger;
        private readonly IRepository<MedicalCenter> repository;

        public GetMedicalCenters(ILoggerFactory loggerFactory,IRepository<MedicalCenter> repository)
        {
            _logger = loggerFactory.CreateLogger<GetMedicalCenters>();
            this.repository = repository;
        }

        [Function("GetMedicalCenters")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get")] HttpRequestData req)
        {


            var queryDictionary = QueryHelpers.ParseQuery(req.Url.Query);

            var pageNumber = queryDictionary["pageNumber"];
            var pageSize = queryDictionary["pageSize"];
            var response = req.CreateResponse(HttpStatusCode.OK);

            if (string.IsNullOrWhiteSpace(pageNumber) || !int.TryParse(pageNumber, out var page) || page <= 0)
            {
                _logger.LogWarning("No pageNumber provided.");
                response = req.CreateResponse(HttpStatusCode.BadRequest);
                return response; ;
            }

            if (string.IsNullOrWhiteSpace(pageSize) || !int.TryParse(pageSize, out var size) || size <= 0)
            {
                _logger.LogWarning("No pageSize provided.");
                response = req.CreateResponse(HttpStatusCode.BadRequest);
                return response;
            }

            IPage<MedicalCenter> medicalCenter =
                await repository.PageAsync(pageNumber: page, pageSize: size);
            await response.WriteAsJsonAsync(medicalCenter.Items);

            return response;
        }
    }
}
