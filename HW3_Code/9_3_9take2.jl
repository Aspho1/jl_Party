using JuMP
using HiGHS
# A
# m = Model(HiGHS.Optimizer);
# set_silent(m)
# M = 1270
# demand = [220 280 360 140 270]
# R = length(demand)
# @variable(m, x[1:R] >= 0, Int)
# @variable(m, y[1:R], Bin)
# @variable(m, I1 = demand[1])
# @variable(m, I[1:R-1], Int)

# for i in 1:R
#     @constraint(m, sum(x[1:i]) >= sum(demand[1:i]))
#     @constraint(m,x[i] <= y[i]*M)
#     # println(m)
# end

# for i in 1:R-1
#     println(demand[i], x[i])
#     if i == 1
#         I[i] = demand[i] - x[i]
#     else
#         I[i] = I[i-1] + demand[i] - x[i]
#     end
# end
# println(I)
# @objective(m, Min, sum(2 * x[i] + 250 for i in 1:R));

# optimize!(m);
# println(m)

# println(" -- Optimal Solution -- ")
# println("Z = ", objective_value(m))
# for i in 1:R
#     println(i, " : ", value(y[i]),": " , value(x[i]))
# end

# A
# m = Model(HiGHS.Optimizer);
# set_silent(m)
# M = 1270
# demand = [220 280 360 140 270]
# R = length(demand)
# @variable(m, x[1:R] >= 0, Int)
# @variable(m, y[1:R], Bin)
# @variable(m, I1 = demand[1])
# @variable(m, I[1:R-1], Int)

#B
m = Model(HiGHS.Optimizer);
set_silent(m)
M = 1271
demand = [220 280 360 140 270]
R = length(demand)
@variable(m, x[1:R] >= 0, Int)
@variable(m, y[1:R], Bin)
# @variable(m, I1 = demand[1])
# @variable(m, I[1:R-1], Int)

for i in 1:R
    @constraint(m, sum(x[1:i]) >= sum(demand[1:i]))
    @constraint(m,x[i] <= y[i]*M)
    # println(m)
end

@objective(m, Min, sum(2 * x[i] + 250*y[i] for i in 1:R));

optimize!(m);
println(m)

println(" -- Optimal Solution -- ")
println("Z = ", objective_value(m))
for i in 1:R
    println(i, " : ", value(y[i]),": " , value(x[i]))
end

# println(solution_summary(m))