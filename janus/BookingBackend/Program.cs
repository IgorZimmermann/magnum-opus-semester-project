using BookingBackend.Data;
using BookingBackend.Services;
using BookingBackend.Interfaces;
using BookingBackend.Services.Implementations;
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
builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
