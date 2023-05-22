using JuMP
using HiGHS

m = Model(HiGHS.Optimizer);
set_silent(m)
@variable(m, AB, Bin)
@variable(m, AC, Bin)
@variable(m, BC, Bin)
@variable(m, BD, Bin)
@variable(m, CD, Bin)
@variable(m, DE, Bin)
@variable(m, DF, Bin)
@variable(m, DG, Bin)
@variable(m, EF, Bin)
@variable(m, FG, Bin)

cost = [72 85 71 50 63 77 39 92 74 89]
pairs = transpose([AB AC BC BD CD DE DF DG EF FG])

@constraint(m, AB + AC <= 1)
@constraint(m, AB + BC + BD <= 1)
@constraint(m, AC + BC <= 1)
@constraint(m, BD + CD + DE + DF + DG <= 1)
@constraint(m, DE + EF <= 1)
@constraint(m, DF + EF + FG <= 1)
@constraint(m, DG + FG <= 1)
@constraint(m, AB + AC + BC + BD + CD + DE + DF + DG + EF + FG <= 2)

@objective(m, Max, sum(pairs[i]*cost[i] for i in 1:10));

optimize!(m);
println(m)

println(" -- Optimal Solution -- ")
println("Z = ", objective_value(m))
for i = 1: 10
    println(pairs[i], " = ", cost[i],": " , value(pairs[i]))
end