geometric_mean(a::Number, b::Number) = √(a*b)

function identify_series_candidates(a::Number, possible_values::Array)
    i, j = 1, 2
        while !(possible_values[i] ≤ a ≤ possible_values[j])
            i+=1; j+=1
        end
    return possible_values[i], possible_values[j]
end

function norm_to_between_100_and_1000(val::Number; return_OOM=true)
    power_of_10 = 0.0
    while val > 1000
        val/=10; power_of_10 += 1
    end
    while val < 100
        val*=10; power_of_10 += -1
    end
    if return_OOM
        return val, power_of_10
    else
        return val
    end
end

nothing
