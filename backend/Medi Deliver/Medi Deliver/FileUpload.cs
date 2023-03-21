using System.Net;
using System.IO;
using System.Threading;
using Microsoft.Azure.CosmosRepository;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using HttpMultipartParser;
using Azure.Storage.Blobs;
using Microsoft.Extensions.Configuration;
using Azure.Storage.Blobs.Models;

namespace Medi_Deliver
{
    public class FileUpload
    {
        private readonly ILogger _logger;
        private readonly IConfiguration configuration;
        private readonly IRepository<Order> repository;

        public FileUpload(ILoggerFactory loggerFactory,IConfiguration configuration, IRepository<Order> repository)
        {
            _logger = loggerFactory.CreateLogger<FileUpload>();
            this.configuration = configuration;
            this.repository = repository;
        }


        [Function("FileUpload")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "post", "get", Route = null)] HttpRequestData req)
        {




           

            _logger.LogInformation("C# HTTP trigger function processed a request.");
            var response = req.CreateResponse(HttpStatusCode.OK);
          

            var parser = await MultipartFormDataParser.ParseAsync(req.Body).ConfigureAwait(false);

            var file = parser.Files.First();
            string filename = file.FileName.ToLower();
            Stream content = file.Data;

            var parmacyName = parser.GetParameterValue("ParmacyName");
            var imagePath = $"{parmacyName}{filename}";

            try
            {
                BlobContainerClient blobContainerClient = new BlobContainerClient(
                    configuration.GetValue<string>("storage:conn"),
                    configuration.GetValue<string>("storage:container"));

                blobContainerClient.CreateIfNotExists(Azure.Storage.Blobs.Models.PublicAccessType.Blob);

                await blobContainerClient.GetBlobClient(imagePath).DeleteIfExistsAsync();

                var info = await blobContainerClient.UploadBlobAsync(imagePath, content);

                //var order = await System.Text.Json.JsonSerializer.DeserializeAsync<Order>(req.Body);
                //var created = await repository.CreateAsync(order);


                var url = $"{blobContainerClient.Uri.AbsoluteUri}/{imagePath}";
                
                var responseObject = new { fileUrl = url };
                await response.WriteAsJsonAsync(responseObject);
            }
            catch (System.Exception ex)
            {
                _logger.LogError(ex, ex.Message);
                throw;
            }

            return response;


        
        }
    }
}
