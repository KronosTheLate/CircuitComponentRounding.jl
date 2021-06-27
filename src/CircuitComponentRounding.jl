module CircuitComponentRounding

using NumericIO: formatted
import Base: round, print, show

export E3, E6, E12, E24, E48, E96, E192
export determine_E

abstract type AbstractPrefNumbSys end

include("ESeries.jl")
include("Utilities.jl")

end
