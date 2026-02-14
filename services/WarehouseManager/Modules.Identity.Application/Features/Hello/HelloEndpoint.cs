using MediatR;

namespace Modules.Identity.Application.Features.Hello;

internal static class HelloEndpoint
{
    internal static void Map(RouteGroupBuilder group)
    {
        group.MapGet("/hello", async (string? name, ISender sender) =>
            {
                var response = await sender.Send(new HelloQuery(name));
                return Results.Ok(response);
            })
            .WithName("Hello")
            .Produces<HelloResponse>();
    }
}
