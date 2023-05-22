using JuMP
using HiGHS
using Formatting

R = length(box)
m = Model(HiGHS.Optimizer);
set_silent(m)
@variable(m, 0 <= x[1:R], Int)
# @variable(m, 0 <= x2, Int)
# @variable(m, 0 <= x3, Int)
# @variable(m, 0 <= x4, Int)
# @variable(m, 0 <= x5, Int)
# @variable(m, 0 <= x6, Int)
# @variable(m, 0 <= x7, Int)


cost = [1033 1030 1026 1024 1019 1018 1017]
# box = [x1 x2 x3 x4 x5 x6 x7]
demand = [400 300 500 700 300 400 200]

for i in 1:R
    @constraint(m, sum(x[1:i]) >= sum(demand[1:i]))
end
# @constraint(m, x1 >= 400)
# @constraint(m, x1 + x2 >= 700)
# @constraint(m, x1 + x2 + x3 >= 1200)
# @constraint(m, x1 + x2 + x3 + x4 >= 1900)
# @constraint(m, x1 + x2 + x3 + x4 + x5 >= 2100)
# @constraint(m, x1 + x2 + x3 + x4 + x5 + x6 >= 2500)
# @constraint(m, x1 + x2 + x3 + x4 + x5 + x6 + x7 >= 2700)

@objective(m,
Min, 
sum(cost[i]*transpose(box[i]) for i in 1:R));

optimize!(m);
println(m)

println(" -- Optimal Solution -- ")
printfmtln("Z = {:d} ", objective_value(m))
for i = 1: R
    println(box[i], " = ", cost[i],": " , value(box[i]))
end