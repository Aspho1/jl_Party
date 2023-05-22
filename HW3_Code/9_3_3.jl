using JuMP
using HiGHS

m = Model(HiGHS.Optimizer);
set_silent(m)

# @variable(m, 0<= x1, Int)
# @variable(m, 0<= x2, Int)

@variable(m, 0<= x1)
@variable(m, 0<= x2)


@constraint(m,3*x1 + 2*x2 <= 10)
@constraint(m,  x1 + 4*x2 <= 11)
@constraint(m,3*x1 + 3*x2 <= 13)


@constraint(m, x2 <= 2)
# @constraint(m, x1 >= 6)
# @constraint(m, x2 >= 2)

@objective(m, Max, 4*x1 + 5*x2);

optimize!(m);
println(m)

println(" -- Optimal Solution -- ")
println("Z = ", objective_value(m))
println("x1: ", value(x1))
println("x2: ", value(x2))