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

builder.Services.AddScoped<IEmailService, EmailService>();
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

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
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
