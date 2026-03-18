// Controllers/TestController.cs

using Microsoft.AspNetCore.Mvc;

namespace ConsultationBackend.Controllers;

/* quick controller syntax cheat sheet

[ApiController]
[Route("api/[controller]")]
public class ExampleController : ControllerBase
{
    [HttpGet]
    public IActionResult GetAll() => Ok();

    [HttpGet("{id}")]
    public IActionResult GetById(int id) => Ok(id);

    [HttpGet("search")]
    public IActionResult Search([FromQuery] string term) => Ok(term);

    [HttpPost]
    public IActionResult Create([FromBody] ExampleRequest request) => Ok(request);

    [HttpPut("{id}")]
    public IActionResult Update(int id, [FromBody] ExampleRequest request) => Ok();

    [HttpDelete("{id}")]
    public IActionResult Delete(int id) => Ok();
}

public class ExampleRequest
{
    public string Name { get; set; } = string.Empty;
}

*/


[ApiController]
[Route("api/[controller]")]
public class TestController : ControllerBase
{
    // GET api/test/ping
    [HttpGet("ping")]
    public IActionResult Ping()
    {
        return Ok("pong");
    }

    // GET api/test/hello
    [HttpGet("hello")]
    public IActionResult Hello()
    {
        return Ok(new
        {
            Message = "Hello from TestController"
        });
    }

    // GET api/test/echo/5
    [HttpGet("echo/{id}")]
    public IActionResult EchoRouteParam(int id)
    {
        return Ok(new
        {
            ReceivedId = id
        });
    }

    // GET api/test/query?name=Sean&age=22
    [HttpGet("query")]
    public IActionResult QueryExample([FromQuery] string name, [FromQuery] int age)
    {
        return Ok(new
        {
            Name = name,
            Age = age
        });
    }

    // POST api/test/body
    [HttpPost("body")]
    public IActionResult BodyExample([FromBody] TestRequest request)
    {
        return Ok(new
        {
            Message = $"Received {request.Name}",
            request.Value
        });
    }

    // PUT api/test/update/3
    [HttpPut("update/{id}")]
    public IActionResult PutExample(int id, [FromBody] TestRequest request)
    {
        return Ok(new
        {
            UpdatedId = id,
            request.Name,
            request.Value
        });
    }

    // DELETE api/test/delete/3
    [HttpDelete("delete/{id}")]
    public IActionResult DeleteExample(int id)
    {
        return Ok(new
        {
            DeletedId = id
        });
    }

    // GET api/test/status
    [HttpGet("status")]
    public IActionResult StatusExample()
    {
        return StatusCode(200, new
        {
            Status = "Controller works"
        });
    }

    private readonly IConfiguration _configuration;

    public TestController(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    // GET api/test/services
    [HttpGet("services")]
    public IActionResult GetServiceUrls()
    {
        var speechToTextUrl = _configuration["SPEECH_TO_TEXT_URL"];
        var llmUrl = _configuration["LLM_URL"];
        var pdfUrl = _configuration["PDF_URL"];
        var emailUrl = _configuration["EMAIL_URL"];

        return Ok(new
        {
            SpeechToText = speechToTextUrl,
            Llm = llmUrl,
            Pdf = pdfUrl,
            Email = emailUrl
        });
    }
}

public class TestRequest
{
    public string Name { get; set; } = string.Empty;
    public int Value { get; set; }
}