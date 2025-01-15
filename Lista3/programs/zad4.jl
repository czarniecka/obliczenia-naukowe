# Aleksandra Czarniecka 272385

include("funkcje.jl")
using .funkcje

delta = epsilon = 0.5*10^(-5)
f = x -> sin(x) - (0.5*x)^2
pf = x -> cos(x) - x/2

println("Przybliżenie pierwiastka r & f(r) & Liczba iteracji & Kod błędu")

r, v, it, err = mbisekcji(f, 1.5, 2.0, delta, epsilon)
println(r, " & ", v, " & ", it, " & ", err, " & ")

r, v, it, err = mstycznych(f, pf, 1.5, delta, epsilon, 20)
println(r, " & ", v, " & ", it, " & ", err, " & ")

r, v, it, err = msiecznych(f, 1.0, 2.0, delta, epsilon, 20)
println(r, " & ", v, " & ", it, " & ", err, " & ")