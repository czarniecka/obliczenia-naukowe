# Aleksandra Czarniecka 272385

# Wektory
x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

# Funkcja do obliczania iloczynu skalarnego "w przód"
# T: typ zmiennopozycyjny, dla którego obliczamy sumę
# returns: S- suma
function forward(T)
    S = T(0.0)
    for i in 1:5
        S += T(x[i]) * T(y[i])
    end
    return S
end

# # Funkcja do obliczania iloczynu skalarnego "w tył"
# T: typ zmiennopozycyjny, dla którego obliczamy sumę
# returns: S- suma
function backward(T)
    S = T(0.0)
    for i in 5:-1:1
        S += T(x[i]) * T(y[i])
    end
    return S
end

# Funkcja do obliczania iloczynu skalarnego od największego do najmniejszego
# T: typ zmiennopozycyjny, dla którego obliczamy sumę
# returns: S- suma
function largest_first(T)
    products = [T(xi) * T(yi) for (xi, yi) in zip(x, y)]
    
    # Dzielimy iloczyny na dodatnie i ujemne
    pos_products = sort([p for p in products if p > 0], rev=true)  # Dodatnie, sortowane od największego
    neg_products = sort([p for p in products if p < 0])  # Ujemne, sortowane od najmniejszego

    # Sumujemy
    S = T(sum(pos_products) + sum(neg_products))
    return S
end

# Funkcja do obliczania iloczynu skalarnego od najmniejszego do największego
# T: typ zmiennopozycyjny, dla którego obliczamy sumę
# returns: S- suma
function smallest_first(T)
    products = [T(xi) * T(yi) for (xi, yi) in zip(x, y)]
    
    # Dzielimy iloczyny na dodatnie i ujemne
    pos_products = sort([p for p in products if p > 0])  # Dodatnie, sortowane od najmniejszego
    neg_products = sort([p for p in products if p < 0], rev=true)  # Ujemne, sortowane od największego

    # Sumujemy
    S = T(sum(pos_products) + sum(neg_products))
    return S
end

println("Float32:")
println("Iloczyn skalarny 'w przód':                        \t", forward(Float32))
println("Iloczyn skalarny 'w tył':                          \t", backward(Float32))
println("Iloczyn skalarny od największego do najmniejszego: \t", largest_first(Float32))
println("Iloczyn skalarny od najmniejszego do największego: \t", smallest_first(Float32))

println()

println("Float64:")
println("Iloczyn skalarny 'w przód':                        \t", forward(Float64))
println("Iloczyn skalarny 'w tył':                          \t", backward(Float64))
println("Iloczyn skalarny od największego do najmniejszego: \t", largest_first(Float64))
println("Iloczyn skalarny od najmniejszego do największego: \t", smallest_first(Float64))
