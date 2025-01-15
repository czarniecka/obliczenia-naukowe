# Aleksandra Czarniecka 272385

include("funkcje.jl")
using .funkcje
using Test

delta = epsilon = 10^-5

@testset "$(rpad("Metoda bisekcji", 15))" begin
    f = x -> x^2 - 4
    # Przykład podstawowy
    poprawnyWynik = 2.0
    res = mbisekcji(f, 1.0, 3.0, delta, epsilon)
    x = res[1]
    fx = res[2]
    err = res[4]
    @test abs(fx) <= epsilon
    @test abs(poprawnyWynik - x) <= delta
    @test err == 0

    # Przykład z przedziałem bez zmiany znaku
    res = mbisekcji(f, 3.0, 4.0, delta, epsilon)
    x = res[1]
    fx = res[2]
    it = res[3]
    err = res[4]
    @test fx == Nothing
    @test x == Nothing
    @test it == Nothing
    @test err == 1

    # Przykład, gdzie pierwiastek jest równo w połowie przedziału
    res = mbisekcji(f, 1.0, 3.0, delta, epsilon)
    x = res[1]
    fx = res[2]
    it = res[3]
    err = res[4]
    @test fx == 0
    @test x == 2.0
    @test it == 1
    @test err == 0
end

@testset "$(rpad("Metoda Newtona", 15))" begin
    # Przykład podstawowy
    f = x -> x^3 - 8
    pf = x -> 3x^2
    poprawnyWynik = 2.0
    res = mstycznych(f, pf, 1.5, delta, epsilon, 10)
    x = res[1]
    fx = res[2]
    err = res[4]
    @test abs(fx) <= epsilon
    @test abs(poprawnyWynik - x) <= delta
    @test err == 0

    # Przykład, gdzie pochodna jest równa 0 dla przybliżenia początkowego
    f = x -> x^2 - x
    pf = x -> 2x - 1
    res = mstycznych(f, pf, 0.5, delta, epsilon, 10)
    err = res[4]
    @test err == 2

    # Przykład, gdzie metoda Newtona wpada w cykl
    f = x -> x^3 - 2*x + 2
    pf = x -> 3*x^2 - 2
    res = mstycznych(f, pf, 0.0, delta, epsilon, 31)
    x = res[1]
    fx = res[2]
    it = res[3]
    err = res[4]
    @test abs(fx) > epsilon
    @test abs(x - 0.0) > delta
    @test it == 31
    @test err == 1
end


@testset "$(rpad("Metoda siecznych", 15))" begin
    # Przykład podstawowy
    f = x -> x^2 - 9
    poprawnyWynik = 3.0
    res = msiecznych(f, 2.5, 3.5, delta, epsilon, 10)
    x = res[1]
    fx = res[2]
    err = res[4]
    @test abs(fx) <= epsilon
    @test abs(poprawnyWynik - x) <= delta
    @test err == 0

    # Przykład, gdzie funkcja = 0 w punkcie zerowym
    f = x -> x^2
    res = msiecznych(f, -1.0, 1.0, delta, epsilon, 20)
    x = res[1]
    fx = res[2]
    it = res[3]
    err = res[4]
    @test isnan(fx)
    @test isnan(x)
    @test it == 20
    @test err == 1
end
