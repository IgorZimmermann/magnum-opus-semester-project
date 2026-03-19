using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Dtos;
using System.Threading.Tasks;

namespace ConsultationBackend.Infrastructure;

public class Email : IEmail
{
    private readonly HttpClient _httpClient;

    public Email(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }


    public async Task<bool> SendEmailAsync(EmailGenerateRequest emailGeneraterequest)
    {
        var request = emailGeneraterequest;

        var response = await _httpClient.PostAsJsonAsync("/api/v1/send", request);

        response.EnsureSuccessStatusCode();

        return response.IsSuccessStatusCode;
    }
}   