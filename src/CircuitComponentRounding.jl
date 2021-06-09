module CircuitComponentRounding

using NumericIO: formatted
import Base: round, print

export E3, E6, E12, E24, E48, E96, E192

abstract type AbstractPrefNumbSys end

include("ESeries.jl")
include("Utilities.jl")

end
