using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class SaveDoctor
    {
        private readonly ILogger _logger;
        private readonly IRepository<Doctor> repository;

        public SaveDoctor(ILoggerFactory loggerFactory, IRepository<Doctor> repository)
        {
            _logger = loggerFactory.CreateLogger<SaveDoctor>();
            this.repository = repository;
        }

        [Function("SaveDoctor")]
        public async Task< HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var doctor = await System.Text.Json.JsonSerializer.DeserializeAsync<Doctor>(req.Body);

            var response = req.CreateResponse(HttpStatusCode.OK);

            var created = await repository.CreateAsync(doctor);
            await response.WriteAsJsonAsync(created);

            return response;
        }
    }
}
