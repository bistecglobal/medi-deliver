using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class SavePatient
    {
        private readonly ILogger _logger;
        private readonly IRepository<Patient> repository;

        public SavePatient(ILoggerFactory loggerFactory,IRepository<Patient> repository)
        {
            _logger = loggerFactory.CreateLogger<SavePatient>();
            this.repository = repository;
        }

        [Function("SavePatient")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var patient = await System.Text.Json.JsonSerializer.DeserializeAsync<Patient>(req.Body);

            var response = req.CreateResponse(HttpStatusCode.OK);

            var created = await repository.CreateAsync(patient);
            await response.WriteAsJsonAsync(created);

            return response;
        }
    }
}
