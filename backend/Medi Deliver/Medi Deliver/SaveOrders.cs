using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace Medi_Deliver
{
    public class SaveOrders
    {
        private readonly ILogger _logger;
        private readonly IRepository<Order> repository;

        public SaveOrders(ILoggerFactory loggerFactory,IRepository<Order> repository)
        {
            _logger = loggerFactory.CreateLogger<SaveOrders>();
            this.repository = repository;
        }

        [Function("SaveOrders")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var order = await System.Text.Json.JsonSerializer.DeserializeAsync<Order>(req.Body);

           

            //var created = await repository.CreateAsync(new Order {  Id = order.Id, Date = order.Date, Time = order.Time ,Address=order.Address, Prescription =order.Prescription, Status=order.Status});
            var created = await repository.CreateAsync(order);
            var response = req.CreateResponse(HttpStatusCode.OK);
            await response.WriteAsJsonAsync(created);
            
            response.WriteString("Welcome to Azure Functions!");

            return response;
        }
    }
}
