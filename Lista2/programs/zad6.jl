# Aleksandra Czarniecka 272385

# Funkcja wykonująca iteracje równania rekurencyjnego
# x0: zerowy wyraz ciągu
# c: pewna dana stała
# iterations: numer iteracji
# returns: wynik równania rekurencyjnego
function iterate_sequence(x0, c, iterations=40)
    xs = Float64(x0)
    results = Float64[xs]
    for _ in 1:iterations
        xs = xs^Float64(2.0) + Float64(c)
        push!(results, xs)
    end
    return results
end

# Funkcja do generowania tabelki w formacie LaTeX
function generate_latex_table(c, x0_values, iterations=40)
    println("\\begin{table}[H]")
    println("\\centering")
    println("\\begin{tabular}{|c|" * "c|"^length(x0_values) * "}\n\\hline")
    
    # Wartość c oraz wartości x0 w tabeli
    print("c = ", c)
    print(" & ")
    for x0 in x0_values
        print(string(Float64(x0)), " & ")
    end
    println("\\\\ \\hline")
    
    # Iterowanie po wynikach dla każdej iteracji
    for i in 1:iterations
        print("\\( $i \\) & ")
        for x0 in x0_values
            results = iterate_sequence(x0, c)
            print(string(results[i + 1]), " & ")
        end
        println("\\\\ \\hline")
    end

    println("\\end{tabular}")
    println("\\caption{Wyniki iteracji dla c = $c}")
    println("\\end{table}")
end

# Zbiory wartości x0 dla c = -2 i c = -1
x0_values_c_minus2 = Float64[1.0, 2.0, 1.99999999999999]
x0_values_c_minus1 = Float64[1.0, -1.0, 0.75, 0.25]

# Generowanie tabeli dla c = -2
generate_latex_table(Float64(-2.0), x0_values_c_minus2)

# Generowanie tabeli dla c = -1
generate_latex_table(Float64(-1.0), x0_values_c_minus1)
