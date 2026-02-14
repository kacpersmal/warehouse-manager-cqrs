using MediatR;
using Microsoft.Extensions.Options;
using Modules.Identity.Infrastructure.Models;

namespace Modules.Identity.Application.Features.Hello;

internal sealed class HelloHandler(IOptions<CognitoSettings> cognitoSettings)
    : IRequestHandler<HelloQuery, HelloResponse>
{
    public Task<HelloResponse> Handle(HelloQuery request, CancellationToken cancellationToken)
    {
        var name = string.IsNullOrWhiteSpace(request.Name) ? "World" : request.Name;
        var settings = cognitoSettings.Value;

        var response = new HelloResponse(
            $"Hello {name}!",
            new HelloCognitoSettings(
                settings.UserPoolId,
                settings.AppClientId,
                settings.Region,
                settings.Authority,
                settings.Domain));

        return Task.FromResult(response);
    }
}
