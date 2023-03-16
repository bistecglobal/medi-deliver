using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var host = new HostBuilder()
   .ConfigureFunctionsWorkerDefaults(
  )
    .ConfigureServices(services =>
    {
       
        services.AddCosmosRepository(
   options =>
   {
       options.CosmosConnectionString = "AccountEndpoint=https://localhost:8081/;AccountKey=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
       options.ContainerId = "Patients";
       options.DatabaseId = "Patient";
   });

    })
    .Build();

host.Run();

