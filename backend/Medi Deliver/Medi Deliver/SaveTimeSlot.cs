using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class SaveTimeSlot
    {
        private readonly ILogger _logger;
        private readonly IRepository<TimeSlot> repository;

        public SaveTimeSlot(ILoggerFactory loggerFactory,IRepository<TimeSlot>repository)
        {
            _logger = loggerFactory.CreateLogger<SaveTimeSlot>();
            this.repository = repository;
        }

        [Function("SaveTimeSlot")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var timeslot = await System.Text.Json.JsonSerializer.DeserializeAsync<TimeSlot>(req.Body);

            var response = req.CreateResponse(HttpStatusCode.OK);
            var created = await repository.CreateAsync(new TimeSlot { Title = timeslot.Title, Selection = timeslot.Selection, Time = timeslot.Time });
            await response.WriteAsJsonAsync(created);
            return response;
        }
    }
}
