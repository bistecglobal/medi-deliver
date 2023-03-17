using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class UpdateMedicalCenter
    {
        private readonly ILogger _logger;
        private readonly IRepository<MedicalCenter> repository;

        public UpdateMedicalCenter(ILoggerFactory loggerFactory, IRepository<MedicalCenter> repository)
        {
            _logger = loggerFactory.CreateLogger<UpdateMedicalCenter>();
            this.repository = repository;
        }

        [Function("UpdateMedicalCenter")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "put", Route = "MedicalCenter/{id}")] HttpRequestData req, string id)
        {

            var MedicalCenterToUpdate = await repository.GetAsync(id);
            var mc = await System.Text.Json.JsonSerializer.DeserializeAsync<MedicalCenter>(req.Body);
            MedicalCenterToUpdate.M_Name = mc.M_Name;
            MedicalCenterToUpdate.M_Location = mc.M_Location;

            await repository.UpdateAsync(MedicalCenterToUpdate);

            _logger.LogInformation("C# HTTP trigger function processed a request.");
            var response = req.CreateResponse(HttpStatusCode.OK);
            response.WriteString("Welcome to Azure Functions!");
            await response.WriteAsJsonAsync(MedicalCenterToUpdate);

            return response;
        }
    }
}
