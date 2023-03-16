using System.Net;
using System.Text;
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

        private readonly string _connectionString;
        private readonly string _blobContainer;
        
        private readonly IRepository<File> repository;
        private readonly IConfiguration configuration;

        /// <summary>
        /// Initializes a new instance of the <see cref="AzureStorageService"/> class.
        /// </summary>
        /// <param name="configuration">The configuration.</param>
        /// <param name="logger">The logger.</param>

        public FileUpload(ILoggerFactory loggerFactory,IRepository<File> repository,IConfiguration configuration)
        {
            _logger = loggerFactory.CreateLogger<FileUpload>();
            this.repository = repository;
            this.configuration = configuration;
            _connectionString = configuration.GetValue<string>("APP_STORAGE_CONNECTION");
            _blobContainer = configuration.GetValue<string>("APP_STORAGE_CONTAINER");
           
            

        }
        ///// <summary>
        ///// Upload image to storage.
        ///// </summary>
        ///// <param name="imagePath">The folder path.</param>
        ///// <param name="content">The content.</param>
        ///// <param name="cancellationToken">The cancellation token.</param>
        ///// <returns>The full url.</returns>
        //public async Task<string> UploadImageAsync(string imagePath, Stream content, CancellationToken cancellationToken = default(CancellationToken))
        //{
        //    try
        //    {
        //        BlobContainerClient blobContainerClient = new BlobContainerClient(_connectionString, _blobContainer);
        //        blobContainerClient.CreateIfNotExists(Azure.Storage.Blobs.Models.PublicAccessType.Blob);
        //        await blobContainerClient.GetBlobClient(imagePath).DeleteIfExistsAsync();
        //        var file = await blobContainerClient.UploadBlobAsync(imagePath, content, cancellationToken);

        //        return $"{blobContainerClient.Uri.AbsoluteUri}/{imagePath}";
        //    }
        //    catch (System.Exception ex)
        //    {
        //        _logger.LogError(ex, ex.Message);
        //        throw;
        //    }
        //}

        [Function("FileUpload")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous,"post","get" , Route =null)] HttpRequestData req,
            FunctionContext executionContext)
        {

            


            //// get query params
            //var testvalue = executionContext.BindingContext.BindingData["testparams"];
            // get form-body        
            var parsedFormBody = MultipartFormDataParser.ParseAsync(req.Body);
            var file = parsedFormBody.Result.Files[0];


            var response = req.CreateResponse(HttpStatusCode.OK);
           

            
      


            var fileName = file.FileName;
            var fileContent = file.Data;

            // create blob client and container
            var blobContainerClient = new BlobContainerClient(_connectionString, _blobContainer);
            await blobContainerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);

            // upload file to container
            var blobClient = blobContainerClient.GetBlobClient(fileName);
            await blobClient.UploadAsync(fileContent, true);

            // create response
            //var response = req.CreateResponse(HttpStatusCode.OK);
            //response.Headers.Add("Content-Type", "text/plain; charset=utf-8");

            // return file URL
            var fileUrl = $"{blobContainerClient.Uri.AbsoluteUri}/{fileName}";
            await response.WriteAsJsonAsync(new { fileUrl });
            response.WriteString("Welcome to Issue Certification Application!");
           

            return response;
           


        }
    }
}
