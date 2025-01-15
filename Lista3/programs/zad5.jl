# Aleksandra Czarniecka 272385

include("funkcje.jl")
using .funkcje

f = x -> 3*x - (MathConstants.e)^x
delta = epsilon = 10^(-4)

println("Przybliżenie pierwiastka r & f(r) & Liczba iteracji & Kod błędu")

r, v, it, err = mbisekcji(f, 0.0, 1.0, delta, epsilon)
println(r, " & ", v, " & ", it, " & ", err, " & ")

r, v, it, err = mbisekcji(f, 1.0, 4.0, delta, epsilon)
println(r, " & ", v, " & ", it, " & ", err, " & ")

r, v, it, err = mbisekcji(f, -1.0e27, 1.0, delta, epsilon)
println(r, " & ", v, " & ", it, " & ", err, " & ")

r, v, it, err = mbisekcji(f, 1.0, 1.0e27, delta, epsilon)
println(r, " & ", v, " & ", it, " & ", err, " & ")
