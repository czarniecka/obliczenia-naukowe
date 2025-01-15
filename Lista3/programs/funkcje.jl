#Aleksandra Czarniecka 272385

module funkcje
export mbisekcji, mstycznych, msiecznych

# Funkcja rozwiązująca równanie f(x) = 0 metodą bisekcji.
# Dane:
#      f- funkcja f(x) zadana jako anonimowa funkcja,
#      a, b- końce przedziału początkowego,
#      delta, epsilon- dokładności obliczeń.

# Wynik: 
#      (r, v, it, err)- czwórka, gdzie
#      r- przybliżenie pierwiastka równania f(x) = 0,
#      v- wartość f(r),
#      it- liczba wykonanych iteracji,
#      err- sygnalizacja błędu
#           0- brak błędu,
#           1- funkcja nie zmienia znaku w przedziale [a,b].
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    u::Float64 = f(a)
    v::Float64 = f(b)
    e::Float64 = b - a

    if sign(u) == sign(v)
        return Nothing, Nothing, Nothing, 1
    end

    k = 1
    while true
        e /= 2      
        c = a + e
        w::Float64 = Float64(f(c))
        
        if abs(e) < delta || abs(w) < epsilon
            return c, w, k, 0
        end

        if sign(w) != sign(u)
            b = c
            v = w 
        else
            a = c
            u = w 
        end
        k += 1
    end
end

# Funkcja rozwiązująca równanie f(x) = 0 metodą Newtona.
# Dane:
#      f, pf- funkcja f(x) i pochodna f'(x) zadane jako anonimowe funkcje,
#      x0- przybliżenie początkowe,
#      delta, epsilon- dokładności obliczeń,
#      maxit- maksymalna dopuszczalna liczba iteracji.

# Wynik: 
#      (r, v, it, err)- czwórka, gdzie
#      r- przybliżenie pierwiastka równania f(x) = 0,
#      v- wartość f(r),
#      it- liczba wykonanych iteracji,
#      err- sygnalizacja błędu
#           0- metoda zbieżna,
#           1- nie osiągnięto wymaganej dokładności w maxit iteracji,
#           2- pochodna bliska zeru.
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v::Float64 = f(x0)

    if abs(v) < epsilon
        return x0, v, 0, 0
    end

    for k in 1:maxit 
        pfx::Float64 = pf(x0)

        if abs(pfx) < epsilon
            return x0, v, k, 2
        end

        x1::Float64 = x0 - (v/pfx)
        v = f(x1)

        if abs(x1 - x0) < delta || abs(v) < epsilon
            return x1, v, k, 0
        end
        x0 = x1
    end

    return x0, v, maxit, 1
end

# Funkcja rozwiązująca równanie f(x) = 0 metodą siecznych.
# Dane:
#      f- funkcja f(x) zadana jako anonimowa funkcja,
#      x0, x1- przybliżenia początkowe,
#      delta, epsilon- dokładności obliczeń,
#      maxit- maksymalna dopuszczalna liczba iteracji.

# Wynik: 
#      (r, v, it, err)- czwórka, gdzie
#      r- przybliżenie pierwiastka równania f(x) = 0,
#      v- wartość f(r),
#      it- liczba wykonanych iteracji,
#      err- sygnalizacja błędu
#           0- metoda zbieżna,
#           1- nie osiągnięto wymaganej dokładności w maxit iteracji.
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64,
maxit::Int)
    fx0::Float64 = f(x0)
    fx1::Float64 = f(x1)

    for k in 1:maxit 
        if abs(fx0) > abs(fx1)
            x0, x1 = x1, x0
            fx0, fx1 = fx1, fx0
        end

        s::Float64 = (x1 - x0)/(fx1 - fx0)
        x1 = x0
        fx1 = fx0
        x0 = x0 - fx0 * s
        fx0 = f(x0)

        if abs(x1 - x0) < delta || abs(fx0) < epsilon
            return x0, fx0, k, 0
        end
    end
    return x0, fx0, maxit, 1
end

end