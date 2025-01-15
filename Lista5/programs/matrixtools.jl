# Aleksandra Czarniecka 272385

module Matrix_tools

using LinearAlgebra
using SparseArrays

export compute_right_side_vector, load_matrix, load_vector, write_vector_x, write_vector_with_error

"""
Funkcja wczytująca macierz rzadką z pliku.

Parametry: 
    file- ścieżka do pliku wejściowego
Returns: 
    A - macierz rzadka współczynników rozmiaru nxn 
    n - rozmiar macierzy
    l - rozmiar bloków
"""
function load_matrix(file::String)
    open(file, "r") do f
        n, l = readline(f) |> x -> parse.(Int64, split(x))
        
        rows, cols, values = Int64[], Int64[], Float64[]
        for line in eachline(f)
            if line != "EOF"
                i, j, val = split(line)
                push!(rows, parse(Int64, i))
                push!(cols, parse(Int64, j))
                push!(values, parse(Float64, val))
            end
        end
        
        A = sparse(rows, cols, values)

        return A, n, l
    end
end


"""
Funkcja wczytująca wektor z pliku.

Parametry:
    file - ścieżka do pliku wejściowego
Returns: 
    b - wektor prawych stron długości n
"""
function load_vector(file::String)::Vector{Float64}
    open(file, "r") do f

        n = parse(Int64, strip(readline(f)))
        b = Vector{Float64}(undef, n)
        
        for (i, line) in enumerate(eachline(f))
            b[i] = parse(Float64, line)
        end
        
        return b
    end
end

"""
Funkcja zapisująca wektor x do pliku (jeśli macierz A i wektor prawych stron b były czytanie z plików)

Parametry: 
    file - ścieżka do pliku 
    x - wektor
"""
function write_vector_x(file::String, x::Vector{Float64})
    open(file, "w") do f
        for (_, x_val) in enumerate(x)
            write(f, "$x_val\n")
        end
    end
end

"""
Funkcja zapisująca wektor  x do pliku (jeśli macierz A była czytana z plików, a wektor prawych stron b był obliczany funckją compute_right_side_vector)

Parametry: 
    file - ścieżka do pliku
    x - wektor obliczony jedną z metod
    x_true - wektor x obliczony funkcją compute_right_side_vector
"""
function write_vector_with_error(file::String, x::Vector{Float64})
    # Obliczanie błędu względnego
    exact_x = ones(length(x))
    relative_error = norm(x - exact_x) / norm(exact_x)

    open(file, "w") do f
        write(f, "$relative_error\n")
        for (_, x_val) in enumerate(x)
            write(f, "$x_val\n")
        end
    end
end

"""
Funkcja wyliczająca wektor prawych stron na podstawie macierzy A.
b = Ax, gdzie x- wektor jedynek
Parametry:
    A - macierz rzadka współczynników rozmiaru nxn w formacie SparseMatrixCSC
    l - rozmiar bloku
Returns:
    b - wektor prawych stron
"""
function compute_right_side_vector(A::SparseMatrixCSC{Float64}, l::Int64)::Vector{Float64}
    n = size(A, 1)
    b = zeros(Float64, n)

    for i in 1:n
        for j in get_columns(A, i, l)
            b[i] += A[i, j]
        end
    end

    return b
end

"""
Funkcja zwraca zakres indeksów kolumn z niezerowymi wartościami w danym wierszu macierzy blokowej.

Parametry: 
    A - macierz blokowa
    row - indeks wiersza

Returns:
    block_start:block_end - zakres kolumn z niezerowymi wartościami
"""
function get_columns(A::SparseMatrixCSC{Float64}, row::Int64, l::Int64)
    n = size(A, 1)  

    block_start = max(1, row - ((row - 1) % l) - 1)
    block_end = Int64(min((l + row), n))
    
    return block_start:block_end
end

end
