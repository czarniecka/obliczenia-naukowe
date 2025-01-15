# Aleksandra Czarniecka 272385

# Funkcja do iteracji równania logistycznego
# p0: wielkość populacji
# r: pewna dana stała
# iterations: numer iteracji
# T: typ zmiennopozycyjny
# returns: wynik równania rekurencyjnego
function logistic_model(p0, r, iterations, T)
    p = T(p0)
    results = T[p]
    for _ in 1:iterations
        p = p + T(r) * p * (T(1.0) - p)
        push!(results, p)
    end
    return results
end

# Eksperyment 1: Float32 bez modyfikacji
function experiment_float32(p0, r, iterations)
    return logistic_model(p0, r, iterations, Float32)
end

# Eksperyment 2: Float64 bez modyfikacji
function experiment_float64(p0, r, iterations)
    return logistic_model(p0, r, iterations, Float64)
end

# Eksperyment 3: Float32 z obcięciem po 10 iteracjach
function experiment_cutoff(p0, r, iterations, cutoff_iteration)
    # Początkowe obliczenia do momentu obcięcia (do cutoff_iteration - 1)
    results = logistic_model(p0, r, cutoff_iteration - 1, Float32)
    
    # Obliczenie wartości p_{cutoff_iteration}
    p_cutoff = results[end] + r * results[end] * (1.0 - results[end])
    p_cutoff = Float32(floor(p_cutoff * 10.0^3.0) / 10.0^3.0)  # Obcięcie do 3 miejsc po przecinku

    push!(results, p_cutoff)
    
    # Kontynuacja obliczeń od obciętej wartości p_cutoff
    for _ in (cutoff_iteration + 1):iterations
        p_cutoff = p_cutoff + r * p_cutoff * (1 - p_cutoff)
        push!(results, p_cutoff)
    end
    return results
end

# Parametry
p0 = 0.01
r = 3.0
iterations = 40
cutoff_iteration = 10

# Wykonanie eksperymentów
results_float32 = experiment_float32(p0, r, iterations)
results_float64 = experiment_float64(p0, r, iterations)
results_cutoff = experiment_cutoff(p0, r, iterations, cutoff_iteration)

println("\\begin{table}[H]")
println("\\centering")
println("\\begin{tabular}{|c|c|c|c|}")
println("\\hline")
println("Iteracja & Float32 (bez modyfikacji) & Float32 (obcięcie po 10 iteracji) & Float64 (bez modyfikacji)\\\\ \\hline")
for i in 0:iterations
    println("$(i) & $(results_float32[i+1]) & $(results_cutoff[i+1]) & $(results_float64[i+1])\\\\ \\hline")
end
println("\\end{tabular}")
println("\\caption{Porównanie wartości p_n wyznaczone z rekurencyjnego równania w kolejnych iteracjach (wartość n).}")
println("\\end{table}")
