using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using static Medi_Deliver.Order;

namespace Medi_Deliver
{
    public class UpdateOrder
    {
        private readonly ILogger _logger;
        private readonly IRepository<Order> repository;
       

        public UpdateOrder(ILoggerFactory loggerFactory,IRepository<Order> repository)
        {
            _logger = loggerFactory.CreateLogger<UpdateOrder>();
            this.repository = repository;
        }
      

        [Function("UpdateOrder")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "put", Route = "Order/{id}")] HttpRequestData req, string id)
        {


            var OrderToUpdate = await repository.GetAsync (id);
            var mc = await System.Text.Json.JsonSerializer.DeserializeAsync<Order>(req.Body);
            //OrderToUpdate.MedicineCost = mc.MedicineCost;
            OrderToUpdate.Date = mc.Date;

            OrderToUpdate.Status = mc.Status;
            await repository.UpdateAsync (OrderToUpdate);
           

            _logger.LogInformation("C# HTTP trigger function processed a request.");
           
            var response = req.CreateResponse(HttpStatusCode.OK);
         
            await  response.WriteAsJsonAsync(OrderToUpdate);

            return response;
        }
    }
}
