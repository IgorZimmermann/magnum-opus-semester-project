using BookingBackend.DTO;

namespace BookingBackend.Interfaces;


public interface IEmail
{
    Task<bool> SendEmailAsync(EmailGenerateRequest emailGeneraterequest);
}