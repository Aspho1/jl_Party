using JuMP
using HiGHS

m = Model(HiGHS.Optimizer);
set_silent(m)

# @variable(m, 0<= x1, Int)
# @variable(m, 0<= x2, Int)

@variable(m, 0 <= x1, Int)
@variable(m, 0 <= x2)

@constraint(m, x1 + 5*x2 >= 8)
@constraint(m, x1 + 2*x2 >= 4)


# @constraint(m, x1 <= 0)
# @constraint(m, x1 >= 6)
# @constraint(m, x2 >= 2)

@objective(m, Min, 3*x1 + x2);

optimize!(m);
println(m)

println(" -- Optimal Solution -- ")
println("Z = ", objective_value(m))
println("x1: ", value(x1))
println("x2: ", value(x2))