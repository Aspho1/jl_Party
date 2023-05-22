using JuMP
using HiGHS
using Formatting


cost = [1033 1030 1026 1024 1019 1018 1017]
demand = [400 300 500 700 200 400 200]


R = length(cost)
m = Model(HiGHS.Optimizer);
set_silent(m)
@variable(m, 0 <= x[1:R], Int)
for i in 1:R
    @constraint(m, sum(x[1:i]) >= sum(demand[1:i]))
end

@objective(m,
    Min, 
    sum(cost[i]*x[i] for i in 1:R)
    );

optimize!(m);
println(m)

println(" -- Optimal Solution -- ")
printfmtln("Z = {:d} ", objective_value(m))
println("Variable | Cost | Optimal Value")
for i = 1: R
    println("  ",x[i], "   | ", cost[i]," |    " , value(x[i]))
end