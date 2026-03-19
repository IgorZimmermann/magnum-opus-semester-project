using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Services;
using ConsultationBackend.Infrastructure;
using ConsultationBackend.Interfaces.Infrastructure;


var builder = WebApplication.CreateBuilder(args);

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

builder.Services.AddHttpClient<IspeechToText, SpeechToText>((sp, client) =>
{
    // this fetches the url from appsetting.json
    var config = sp.GetRequiredService<IConfiguration>();
    var baseUrl = config["Services:SpeechToText:BaseUrl"];

    client.BaseAddress = new Uri(baseUrl!);
});


// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
