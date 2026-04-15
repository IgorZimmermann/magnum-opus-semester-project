using BookingBackend.Data;
using BookingBackend.Services;
using BookingBackend.Interfaces;
using BookingBackend.Services.Implementations;
using Auth0.AspNetCore.Authentication.Api;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

// Database
builder.Services.AddDbContext<BookingDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped<IRelationalDb>(provider => 
    provider.GetRequiredService<BookingDbContext>());

builder.Services.AddScoped<IEmail, Email>();
builder.Services.AddScoped<IAvailability, AvailabilityService>();
builder.Services.AddScoped<IAppointment, AppointmentService>();
builder.Services.AddAuth0ApiAuthentication(options =>
{
    options.Domain = builder.Configuration["Auth0:Domain"];
    options.JwtBearerOptions = new JwtBearerOptions
    {
        Audience = builder.Configuration["Auth0:Audience"]
    };
});

builder.Services.AddAuthorization();
builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();
builder.Services.AddSwaggerGen();

builder.Services.AddHttpClient<IEmail, Email>((sp, client) =>
{
    // this fetches the url from appsetting.json
    var config = sp.GetRequiredService<IConfiguration>();
    var baseUrl = config["Services:Email:BaseUrl"];

    client.BaseAddress = new Uri(baseUrl!);
});

builder.Services.AddSwaggerGen();

var app = builder.Build();
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<BookingDbContext>();
    db.Database.Migrate();
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthentication();
app.UseAuthorization();

// Public endpoint - no authentication required
app.MapGet("/api/public", () =>
    Results.Ok(new { Message = "This endpoint is public" }))
    .WithName("GetPublic");

// Protected endpoint - requires authentication
app.MapGet("/api/private", () =>
    Results.Ok(new { Message = "This endpoint requires authentication" }))
    .RequireAuthorization()
    .WithName("GetPrivate");

app.MapControllers();

app.Run();