# CircuitComponentRounding

<!---[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://KronosTheLate.github.io/CircuitComponentRounding.jl/stable)--->
<!---[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://KronosTheLate.github.io/CircuitComponentRounding.jl/dev)--->
[![Build Status](https://github.com/KronosTheLate/CircuitComponentRounding.jl/workflows/CI/badge.svg)](https://github.com/KronosTheLate/CircuitComponentRounding.jl/actions)
[![Coverage](https://codecov.io/gh/KronosTheLate/CircuitComponentRounding.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/KronosTheLate/CircuitComponentRounding.jl)

From [wikipedia](https://en.wikipedia.org/wiki/E_series_of_preferred_numbers):
The E series is a system of preferred numbers (also called preferred values) derived for use in electronic components. It consists of the E3, E6, E12, E24, E48, E96 and E192 series, where the number after the 'E' designates the quantity of value "steps" in each series. Although it is theoretically possible to produce components of any value, in practice the need for inventory simplification has led the industry to settle on the E series for resistors, capacitors, inductors, and zener diodes. Other types of electrical components are either specified by the Renard series (for example fuses) or are defined in relevant product standards (for example IEC 60228 for wires).

This package exports a function `roundE`, which rounds it's input to the specified E series. The function rounds to the values found in the [wikipedia list](https://en.wikipedia.org/wiki/E_series_of_preferred_numbers#Lists) of E-series values.

# The use case
You use theory and math to calculate a set of components to be used in some circuit, e.g. a control system. But producers only manufacture components at certain values, which are unlikely to match your calculations. This creates two problems:
1) Your calculated components are nowhere to be found in the component-shelf. You then need to figure out what is the best alternative.
2) If you simulate the system with your calculated values, it will use different parameters than your physical system.

To remedy the situation, simply round your calculated values with the `roundE` function. The returned values can be directly plugged into your simulation, and the output can be formatted to match the labels in the component-storage.

## But what series should I round to?
If you are not sure which series is available to you, use the function `series_values(ser)`. This returns all the values in the given series `ser`. Look for a series that matches the values in your component-storage.

## Examples
Checking the values in the E3 series:
```julia-repl
julia> series_values(3)
3-element Vector{Float64}:
 1.0
 2.2
 4.7
```

Basic usage:
```julia-repl
julia> vals = [3, 7e-7, 14e-2]
3-element Vector{Float64}:
 3.0
 7.0e-7
 0.14

# The second argument is the specific E series to round to
julia> roundE(vals, 24)
3-element Vector{Float64}:
 3.0
 6.8e-7
 0.15
 ```

Adding the third positionional argument allows 
control of the output format:
```julia-repl
julia> roundE(vals, 24, :ENG)
3-element Vector{String}:
 "3.0×10⁰"
 "680×10⁻⁹"
 "150×10⁻³"
```

```julia-repl
julia> roundE(vals, 24, :SI)
3-element Vector{String}:
 "3.0"
 "680n"
 "150m"
```

## How the rounding is implemented
The rounding function returns the value with the smallest percentage error in the given E-series.
It does this by finding the [geometric mean](https://en.wikipedia.org/wiki/Geometric_mean) of the 
two numbers in the given E-series ajecent to the given value (one smaller, one larger), and 
returning the E-series value on the same side of the mean value as the input value.

In other words, if the input value is larger than the geometric mean, the returned value was rounded up. 
If the given input is smaller than the geometric mean, the output was rounded down. Rounding in this case 
means taking the closes value in the E-series.
  
  
## Feedback
As this is the first package of a relativly novice programmer, feedback and input on ways the package could be better are very welcome!
