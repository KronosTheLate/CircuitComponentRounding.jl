using CircuitComponentRounding
using Test

println("Running tests:")

@testset "CircuitComponentRounding.jl" begin
    vals1 = [3, 7e-7, 14e-2, 17e7]
    for i in eachindex(vals1)
        @test round(E12, vals1)[i] == [3.3, 8.2e-7, 0.15, 1.8e8][i]
    end

    vals2 = collect(100:10:1_000)

    for series in [E3, E6, E12, E24, E48, E96, E192]
        for i in eachindex(vals2)
            @test round(series, vals2)[i] ∈ [series.vals..., 1000]
        end
    end

    for series in [E3, E6, E12, E24, E48, E96, E192]
        for i in eachindex(vals2)
            @test round(series, vals2)[i]+0.001 ∉ [series.vals..., 1000]
        end
    end
end
