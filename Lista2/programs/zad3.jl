# Aleksandra Czarniecka 272385

using Printf
using LinearAlgebra

# Źródła w języku Julia
include("hilb.jl")
include("matcond.jl")

# Funkcja do rozwiązywania układu równań Ax = b, gdzie prawdziwym rozwiązaniem jest wektor jedynek.
# Wyznacza b = A * transposed(1,1,....,1), rozwiązania metodą Gaussa i metodą inwersji.
# Wyznacza błędy względne uzyskane dla obu metod.
# A: macierz współczynników
# n: stopień macierzy (liczba wierszy)
# returns: (n, cond(A), rank(A), err_gauss, err_inv)
function solve_eq(A, n)
    x = ones(Float64, n)
    b = A * x # wektor prawej strony

    # Rozwiązania za pomocą eliminacji Gaussa i metody odwracania macierzy
    x_gauss = A \ b
    x_inv = inv(A) * b

    # Obliczanie błędów względnych
    err_gauss = norm(x_gauss - x) / norm(x)
    err_inv = norm(x_inv - x) / norm(x)

    # Zwracanie wyników
    return @sprintf("%3d & %20.10e & %4d & %20.10e & %15.10e \\\\", 
        n, cond(A), rank(A), err_gauss, err_inv)
end

# Funkcja do generowania i drukowania wyników
function main()
    println("\\begin{table}[H]")
    println("\\centering")
    println("\\begin{tabular}{|c|c|c|c|c|}")
    println("\\hline")
    println("n & cond(A) & rank(A) & błąd metody Gaussa & błąd metody inwersji \\\\ \\hline")

    # Eksperymenty dla macierzy Hilberta
    println("\\multicolumn{5}{|c|}{\\textbf{Macierz Hilberta}} \\\\ \\hline")
    for n in 1:20
        println("\\hline")
        A = hilb(n)
        println(solve_eq(A, n))
    end
    
    # Eksperymenty dla losowych macierzy o zadanych uwarunkowaniach
    println("\\hline")
    println("\\multicolumn{5}{|c|}{\\textbf{Losowa macierz o zadanych uwarunkowaniach}} \\\\ \\hline")
    for n in [5, 10, 20]
        for c in [0, 1, 3, 7, 12, 16]
            println("\\hline")
            A = matcond(n, 10.0^c)
            println(solve_eq(A, n))
        end
    end

    println("\\end{tabular}")
    println("\\caption{Porównanie wyników dla macierzy Hilberta i losowych macierzy o różnych uwarunkowaniach.}")
    println("\\end{table}")
end

main()
