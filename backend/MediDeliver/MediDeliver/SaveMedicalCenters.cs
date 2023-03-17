using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;



namespace Medi_Deliver
{
    public class SaveMedicalCenters

    {
        private readonly ILogger _logger;
        private readonly IRepository<MedicalCenter> repository;

   

        public SaveMedicalCenters(ILoggerFactory loggerFactory, IRepository<MedicalCenter> repository)
        {
            _logger = loggerFactory.CreateLogger<Function1>();
            this.repository = repository;
        }

        [Function("SaveMedicalCenters")]
        public async Task< HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var mc = await System.Text.Json.JsonSerializer.DeserializeAsync<MedicalCenter>(req.Body);

            var response = req.CreateResponse(HttpStatusCode.OK);

            var created = await repository.CreateAsync(mc);
            await response.WriteAsJsonAsync(created);

            return response;
        }
    }
}
