using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class UpdtaeTimeSlot
    {
        private readonly ILogger _logger;
        private readonly IRepository<TimeSlot> repository;

        public UpdtaeTimeSlot(ILoggerFactory loggerFactory,IRepository<TimeSlot> repository)
        {
            _logger = loggerFactory.CreateLogger<UpdtaeTimeSlot>();
            this.repository = repository;
        }

        [Function("UpdtaeTimeSlot")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "put", Route = "TimeSlot/{id}")] HttpRequestData req,string id)
        {
            var timeslot = await repository.GetAsync(id);
            var ts = await System.Text.Json.JsonSerializer.DeserializeAsync<TimeSlot>(req.Body);
            timeslot.Title = ts.Title;
            timeslot.Time = ts.Time;
            timeslot.Selection=ts.Selection;

            await repository.UpdateAsync(timeslot);

            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var response = req.CreateResponse(HttpStatusCode.OK);


            await response.WriteAsJsonAsync(timeslot);

            return response;
        }
    }
}
