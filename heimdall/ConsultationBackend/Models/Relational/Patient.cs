namespace ConsultationBackend.Models.Relational;

public class Patient
{
    public int PatId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
}