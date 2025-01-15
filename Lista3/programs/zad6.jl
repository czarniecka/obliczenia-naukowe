# Aleksandra Czarniecka 272385

include("funkcje.jl")
using .funkcje

println("Przybliżenie pierwiastka r & f(r) & Liczba iteracji & Kod błędu")

function calculate1(f, a, b, delta, epsilon)
    r, v, it, err = mbisekcji(f, a, b, delta, epsilon)
    println(r, " & ", v, " & ", it, " & ", err, " & ")
    return r, v
end

function calculate2(f, pf, x0, delta, epsilon, maxit)
    r, v, it, err = mstycznych(f, pf, x0, delta, epsilon, maxit)
    println(r, " & ", v, " & ", it, " & ", err, " & ")
    return r, v
end

function calculate3(f, x0, x1, delta, epsilon, maxit)
    r, v, it, err = msiecznych(f, x0, x1, delta, epsilon, maxit)
    println(r, " & ", v, " & ", it, " & ", err, " & ")
    return r, v
end

f1 = x -> (MathConstants.e)^(1-x) - 1
f2 = x -> x * (MathConstants.e)^(-x)
delta = epsilon = 10^(-5)

println("f1(x) = e^(1-x) - 1\n")
println("Metoda bisekcji: ")
r110, v110 = calculate1(f1, 0.0, 2.0, delta, epsilon)
r111, v111 = calculate1(f1, 0.0, 2.1, delta, epsilon)
r112, v112 = calculate1(f1, 0.1, 1024.0, delta, epsilon)
r113, v113 = calculate1(f1, 0.1, 1.0e6, delta, epsilon)
r114, v114 = calculate1(f1, -1e27, 1e27, delta, epsilon)
println()

pf1 = x -> -(MathConstants.e)^(1-x)
println("Metoda Newtona: ")
r1221, v1221 = calculate2(f1, pf1, -1024.0, delta, epsilon, 20)
r12214, v12214 = calculate2(f1, pf1, -100.0, delta, epsilon, 20)
r12215, v12215 = calculate2(f1, pf1, -10.0, delta, epsilon, 20)
r1231, v1231 = calculate2(f1, pf1, -1.0, delta, epsilon, 20)
r12314, v12314 = calculate2(f1, pf1, 1.0, delta, epsilon, 20)
r12315, v12315 = calculate2(f1, pf1, 2.0, delta, epsilon, 20)
r120, v120 = calculate2(f1, pf1, 10.0, delta, epsilon, 20)
r1214, v1214 = calculate2(f1, pf1, 100.0, delta, epsilon, 20)
r1215, v1215 = calculate2(f1, pf1, 1024.0, delta, epsilon, 20)

println()
println("Metoda siecznych: ")
r132, v132 = calculate3(f1, 0.0, 2.0, delta, epsilon, 20)
r132, v132 = calculate3(f1, 0.0, 2.1, delta, epsilon, 20)
r133, v133 = calculate3(f1, 0.1, 1024.0, delta, epsilon, 20)
r134, v134 = calculate3(f1, 1.1, 1024.0, delta, epsilon, 20)
r135, v135 = calculate3(f1, -1024.0, 1024.0, delta, epsilon, 20)
r136, v136 = calculate3(f1, -1e27, -1.0, delta, epsilon, 20)
println()

println("-------------------------------------------------------------")
println("f2(x) = x*e^(-x)\n")
println("Metoda bisekcji: ")
r210, v210 = calculate1(f2, 0.0, 2.0, delta, epsilon)
r211, v211 = calculate1(f2, 0.0, 2.1, delta, epsilon)
r212, v212 = calculate1(f2, 0.1, 1024.0, delta, epsilon)
r113, v113 = calculate1(f2, 0.1, 1.0e6, delta, epsilon)
r114, v114 = calculate1(f2, -1e27, 1e17, delta, epsilon)
println()

pf2 = x -> (MathConstants.e)^(-x) * (1-x)
println("Metoda Newtona: ")
r220, v220 = calculate2(f2, pf2, -1024.0, delta, epsilon, 20)
r221, v221 = calculate2(f2, pf2, -100.0, delta, epsilon, 20)
r2214, v2214 = calculate2(f2, pf2, -10.0, delta, epsilon, 20)
r2215, v2215 = calculate2(f2, pf2, 1.0, delta, epsilon, 20)
r2221, v2221 = calculate2(f2, pf2, 2.0, delta, epsilon, 20)
r222, v222 = calculate2(f2, pf2, 10.0, delta, epsilon, 20)
r223, v223 = calculate2(f2, pf2, 100.0, delta, epsilon, 20)
r224, v224 = calculate2(f2, pf2, 1024.0, delta, epsilon, 20)
println()

println("Metoda siecznych: ")
r232, v232 = calculate3(f2, -0.1, 2.0, delta, epsilon, 20)
r232, v232 = calculate3(f2, 0.0, 2.0, delta, epsilon, 20)
r233, v233 = calculate3(f2, 0.1, 1024.0, delta, epsilon, 20)
r231, v231 = calculate3(f2, 1.1, 1024.0, delta, epsilon, 20)
r2333, v2333 = calculate3(f2, -1024.0, 1024.0, delta, epsilon, 20)
r2313, v2313 = calculate3(f2, -1e27, -1.0, delta, epsilon, 20)

