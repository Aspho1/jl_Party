using JuMP
using HiGHS

# Sources = ["L1" "L2"]
# Sinks = ["B1" "B2"]

# #     L1 L2 B1 B2
# # L1  0  3  4  2 
# # L2  3  0  2  5
# # B1  4  2  0  1
# # B2  2  5  1  0
# Dists = [[0 3 4 2]
#         [3 0 2 5]
#         [4 2 0 1]
#         [2 5 1 0]]

# print(Dists[1:4])

m = Model(HiGHS.Optimizer)

@variable(m, x1 >= 0, Bin)
@variable(m, x2 >= 0, Bin)
@variable(m, x3 >= 0, Bin)
@variable(m, x4 >= 0, Bin)

dv = [x1 x2 x3 x4]
cost = [3 5 2 4];
npv = [5 8 3 7];

@objective(m, Max, sum(dv[i] * npv[i]))
@constraint(m, 3x1 + 5x2 + 2x3 + 4x4 <= 6)
optimize!(m);


# println(solution_summary(m))
println("Solution: ")
println("x1 = ", JuMP.value(x1))
println("x2 = ", JuMP.value(x2))
println("x3 = ", JuMP.value(x3))
println("x4 = ", JuMP.value(x4))
println("------ Objective Value ------")
println("Z = ",JuMP.objective_value(m))

# print_bridge_graph()