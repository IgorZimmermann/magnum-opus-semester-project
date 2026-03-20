# Janus - Booking Backend

.NET Core 10 backend for Booking. It manages doctor availability, appointments and mail sending to patients.



## Quick Start
- During development I ran the needed components from the terminal, not from the compose file

### 1. Start services

```bash
docker compose up -d
```


### 2. Configure environment

Copy `.env.example` to `.env` and make sure db configuration matches

I used the configurations found in mneme/README.md

### 3. Run the backend

Run the command in the project folder (janus/BookingBackend)

```bash
dotnet run
```

## Project Structure

```
BookingBackend/
├── Controllers/                    # HTTP endpoints / routes
│   ├── AppointmentController.cs    
│   ├── AvailabilityController.cs   
│   └── EmailController.cs          
├── Data/
│   ├── BookingDbContext.cs         # EF Core context (PostgreSQL)
│   └── Migrations/                 # EF Core migrations
│       ├── 20260320140630_InitialCreate.cs
│       ├── 20260320140630_InitialCreate.Designer.cs
│       └── BookingDbContextModelSnapshot.cs
├── DTO/                            # Data Transfer Objects
│   ├── AppointmentDTO.cs           
│   └── AvailabilityDTO.cs          
├── Interfaces/                     # Service contracts
│   ├── IAppointment.cs             
│   ├── IAvailability.cs            
│   ├── IEmailService.cs            
│   └── IRelationalDb.cs            
├── Models/                         # EF Core entities
│   ├── Appointment.cs              
│   ├── AppointmentStatus.cs        
│   ├── Doctor.cs                   
│   ├── Patient.cs                  
│   └── WorksOn.cs                  
├── Services/                       
│   ├─── AppointmentService.cs    
│   ├── AvailabilityService.cs  
│   └── EmailService.cs         
├── Properties/
│   └── launchSettings.json         
├── appsettings.Development.json    
├── appsettings.json                # Base configuration
├── BookingBackend.csproj           # Project file / dependencies
├── Program.cs                      # Application entry point & DI setup
├── BookingBackend.http             
└── bin/                            
    └── Debug/
        └── net10.0/                
```
## Endpoints

### Availability
---
**GET /api/availability/doctors** 
- Returns all doctors with their weekly availability slots

### Appointment
---
**GET /api/appointment** 
- Returns all appointments in the system

**POST /api/appointment** 
- Creates a new appointment (with docId, patId, date, time)
### Mail
---
**POST /api/email/send** 
- Sends emails (requires SMTP config)

