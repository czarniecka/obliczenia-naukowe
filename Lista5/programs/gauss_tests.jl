# Aleksandra Czarniecka 272385

include("matrixgen.jl")
include("blocksys.jl")
include("matrixtools.jl")

using .Blocksys
using .matrixgen
using .Matrix_tools
using SparseArrays
using Test

@testset "gauss 16" begin
    (A,n,l) = load_matrix("Dane16_1_1/A.txt")
    b = load_vector("Dane16_1_1/b.txt")
    x_vec = gauss_elimination(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end 

@testset "gauss 10000" begin
    (A,n,l) = load_matrix("Dane10000_1_1/A.txt")
    b = load_vector("Dane10000_1_1/b.txt")
    x_vec = gauss_elimination(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 50000" begin
    (A,n,l) = load_matrix("Dane50000_1_1/A.txt")
    b = load_vector("Dane50000_1_1/b.txt")
    x_vec = gauss_elimination(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 100000" begin
    (A,n,l) = load_matrix("Dane100000_1_1/A.txt")
    b = load_vector("Dane100000_1_1/b.txt")
    x_vec = gauss_elimination(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 300000" begin
    (A,n,l) = load_matrix("Dane300000_1_1/A.txt")
    b = load_vector("Dane300000_1_1/b.txt")
    x_vec = gauss_elimination(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss 500000" begin
    (A,n,l) = load_matrix("Dane500000_1_1/A.txt")
    b = load_vector("Dane500000_1_1/b.txt")
    x_vec = gauss_elimination(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with main 16" begin
    (A,n,l) = load_matrix("Dane16_1_1/A.txt")
    b = load_vector("Dane16_1_1/b.txt")
    x_vec = gauss_elimination_with_main_element(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with main 10000" begin
    (A,n,l) = load_matrix("Dane10000_1_1/A.txt")
    b = load_vector("Dane10000_1_1/b.txt")
    x_vec = gauss_elimination_with_main_element(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with main 50000" begin
    (A,n,l) = load_matrix("Dane50000_1_1/A.txt")
    b = load_vector("Dane50000_1_1/b.txt")
    x_vec = gauss_elimination_with_main_element(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with main 100000" begin
    (A,n,l) = load_matrix("Dane100000_1_1/A.txt")
    b = load_vector("Dane100000_1_1/b.txt")
    x_vec = gauss_elimination_with_main_element(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with main 300000" begin
    (A,n,l) = load_matrix("Dane300000_1_1/A.txt")
    b = load_vector("Dane300000_1_1/b.txt")
    x_vec = gauss_elimination_with_main_element(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset "gauss with main 500000" begin
    (A,n,l) = load_matrix("Dane500000_1_1/A.txt")
    b = load_vector("Dane500000_1_1/b.txt")
    x_vec = gauss_elimination_with_main_element(A, b, l)
    @testset for x in @view x_vec[:,:]
        @test x ≈ 1.0
    end
end

@testset for i = 1000:1000:10000
    @testset "gauss $i computed b" begin
        blockmat(i, 4, 10.0, "matrix/matrix$i")
        (A,n,l) = load_matrix("matrix/matrix$i")
        x = ones(Float64, n)
        b = compute_right_side_vector(A, l)
        x_vec = gauss_elimination(A, b, l)
        @test all(map(x -> x ≈ 1.0, x_vec)) 
    end
end

@testset for i = 1000:1000:10000
    @testset "gauss with main $i computed b" begin
        blockmat(i, 4, 10.0, "matrix/matrix$i")
        (A,n,l) = load_matrix("matrix/matrix$i")
        x = ones(Float64, n)
        b = compute_right_side_vector(A, l)
        x_vec = gauss_elimination_with_main_element(A, b, l)
        @test all(map(x -> x ≈ 1.0, x_vec)) 
    end
end

