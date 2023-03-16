using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class DeleteOrders
    {
        private readonly ILogger _logger;
        private readonly IRepository<Order> repository;

        public DeleteOrders(ILoggerFactory loggerFactory,IRepository<Order> repository)
        {
            _logger = loggerFactory.CreateLogger<DeleteOrders>();
            this.repository = repository;
        }

        [Function("DeleteOrders")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous,"delete",Route ="Order/{id}")] HttpRequestData req, string id)
        {
            await repository.DeleteAsync(id);

            var response = req.CreateResponse(HttpStatusCode.NoContent);
            response.Headers.Add("Content-Type", "text/plain; charset=utf-8");

            
            response.WriteString("Welcome to Azure Functions!");

            return response;
        }
    }
}
