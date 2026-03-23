using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Services;
using ConsultationBackend.Infrastructure;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Data;
using Microsoft.EntityFrameworkCore;
using MongoDB.Driver;


var builder = WebApplication.CreateBuilder(args);
var postgresConnectionString = builder.Configuration.GetConnectionString("Postgres");
builder.Services.AddScoped<IPrescriptionService, PrescriptionService>();
builder.Services.AddScoped<ISummaryService, SummaryService>();
builder.Services.AddScoped<ITranscriptService, TranscriptService>();
builder.Services.AddScoped<IConsultationService, ConsultationService>();

builder.Services.AddHttpClient<ILLM, LLM>((sp, client) =>
{
    // this fetches the url from appsetting.json
    var config = sp.GetRequiredService<IConfiguration>();
    var baseUrl = config["Services:LLM:BaseUrl"];

    client.BaseAddress = new Uri(baseUrl!);
});

builder.Services.AddHttpClient<IPdf, Pdf>((sp, client) =>
{
    // this fetches the url from appsetting.json
    var config = sp.GetRequiredService<IConfiguration>();
    var baseUrl = config["Services:Pdf:BaseUrl"];

    client.BaseAddress = new Uri(baseUrl!);
});

builder.Services.AddHttpClient<ISpeechToText, SpeechToText>((sp, client) =>
{
    // this fetches the url from appsetting.json
    var config = sp.GetRequiredService<IConfiguration>();
    var baseUrl = config["Services:SpeechToText:BaseUrl"];

    client.BaseAddress = new Uri(baseUrl!);
});

builder.Services.AddHttpClient<IEmail, Email>((sp, client) =>
{
    // this fetches the url from appsetting.json
    var config = sp.GetRequiredService<IConfiguration>();
    var baseUrl = config["Services:Email:BaseUrl"];

    client.BaseAddress = new Uri(baseUrl!);
});

// creates postgres context
builder.Services.AddDbContext<AppDbContext>(options => options.UseNpgsql(postgresConnectionString));

// creates mongo db context
builder.Services
    .AddOptions<MongoDbSettings>()
    .Bind(builder.Configuration.GetRequiredSection("MongoDbSettings"))
    .Validate(settings =>
        !string.IsNullOrWhiteSpace(settings.ConnectionString) &&
        !string.IsNullOrWhiteSpace(settings.DatabaseName),
        "MongoDbSettings must include both ConnectionString and DatabaseName")
    .ValidateOnStart();

builder.Services.AddSingleton<IMongoClient>(sp =>
{
    var settings = sp.GetRequiredService<Microsoft.Extensions.Options.IOptions<MongoDbSettings>>().Value;
    return new MongoClient(settings.ConnectionString);
});

builder.Services.AddSingleton<MongoDbContext>();
builder.Services.AddHostedService<ConsultationBackend.Data.Seed.StartupSeeder>();


// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI();

if (app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
}

app.UseAuthorization();

app.MapControllers();

// apply migrations on start up
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.Migrate();
}

app.Run();
