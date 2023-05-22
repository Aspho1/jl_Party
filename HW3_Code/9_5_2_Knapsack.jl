using JuMP
using HiGHS
using DataFrames

m = Model(HiGHS.Optimizer);
# set_silent(m)

MaxVol= 1100
@variable(m, x[1:5], Bin)
df = DataFrame( "Item" => ["Bedroom set", "Dining room set", "Stereo", "Sofa", "TV set"],
                "Value" => [60, 48, 14, 31, 10],
                "Volume" => [800, 600, 300, 400, 200])


@constraint(m, sum(df.Volume[i] * x[i] for i in 1:5) <= MaxVol)
@objective(m, Max, sum(df.Value[i] * x[i] for i in 1:5))

println(m);
optimize!(m)
# println(solution_summary(m))
items_chosen = [df.Item[i] for i in 1:5 if value(x[i]) > 0]
println("Items to bring: ")
for i in 1: length(items_chosen)
    println(items_chosen[i])
end
