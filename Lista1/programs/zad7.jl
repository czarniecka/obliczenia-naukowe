# Aleksandra Czarniecka 272385

# Definiujemy funkcję f: f(x) = sin(x) + cos(3x)
function f(x::Float64)
    return sin(x) + cos(3.0 * x)
end

# Dokładna pochodna funkcji f: df(x, h) ~ f'(x), df(x, h) = cos(x) - 3sin(3x)
function f_prime_exact(x::Float64)
    return cos(x) - 3 * sin(3 * x)
end

# Funkcja do obliczania przybliżonej wartości pochodnej: df(x, h) ~ f'(x), df(x, h) = (f(x + h) - f(x)) / h
function derivative_approx(x0::Float64, h::Float64)
    return (f(x0 + h) - f(x0)) / h
end

x0 = 1.0  # Punkt, w którym obliczamy pochodną

"""
# Zmienne do przechowywania wartości h i błędów
hs = Float64[]
errors = Float64[]
"""

# Iteracja po wartościach h
for n in 0:54
    h = 2.0^(-n)  # Obliczamy h
    approx = derivative_approx(x0, h)  # Przybliżenie pochodnej: ~f'(1)
    exact = f_prime_exact(x0)  # Dokładna pochodna: f'(1)
    error = abs(exact - approx)  # Błąd względny przybliżenia: |f'(1) - ~f'(1)|

    """
    # Zapisujemy wartości h i błędów
    push!(hs, h)
    push!(errors, error)
    """

    println("\t Dokładna wartość funkcji: ", exact,)
    println("h = 2^-", n, ", 1 + h = ", 1.0 + h)
    println("Przybliżenie: ", approx, "\t Błąd względny: ", error)
    println()
end

"""
# Wykres
import Pkg
Pkg.add("Plots")
using Plots

x_indices = 0:54
y_errors = errors

bar(x_indices, y_errors, legend=false, ylabel="Błąd", xlabel="Indeks n", yaxis=:log, title="Błąd przybliżenia pochodnej w zależności od h = 2^-n")
savefig("7.png")
"""