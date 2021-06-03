using CircuitComponentRounding
using Documenter

DocMeta.setdocmeta!(CircuitComponentRounding, :DocTestSetup, :(using CircuitComponentRounding); recursive=true)

makedocs(;
    modules=[CircuitComponentRounding],
    authors="KronosTheLate",
    repo="https://github.com/KronosTheLate/CircuitComponentRounding.jl/blob/{commit}{path}#{line}",
    sitename="CircuitComponentRounding.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://KronosTheLate.github.io/CircuitComponentRounding.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/KronosTheLate/CircuitComponentRounding.jl",
)
