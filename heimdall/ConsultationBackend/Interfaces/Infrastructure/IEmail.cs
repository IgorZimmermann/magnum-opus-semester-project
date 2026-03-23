using ConsultationBackend.Dtos;

namespace ConsultationBackend.Interfaces.Infrastructure;

public interface IEmail
{
    Task<bool> SendEmailAsync(EmailGenerateRequest emailGeneraterequest);
}