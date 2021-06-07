# CircuitComponentRounding

<!---[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://KronosTheLate.github.io/CircuitComponentRounding.jl/stable)--->
<!---[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://KronosTheLate.github.io/CircuitComponentRounding.jl/dev)--->
[![Build Status](https://github.com/KronosTheLate/CircuitComponentRounding.jl/workflows/CI/badge.svg)](https://github.com/KronosTheLate/CircuitComponentRounding.jl/actions)
[![Coverage](https://codecov.io/gh/KronosTheLate/CircuitComponentRounding.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/KronosTheLate/CircuitComponentRounding.jl)

This package implements functions to round given values, to the nearest standardized value for circuit components. The only set of standardized values currently implemented is the E-series. From [wikipedia](https://en.wikipedia.org/wiki/E_series_of_preferred_numbers):  
    The E series is a system of preferred numbers (also called preferred values) derived for use in electronic components. It consists of the E3, E6, E12, E24, E48, E96 and E192 series, where the number after the 'E' designates the quantity of value "steps" in each series. Although it is theoretically possible to produce components of any value, in practice the need for inventory simplification has led the industry to settle on the E series for resistors, capacitors, inductors, and zener diodes. Other types of electrical components are either specified by the Renard series (for example fuses) or are defined in relevant product standards (for example IEC 60228 for wires).

This package exports a function `roundE`, which rounds it's input to the specified E series. The function rounds to the values found in the [wikipedia list](https://en.wikipedia.org/wiki/E_series_of_preferred_numbers#Lists) of E-series values. While this list ranges from 1 to 10, and those are the values used internally, the printed series values from the `valuesE` function are by default converted to range from 100 to 1000. The reasoning is that integers are faster and easier to read than floating point values.

# The use case
You use theory and math to calculate a set of components to be used in some circuit, e.g. a control system. But producers only manufacture components at certain values, which are unlikely to match your calculations. This creates two problems:
1) Your calculated components are nowhere to be found in the component-shelf. You then need to figure out what is the best alternative.
2) If you simulate the system with your calculated values, it will use different parameters than your physical system.

To remedy the situation, simply round your calculated values with the `roundE` function. The returned values can be directly plugged into your simulation, and the output can be formatted to match the labels in the component-storage.

## But what series should I round to?
If you are not sure which series is available to you, use the function `valuesE(series_number)`. This prints all the values in the given series `series_number` in the Julia REPL. Look for a series that matches the values seen in your component-storage.

## Examples
Lets start with loading the package.
```julia-repl
Julia> using CircuitComponentRounding
```

Use the `valuesE` function to see what values are in a given series.
```julia-repl
julia> valuesE(3)
 100
 220
 470
```

Basic usage:
```julia-repl
julia> vals = [3, 7e-7, 14e-2, 17e7]
4-element Vector{Float64}:
 3.0
 7.0e-7
 0.14
 1.7e8

# The second argument is the specific E series to round to
julia> roundE(vals, 24)
4-element Vector{Float64}:
 3.0
 6.8e-7
 0.15
 1.8e8
 ```

Adding the third positionional argument allows 
control of the output format:
```julia-repl
julia> roundE(vals, 24, :ENG)
4-element Vector{String}:
 "3.0×10⁰"
 "680×10⁻⁹"
 "150×10⁻³"
 "180×10⁶"
```

```julia-repl
julia> roundE(vals, 24, :SI)
4-element Vector{String}:
 "3.0"
 "680n"
 "150m"
 "180M"
```

As a final check, lets see that all calculated values are in the E24 series, along with a value that is not. Note that factors of 10 are manually removed or added until the values range from 100 to 1000. This is because E-series repeat for every factor of 10, and is therefore only defined within one order of magnitude.
```julia-repl
# Staring a line with `@.` makes everything occur elementwise
julia> @. [300, 680, 150, 151] in valuesE(24, print_to_repl=false)
4-element BitVector:
 1
 1
 1
 0
```
where `0` means false, and `1` means true.

## Docstrings
This package aims to include elaborate docstrings for each function. If you forget how a functions works, can always check the docstring with `?function_name`.
```julia-repl
help?> valuesE

    valuesE(series_number)
    valuesE(series_number; print_to_repl=true, hundred_to_thousand=true, popfinal=true)

  Returns the values in the E-series series_number. This function is intended for printing the series values for
  comparison with available components. To get the values returned from the function as opposed to printed, set
  print_to_repl=false.  
  
  The other keyword arguments are related to technical details in the package internals, but are explained below for
  completeness:  
  
  If hundred_to_thousand=false, the values range from 1 to 10.  
  If popfinal=false, every series has 10 (or 1000) as its final value, even though this value is not part of the E-series.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> valuesE(3)
  3-element Vector{Int64}:
   100
   220
   470
```

## How the rounding is implemented
The rounding function returns the value with the smallest percentage error in the given E-series.
It does this by finding the [geometric mean](https://en.wikipedia.org/wiki/Geometric_mean) of the 
two numbers in the given E-series ajecent to the given value (one smaller, one larger), and 
returning the E-series value on the same side of the mean value as the input value.

In other words, if the input value is larger than the geometric mean, the returned value was rounded up. 
If the given input is smaller than the geometric mean, the output was rounded down. Rounding in this case 
means taking the first bigger/smaller value in the E-series.
  
  
## Feedback
As this is the first package of a relativly novice programmer, feedback and input on ways the package could be better are very welcome!

### ToDo
* Add support for rounding to other standards for electrical components.
* Add tests:
    * Round 1:10 and 100:1000, and see that they are in the series rounded to (for all series?)
    * Round a number of values, add a tiny number, and see that none are in the series rounded to
