using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class DeleteMedicalCenter
    {
        private readonly ILogger _logger;
        private readonly IRepository<MedicalCenter> repository;

        public DeleteMedicalCenter(ILoggerFactory loggerFactory, IRepository<MedicalCenter> repository)
        {
            _logger = loggerFactory.CreateLogger<DeleteMedicalCenter>();
            this.repository = repository;
        }

        [Function("DeleteMedicalCenter")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous,"delete", Route = "MedicalCenter/{id}")] HttpRequestData req,string id)
        {

            await repository.DeleteAsync(id);

            _logger.LogInformation("C# HTTP trigger function processed a request.");
            var response = req.CreateResponse(HttpStatusCode.NoContent);
            response.WriteString("Welcome to Azure Functions!");

            return response;
        }
    }
}
