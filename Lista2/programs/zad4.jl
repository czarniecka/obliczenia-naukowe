# Aleksandra Czarniecka 272385

using Polynomials

# Współczynniki wielomianu Wilkinsona
p = [1, -210.0, 20615.0, -1256850.0, 53327946.0, -1672280820.0,
    40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0, 
    1307535010540395.0, -10142299865511450.0, 63030812099294896.0,
    -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0, 
    8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0,      
    -8752948036761600000.0, 2432902008176640000.0]

p_normal = Polynomial(reverse(p))   # postać naturalna
p_factored = fromroots(1:20)        # postać iloczynowa
p_roots = roots(p_normal)           # pierwiastki z postaci normalnej

# Tabela z obliczonymi wynikami dla wielomianu Wilkinsona

println("\\begin{tabular}{|c|c|c|c|c|}")
println("\\hline")
println("k & \$z_k\$ & \$|P(z_k)|\$ & \$|p(z_k)|\$ & \$|z_k - k|\$ \\\\")
println("\\hline")

# Obliczanie wartości dla każdego pierwiastka
for k in 1:20
    z_k = p_roots[k]
    println("$(k) & $(z_k) & $(abs(p_normal(z_k))) & $(abs(p_factored(z_k))) & $(abs(z_k - k)) \\\\")
    println("\\hline")
end

# Tabela z dokładnymi pierwiastkami

println("\\begin{tabular}{|c|c|c|}")
println("\\hline")
println("k & \$|P(k)|\$ & \$|p(k)|\$ \\\\")
println("\\hline")

# Obliczanie wartości dla k = 1, 2, ..., 20
for k in 1:20
    println("$(k) & $(abs(p_normal(k))) & $(abs(p_factored(k))) \\\\")
    println("\\hline")
end

# Zmiana współczynnika -210 na -210 - 2^-23
p[2] -= 2.0^-23 
new_p = Polynomial(reverse(p))  # postać naturalna z zaburzeniem
new_roots = roots(new_p)        # pierwiastki postaci naturalnej z zaburzeniem

# Tabela z nowymi pierwiastkami po zaburzeniu

println("\\begin{tabular}{|c|c|c|}")
println("\\hline")
println("k & \$z_k\$ & \$|P(z_k)|\$ \\\\")
println("\\hline")

# Obliczanie nowych wyników po zaburzeniu jednego ze współczynników
for k in 1:20
    z_k = new_roots[k]
    println("$(k) & $(z_k) & $(abs(new_p(z_k))) \\\\")
    println("\\hline")
end
