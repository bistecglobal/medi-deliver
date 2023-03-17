using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Medi_Deliver;

var host = new HostBuilder()
   .ConfigureFunctionsWorkerDefaults(
  )
    .ConfigureServices(services =>
    {
       
        services.AddCosmosRepository(builder => builder.ContainerBuilder
            .Configure<Login>(opt => opt.WithServerlessThroughput())
            .Configure<Doctor>(opt => opt.WithServerlessThroughput())
            .Configure<MedicalCenter>(opt => opt.WithServerlessThroughput())
            .Configure<Order>(opt => opt.WithServerlessThroughput())
            .Configure<TimeSlot>(opt => opt.WithServerlessThroughput())
            );

    })
    .Build();

host.Run();

