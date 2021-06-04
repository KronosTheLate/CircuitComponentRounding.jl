```@meta
CurrentModule = CircuitComponentRounding
```

# CircuitComponentRounding

Documentation for [CircuitComponentRounding](https://github.com/KronosTheLate/CircuitComponentRounding.jl).

Due to the simplicity of this package, all the required documentation is found by checking the docstrings of the two exported functions:
```@repl
using CircuitComponentRounding
?series_values

?roundE
```

In case the code above fails, here is the output at the time of writing:
```julia
help?> roundE
search: roundE RoundNearest RoundNearestTiesUp RoundNearestTiesAway RoundToZero RoundFromZero RoundingMode round rounding RoundUp RoundDown
  roundE(values_to_be_rounded, series)
  roundE(values_to_be_rounded, series, format)

  Round the values_to_be_rounded to the given E series number series. Possible series are 3, 6, 12, 24, 48, 96, 192.

  The values come out as plain numbers, for easy use in further calculations. For prettier printing, an optional third argument formats    
  the output by passing it to the function formatted from the package NumericIO. Possible formats include :SI and :ENG.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> vals = [3, 7e-7, 14e-2]
  3-element Vector{Float64}:
   3.0
   7.0e-7
   0.14
  
  julia> roundE(vals, 24)
  3-element Vector{Float64}:
   3.0
   6.8e-7
   0.15
  
  julia> roundE(vals, 24, :ENG)
  3-element Vector{String}:
   "3.0×10⁰"
   "680×10⁻⁹"
   "150×10⁻³"
  
  julia> roundE(vals, 24, :SI)
  3-element Vector{String}:
   "3.0"
   "680n"
   "150m"

help?> series_values
search: series_values

  series_values(ser)

  Returns the values in the E-series ser.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> series_values(3)
  3-element Vector{Float64}:
   1.0
   2.2
   4.7
```

Test

```@index
```

```@autodocs
Modules = [CircuitComponentRounding]
```
