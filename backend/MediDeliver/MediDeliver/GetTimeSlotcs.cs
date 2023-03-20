using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.CosmosRepository.Paging;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.WebUtilities;
namespace Medi_Deliver
{
    public class GetTimeSlotcs
    {
        private readonly ILogger _logger;
        private readonly IRepository<TimeSlot> repository;
        

        public GetTimeSlotcs(ILoggerFactory loggerFactory, IRepository<TimeSlot>repository)
        {
            _logger = loggerFactory.CreateLogger<GetTimeSlotcs>();
            this.repository = repository;
        }

        [Function("GetTimeSlotcs")]
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

            IPage<TimeSlot> timeslot =
                await repository.PageAsync(pageNumber: page, pageSize: size);
            await response.WriteAsJsonAsync(timeslot.Items);
            return response;
        }
    }
}
