# Aleksandra Czarniecka 272385

# Funkcja do obliczania najmniejszego x, dla którego x * (1 / x) != 1.
# returns: minimalna liczba 1 < x < 2, dla której x(1/x) != 1 
#     lub: nothing, jeśli taka wartość nie istnieje

function find_x()
    x = one(Float64)  
    d = Float64(2.0)^(-52) # znana z zadania 3 delta między liczbami w przedziale [1,2]
    while x < 2.0
        if x * (1.0 / x) != one(Float64)  
            return x  
        end
        x += d
    end
    return nothing
end

println("Najmniejsze x, dla którego x * (1 / x) != 1: \t", find_x())
