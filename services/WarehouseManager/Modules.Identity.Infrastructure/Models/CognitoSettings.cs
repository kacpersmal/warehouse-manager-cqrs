namespace Modules.Identity.Infrastructure.Models;

public sealed class CognitoSettings
{
    public const string SectionName = "Cognito";

    public required string UserPoolId { get; init; }
    public required string AppClientId { get; init; }
    public required string Region { get; init; }
    public required string Authority { get; init; }
    public required string Domain { get; init; }
}
