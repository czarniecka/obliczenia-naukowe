# Aleksandra Czarniecka 272385

include("functions.jl")
using .Functions
using Plots

# Funkcja testująca rysowanie wykresów interpolacji Newtona dla różnych funkcji
# Funkcja iteruje po kilku przykładach funkcji i różnych stopniach wielomianów interpolacyjnych
# Wygenerowane wykresy są zapisywane jako pliki PNG
function testujRysujNnfx()
    functions = [
        (x -> exp(x), "1", 0.0, 1.0),
        (x -> x^2 * sin(x), "2", -1.0, 1.0),
        (x -> abs(x), "3", -1.0, 1.0),
        (x -> (1 / (1 + x^2)), "4", -5.0, 5.0)
    ]
    
    n_values = [5, 10, 15]
    
    for (f, fname, a, b) in functions
        sanitized_fname = replace(fname, r"[^\w]+" => "_")
        for n in n_values
            filename = "$(sanitized_fname)_n$(n).png"
            rysujNnfx(f, a, b, n, filename)
        end
    end
end

testujRysujNnfx()
