# Aleksandra Czarniecka 272385

include("functions.jl")
using Test
using .Functions

# Testy dla ilorazyRoznicowe f(x) = x^2
@testset "ilorazyRoznicowe" begin
    x = [1.0, 2.0, 3.0]
    f = [1.0, 4.0, 9.0]
    fx = ilorazyRoznicowe(x, f)
    @test fx ≈ [1.0, 3.0, 1.0]
end

# Testy dla warNewton f(x) = x^2s
@testset "warNewton" begin
    x = [1.0, 2.0, 3.0]
    f = [1.0, 4.0, 9.0]
    fx = ilorazyRoznicowe(x, f)
    @test warNewton(x, fx, 1.5) ≈ 2.25
    @test warNewton(x, fx, 2.5) ≈ 6.25 
    @test warNewton(x, fx, 3.0) ≈ 9.0
end

# Testy dla naturalna f(x) = x^2
@testset "naturalna" begin
    x = [1.0, 2.0, 3.0]
    f = [1.0, 4.0, 9.0]
    fx = ilorazyRoznicowe(x, f)
    a = naturalna(x, fx)
    @test a ≈ [0.0, 0.0, 1.0]
end

# Testy dla rysujNnfx 
@testset "Testy rysujNnfx" begin
    f(x) = x^2
    a, b = -2.0, 2.0
    n = 5
    filename = "test.png"
    rysujNnfx(f, a, b, n, filename)
    @test isfile(filename) 
    rm(filename) 
end