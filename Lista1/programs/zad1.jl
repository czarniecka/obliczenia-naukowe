# Aleksandra Czarniecka 272385

# Funkcje iteracyjne

# Funkcja do obliczania epsilona maszynowego dla konkretnego typu zmiennopozycyjnego.
# T: typ zmiennoprzecinkowy, dla którego obliczamy epsilon maszynowy
# returns: epsilon maszynowy (macheps)

function compute_macheps(T)
    macheps = one(T)
    while one(T) + macheps != one(T)
        macheps /= 2
    end
    return macheps * 2
end

# Funkcja do obliczania liczby maszynowej ety dla konkretnego typu zmiennopozycyjnego.
# T: typ zmiennoprzecinkowy, dla którego obliczamy etę
# returns: eta

function compute_eta(T)
    eta = one(T)
    while eta / 2 > 0.0
        eta /= 2
    end
    return eta
end

# Funkcja do obliczania liczby maszynowej ety dla konkretnego typu zmiennopozycyjnego.
# T: typ zmiennoprzecinkowy, dla którego obliczamy max
# returns: max- maksymalna możliwa wartość

function compute_max(T)
    prev_max = one(T)
    max = one(T)
    while max - prev_max < 1.0
        prev_max /= 2
    end
    max = max - (prev_max * 2)
    while !isinf(max * 2)
        max *= 2
    end
    return max
end

println("Macheps -------------------------------------------------------")
println("Epsilon maszynowy dla Float16: \t\t", compute_macheps(Float16))
println("Wynik funkcji eps(Float16):    \t\t", eps(Float16))
println()

println("Epsilon maszynowy dla Float32: \t\t", compute_macheps(Float32))
println("Wynik funkcji eps(Float32):    \t\t", eps(Float32))
println()

println("Epsilon maszynowy dla Float64:\t\t", compute_macheps(Float64))
println("Wynik funkcji eps(Float64):   \t\t", eps(Float64))
println()

println("Eta -----------------------------------------------------------")
println("Eta dla Float16:                       \t", compute_eta(Float16))
println("Wynik funkcji nextfloat(Float16(0.0)): \t", nextfloat(Float16(0.0)))
println()

println("Eta dla Float32:                       \t", compute_eta(Float32))
println("Wynik funkcji nextfloat(Float32(0.0)): \t", nextfloat(Float32(0.0)))
println()

println("Eta dla Float64:                       \t", compute_eta(Float64))
println("Wynik funkcji nextfloat(Float64(0.0)): \t", nextfloat(Float64(0.0)))
println()

println("Max -----------------------------------------------------------")
println("Max dla Float16:                       \t", compute_max(Float16))
println("Wynik funkcji floatmax(Float16): \t", floatmax(Float16))
println()
    
println("Max dla Float32:                       \t", compute_max(Float32))
println("Wynik funkcji floatmax(Float32): \t", floatmax(Float32))
println()
    
println("Max dla Float64:                       \t", compute_max(Float64))
println("Wynik funkcji floatmax(Float64): \t", floatmax(Float64))
