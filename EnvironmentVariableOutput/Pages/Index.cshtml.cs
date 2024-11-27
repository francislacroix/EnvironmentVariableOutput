using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.IO;

namespace EnvironmentVariableOutput.Pages;

public class IndexModel : PageModel
{
    public string? EnvironmentVariables { get; set; }
    private readonly ILogger<IndexModel> _logger;

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        StringBuilder stringBuilder = new StringBuilder();

        foreach (string key in Environment.GetEnvironmentVariables().Keys)
        {
            stringBuilder.AppendLine($"{key} = {Environment.GetEnvironmentVariable(key)}; ");
        }

        EnvironmentVariables = stringBuilder.ToString();

        System.IO.File.WriteAllText("/var/www/html/env.txt", EnvironmentVariables);
    }
}
