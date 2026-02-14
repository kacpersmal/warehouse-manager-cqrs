using MediatR;

namespace Modules.Identity.Application.Features.Hello;

public sealed record HelloQuery(string? Name) : IRequest<HelloResponse>;

public sealed record HelloResponse(string Message, HelloCognitoSettings CognitoSettings);

public sealed record HelloCognitoSettings(
    string UserPoolId,
    string AppClientId,
    string Region,
    string Authority,
    string Domain);
