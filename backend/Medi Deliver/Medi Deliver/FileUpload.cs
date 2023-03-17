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

        public FileUpload(ILoggerFactory loggerFactory,IConfiguration configuration)
        {
            _logger = loggerFactory.CreateLogger<FileUpload>();
            this.configuration = configuration;
            
            

        }


        [Function("FileUpload")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "post", "get", Route = null)] HttpRequestData req)
        {




            ////// get query params
            ////var testvalue = executionContext.BindingContext.BindingData["testparams"];
            //// get form-body        
            //var parsedFormBody =  await MultipartFormDataParser.ParseAsync(req.Body);
            //var file = parsedFormBody.Files[0];

            //var fileName = file.FileName;
            //var fileContent = file.Data;

            //// create blob client and container
            //var blobContainerClient = new BlobContainerClient(_connectionString, _blobContainer);
            //await blobContainerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);

            //// upload file to container
            //var blobClient = blobContainerClient.GetBlobClient(fileName);
            //await blobClient.UploadAsync(fileContent, true);

            //// create response
            ////var response = req.CreateResponse(HttpStatusCode.OK);
            ////response.Headers.Add("Content-Type", "text/plain; charset=utf-8");
            //var response = req.CreateResponse(HttpStatusCode.OK);

            //// return file URL
            //var fileUrl = $"{blobContainerClient.Uri.AbsoluteUri}/{fileName}";
            //await response.WriteAsJsonAsync(new { fileUrl });
            //response.WriteString("Welcome to Issue Certification Application!");


            //return response;

            _logger.LogInformation("C# HTTP trigger function processed a request.");
            var response = req.CreateResponse(HttpStatusCode.OK);
            response.Headers.Add("Content-Type", "text/plain; charset=utf-8");

            var parser = await MultipartFormDataParser.ParseAsync(req.Body).ConfigureAwait(false);

            var file = parser.Files.First();
            string filename = file.FileName;
            Stream content = file.Data;

            var parmacyName = parser.GetParameterValue("ParmacyName");
            var imagePath = $"{parmacyName}/{filename}";

            try
            {
                BlobContainerClient blobContainerClient = new BlobContainerClient(
                    configuration.GetValue<string>("storage:conn"),
                    configuration.GetValue<string>("storage:container"));

                blobContainerClient.CreateIfNotExists(Azure.Storage.Blobs.Models.PublicAccessType.Blob);

                await blobContainerClient.GetBlobClient(imagePath).DeleteIfExistsAsync();

                var info = await blobContainerClient.UploadBlobAsync(imagePath, content);

                var url = $"{blobContainerClient.Uri.AbsoluteUri}/{imagePath}";
                response.WriteString(url);
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
