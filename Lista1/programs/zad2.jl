# Aleksandra Czarniecka 272385

# Funkcja do obliczania epsilona maszynowego w arytmetyce zmiennopozycyjnej z równania Kahana.
# T: typ zmiennoprzecinkowy, dla którego obliczamy epsilon maszynowy
# returns: epsilon maszynowy

function kahan_epsilon(T)
    return T(3.0) * (T(4.0) / T(3.0) - one(T)) - one(T)
end

println("Kahan epsilon dla Float16: \t", kahan_epsilon(Float16))
println("Wynik funkcji eps(Float16):\t", eps(Float16))
println()

println("Kahan epsilon dla Float32: \t", kahan_epsilon(Float32))
println("Wynik funkcji eps(Float32):\t", eps(Float32))
println()

println("Kahan epsilon dla Float64: \t", kahan_epsilon(Float64))
println("Wynik funkcji eps(Float64):\t", eps(Float64))
