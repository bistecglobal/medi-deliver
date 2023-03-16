using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class DeleteTimeSlot
    {
        private readonly ILogger _logger;
        private readonly IRepository<TimeSlot> repository;

        public DeleteTimeSlot(ILoggerFactory loggerFactory,IRepository<TimeSlot> repository)
        {
            _logger = loggerFactory.CreateLogger<DeleteTimeSlot>();
            this.repository = repository;
        }

        [Function("DeleteTimeSlot")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous,"delete", Route = "TimeSlot/{id}")] HttpRequestData req,string id)
        {
            await repository.DeleteAsync(id);
            var response = req.CreateResponse(HttpStatusCode.NoContent);
            response.Headers.Add("Content-Type", "text/plain; charset=utf-8");


            return response;
        }
    }
}
