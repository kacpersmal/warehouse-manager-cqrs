using FluentValidation;

namespace Modules.Identity.Application.Features.Hello;

public sealed class HelloValidator : AbstractValidator<HelloQuery>
{
    public HelloValidator()
    {
        RuleFor(x => x.Name)
            .MaximumLength(100)
            .When(x => x.Name is not null)
            .WithMessage("Name must not exceed 100 characters.");
    }
}
