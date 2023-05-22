using JuMP
using Formatting
import HiGHS

# Julia has a Mathmatical Optimization package JuMP. 

# I am fed up with LINDO/LINGO and switching to software that:
#   1. Is opensouce 
#   2. Has documentation 
#   3. Is really fast (not Python or Java)
#   4. To reiterate, isn't lindo. 

#HiGHS is a specific solver
m = Model(HiGHS.Optimizer);

# Setting M and lowering verbosity of output
M = 30001; 
set_silent(m);

# Set variable names, bounds and types
@variable(m, 0 <= x1, Int)
@variable(m, 0 <= x2, Int)
@variable(m, r1, Bin)
@variable(m, r2, Bin)
@variable(m, y, Bin)


# Relaxed LP Vars.
# @variable(m, 0 <= x1)
# @variable(m, 0 <= x2)
# @variable(m, r1 >= 0)
# @variable(m, r2 >= 0)
# @variable(m, y >= 0)


# Maximize the profit from the houses, x1, appartments, x2 
# while accounting for the cost of marina, r1, and tennis, r2.
# @objective(m, Max, 6000*x1 + 8000*x2 - 1200000*r1 - 2800000*r2)
@objective(m, Max, 6000*x1 + 8000*x2 - 1200000*r1 - 2800000*r2)
# Total units is leq 10000
@constraint(m, x1 + x2 <= 10000)

# Either a Marina or a tennis complex is built.
@constraint(m, r1 + r2 == 1)

# If a marina is built, 3x the apartments must be built
@constraint(m, -x1 + 3*x2 <= M*y)

# If !y: r1 must be <= 0 when the tennis courts are built, forcing r2 to take 1.
@constraint(m, r1 <= M*(1-y))

# Sub problem constraints
# @constraint(m, x2 >= 10000)
# @constraint(m, y<=0)

println("------ Objective Function and Constraints ------")
print(m);
JuMP.optimize!(m);

# Printing the optimal solutions obtained
println("------ Optimal Solutions ------")
println("x1 = ", JuMP.value(x1))
println("x2 = ", JuMP.value(x2))
println("r1 = ", JuMP.value(r1))
println("r2 = ", JuMP.value(r2))
println("y = ", JuMP.value(y))
println("------ Objective Value ------")
printfmtln("{}{:d}","Z = ",JuMP.objective_value(m))
