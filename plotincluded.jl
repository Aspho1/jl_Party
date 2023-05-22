using JuMP
import HiGHS
import LinearAlgebra
import Plots
import Random

# Number of sinks
m = 15

#Number of sources 
n = 5

# Generate random Vectors to hold coords
x_c, y_c = rand(m), rand(m)
x_f, y_f = rand(n), rand(n)

# Demands
a = rand(1:3, m);

# Capacities
q = rand(5:10, n);



# Set the fixed costs?
f = ones(n);

# Edge weight by linear distance. 
c = zeros(m, n)
for i in 1:m
    for j in 1:n
        c[i, j] = LinearAlgebra.norm([x_c[i] - x_f[j], y_c[i] - y_f[j]], 2)
    end
end

model = Model(HiGHS.Optimizer)
# set_silent(model)
@variable(model, y[1:n], Bin);
@variable(model, x[1:m, 1:n], Bin);
# Each client is served exactly once
@constraint(model, client_service[i in 1:m], sum(x[i, j] for j in 1:n) == 1);
# A facility must be open to serve a client
@constraint(model, open_facility[i in 1:m, j in 1:n], x[i, j] <= y[j]);
@constraint(model, capacity, x' * a .<= (q .* y));
@objective(model, Min, f' * y + sum(c .* x));


optimize!(model)
println("Optimal value: ", objective_value(model))

x_is_selected = isapprox.(value.(x), 1; atol = 1e-5);
y_is_selected = isapprox.(value.(y), 1; atol = 1e-5);

p = Plots.scatter(
    x_c,
    y_c;
    markershape = :circle,
    markercolor = :blue,
    label = nothing,
    markersize = 2 .* (2 .+ a)
)

Plots.scatter!(
    x_f,
    y_f;
    markershape = :square,
    markercolor = [(y_is_selected[j] ? :red : :white) for j in 1:n],
    markersize = q,
    markerstrokecolor = :red,
    markerstrokewidth = 2,
    label = nothing,
)

for i in 1:m, j in 1:n
    if x_is_selected[i, j]
        Plots.plot!(
            [x_c[i], x_f[j]],
            [y_c[i], y_f[j]];
            color = :black,
            label = nothing,
        )
    end
end
p