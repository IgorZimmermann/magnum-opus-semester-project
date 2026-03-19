namespace ConsultationBackend.Models.Relational;

public class Patient
{
    public Guid PatId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;

    public ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();
}
