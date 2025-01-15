# Aleksandra Czarniecka 272385

module Functions
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx
using Plots

# Funkcja obliczająca ilorazy różnicowe dla metody Newtona
# x: wektor węzłów interpolacji (Float64)
# f: wartości funkcji w węzłach (Float64)
# returns: fx wektor ilorazów różnicowych (Float64)
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(x)       # Liczba węzłów
    fx = f[:]           # Kopiowanie wartości wektora f
    for j in 2:n
        for i in n:-1:j
            fx[i] = (fx[i] - fx[i-1]) / (x[i] - x[i-j+1])
        end
    end
    return fx
end

# Funkcja obliczająca wartość wielomianu Newtona w punkcie t
# x: wektor węzłów interpolacji (Float64)
# fx: wektor ilorazów różnicowych (Float64)
# t: punkt, w którym obliczamy wartość wielomianu (Float64)
# returns: wartość wielomianu interpolacyjnego w punkcie t (Float64)
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(x)       # Liczba węzłów
    nt::Float64 = fx[n]      # Inicjalizacja wyniku ostatnim współczynnikiem ilorazów
    for i in (n-1):-1:1
        nt = nt * (t - x[i]) + fx[i]
    end
    return nt
end

# Funkcja przekształcająca wielomian Newtona na postać naturalną
# x: wektor węzłów interpolacji (Float64)
# fx: wektor ilorazów różnicowych (Float64)
# returns: wektor współczynników wielomianu w postaci naturalnej (Float64)
function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(x)       # Liczba węzłów
    a::Vector{Float64} = zeros(n)        # Inicjalizacja wektora współczynników
    a[n] = fx[n]        # Ostatni współczynnik równy ostatniemu ilorazowi różnicowemu
    for i in (n-1):-1:1
        a[i] = fx[i] - x[i] * a[i+1]
        for j in (i+1):(n-1)
            a[j] += -x[i] * a[j+1]
        end
    end
    return a
end

# Funkcja rysująca wykres funkcji oryginalnej i wielomianu interpolacyjnego Newtona
# f: funkcja, która ma być interpolowana
# a: początek przedziału (Float64)
# b: koniec przedziału (Float64)
# n: liczba węzłów interpolacyjnych (Int)
# filename: nazwa pliku, do którego zostanie zapisany wykres (String)
function rysujNnfx(f, a::Float64, b::Float64, n::Int, filename::String)
    # Tworzenie węzłów i obliczanie ilorazów różnicowych
    x = [a + k * (b - a) / n for k in 0:n]
    fx = ilorazyRoznicowe(x, [f(xk) for xk in x])
    
    # Tworzenie punktów do rysowania
    xs = range(a, b, length=1000)
    ys_interpolated = [warNewton(x, fx, t) for t in xs]
    ys_original = [f(t) for t in xs]
    
    # Tworzenie wykresów funkcji oryginalnej i interpolacyjnej
    p = plot(xs, ys_original, label="funkcja oryginalna", lw=2, color=:blue)
    plot!(p, xs, ys_interpolated, label="wielomian interpolacyjny", lw=2, color=:red)

    savefig(p, filename)
end

end