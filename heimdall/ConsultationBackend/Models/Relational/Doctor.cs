namespace ConsultationBackend.Models.Relational;

public class Doctor
{
    public int DocId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
}