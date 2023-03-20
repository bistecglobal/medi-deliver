using System.Net;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using NuGet.Protocol.Core.Types;

namespace Medi_Deliver
{
    public class SaveLogin
    {
        private readonly ILogger _logger;
        private readonly IRepository<Login> repository;

        public SaveLogin(ILoggerFactory loggerFactory,IRepository<Login> repository)
        {
            _logger = loggerFactory.CreateLogger<SaveLogin>();
            this.repository = repository;
        }

        [Function("SaveLogin")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var login = await System.Text.Json.JsonSerializer.DeserializeAsync<Login>(req.Body);

            var response = req.CreateResponse(HttpStatusCode.OK);

            var created = await repository.CreateAsync(login);
            await response.WriteAsJsonAsync(created);

            return response;
        }
    }
}
