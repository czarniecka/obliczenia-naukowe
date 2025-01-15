# Aleksandra Czarniecka 272385

# Funkcja do obliczania f(x) = sqrt(x^2 + 1) - 1
# x: zmienna typu Float64
# returns: wynik funkcji dla x

function f(x::Float64)
    return sqrt(x * x + 1.0) - 1.0
end

# Funkcja do obliczania g(x) = x^2 / (sqrt(x^2 + 1) + 1)
# x: zmienna typu Float64
# returns: wynik funkcji dla x

function g(x::Float64)
    return (x * x) / (sqrt(x * x + 1.0) + 1.0)
end

for i in 1:200
    x = Float64(8^Float64(-i))
    println("x = 8^-", i, "\tf(x) = ", f(x), "\tg(x) = ", g(x))
end
