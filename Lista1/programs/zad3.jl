# Aleksandra Czarniecka 272385

# Funkcja rozdziela znaki bitowe dla liczby zmiennoprzecinkowej Float64
# na znak, wykładnik oraz mantysę, zwracając je jako pojedynczy string z podziałem na części.
# number: liczba, dla której format IEEE 754 będzie wyznaczony
# returns: String - znak, wykładnik i mantysa
function ieee_format(number::Float64)
    bits = bitstring(number)
    return join([bits[1], bits[2:12], bits[13:end]], " ")
end

# Funkcja oblicza deltę, czyli odstęp między liczbami zmiennoprzecinkowymi w przedziale [left, right].
# Funkcja porównuje obliczoną wartość delty z jej oczekiwaną wartością, bazując na wyznaczonym wykładniku.
# left: dolna granica przedziału
# right: górna granica przedziału
function calculate_delta(left::Float64, right::Float64)
    # Stała `bias` to wartość bazowa wykładnika dla formatu Double Precision (IEEE 754)
    bias = 1023
    # Wyciągamy wykładnik z reprezentacji `left` w formacie IEEE 754 i korygujemy o bias
    exponent_bits = parse(Int, bitstring(left)[2:12]; base=2) - bias
    # Wyliczenie oczekiwanej delty, bazując na wzorze delta = 2^(-52 + wykładnik)
    expected_delta = Float64(2.0^(-52 + exponent_bits))
    # Obliczenie rzeczywistej delty jako różnicy między `left` a jego następną wartością maszynową
    actual_delta = Float64(nextfloat(left) - left)

    println("Zakres: [$left, $right]")
    println("Lewa granica ($left):   ", ieee_format(left))
    println("Prawa granica ($right): ", ieee_format(right))
    println()

    println("Porównanie wartości delty -----------------------------------------------------")
    println("Znana wartość delty:")
    println("  Wykładnik: $(-52.0 + exponent_bits)")
    println("  Delta:     $expected_delta\n")
    println("Obliczona wartość delty:")
    println("  Wykładnik: $(log2(actual_delta))")
    println("  Delta:     $actual_delta\n")

    println("Reprezentacje kluczowych wartości -----------------------------------------------")
    println("Pierwsza liczba ($left) binarnie: \t\t\t\t", ieee_format(left))
    println("Następna liczba ($(nextfloat(left))) binarnie: \t\t\t", ieee_format(nextfloat(left)))
    println("Obliczona następna liczba ($(left + expected_delta)) binarnie: \t", ieee_format(left + expected_delta))
    println("Przedostatnia liczba ($(prevfloat(right))) binarnie: \t\t", ieee_format(prevfloat(right)))
    println("Obliczona przedostatnia liczba ($(left + (2^52 - 1) * expected_delta)) binarnie: \t", ieee_format(left + (2^52 - 1) * expected_delta))
    println("Ostatnia liczba ($right) binarnie: \t\t\t\t", ieee_format(right))
end

# Funkcja drukuje binarne reprezentacje kolejnych `n` liczb zmiennoprzecinkowych po `x`.
# x: liczba początkowa
# n: liczba kolejnych liczb do wydrukowania
function print_next_n_floats(x::Float64, n::Int)
    for _ in 1:n 
        println(bitstring(x))
        x = nextfloat(x)
    end
end

# Funkcja drukuje binarne reprezentacje poprzednich `n` liczb zmiennoprzecinkowych po `x`.
# x: liczba początkowa
# n: liczba kolejnych liczb do wydrukowania
function print_before_n_floats(x::Float64, n::Int)
    for _ in 1:n 
        println(bitstring(x))
        x = prevfloat(x)
    end
end

# Funkcja drukuje binarne reprezentacje `n` liczb zmiennoprzecinkowych,
# różniących się o `delta`, poczynając od `x`.
# x: liczba początkowa
# delta: wartość przyrostu przy każdym kroku
# n: liczba liczb do wydrukowania
function print_delta_higher_n_floats(x::Float64, delta::Float64, n::Int)
    for _ in 1:n 
        println(bitstring(x))
        x += delta
    end
end

# Funkcja drukuje binarne reprezentacje `n` liczb zmiennoprzecinkowych,
# różniących się o `-delta`, poczynając od `x`.
# x: liczba początkowa
# delta: wartość przyrostu przy każdym kroku
# n: liczba liczb do wydrukowania
function print_delta_lower_n_floats(x::Float64, delta::Float64, n::Int)
    for _ in 1:n 
        println(bitstring(x))
        x -= delta
    end
end

# Wywołanie funkcji calculate_delta
calculate_delta(2.0, 4.0)

println()
# Wywołanie przykładowych funkcji print_next_n_floats i print_delta_higher_n_floats
println("5 kolejnych liczb po 1:")
print_next_n_floats(1.0, 5)

println("5 kolejnych delta większych liczb po 1:")
print_delta_higher_n_floats(1.0, 2.0^-52, 5)

println("5 kolejnych liczb po 1.5:")
print_next_n_floats(1.5, 5)

println("5 kolejnych delta większych liczb po 1.5:")
print_delta_higher_n_floats(1.5, 2.0^-52, 5)

println("5 poprzednich liczb przed 2.0:")
print_before_n_floats(2.0, 5)

println("5 poprzednich delta mniejszych liczb przed 2.0:")
print_delta_lower_n_floats(2.0, 2.0^-52, 5)