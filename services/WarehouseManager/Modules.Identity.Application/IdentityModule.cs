using FluentValidation;
using MediatR;
using Modules.Identity.Application.Features.Hello;
using Modules.Identity.Infrastructure.Models;
using Shared.Application.Behaviors;

namespace Modules.Identity.Application;

public static class IdentityModule
{
    public static IServiceCollection AddIdentityModule(this IServiceCollection services, IConfiguration config)
    {
        services.Configure<CognitoSettings>(config.GetSection(CognitoSettings.SectionName));

        services.AddMediatR(cfg =>
        {
            cfg.RegisterServicesFromAssembly(typeof(IdentityModule).Assembly);
            cfg.AddBehavior(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
        });

        services.AddValidatorsFromAssembly(typeof(IdentityModule).Assembly);

        return services;
    }

    public static WebApplication MapIdentityModule(this WebApplication app)
    {
        var group = app.MapGroup("/api/identity").WithTags("Identity");

        HelloEndpoint.Map(group);

        return app;
    }
}
