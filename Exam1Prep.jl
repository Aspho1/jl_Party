using JuMP
using HiGHS
using Printf

# A power plant has three boilers. If a given boiler is
# operated, it can be used to produce a quantity of steam (in
# tons) between the minimum and maximum given in Table
# 34. The cost of producing a ton of steam on each boiler is
# also given. Steam from the boilers is used to produce power
# on three turbines. If operated, each turbine can process an
# amount of steam (in tons) between the minimum and
# maximum given in Table 35. The cost of processing a ton
# of steam and the power produced by each turbine is also
# given. Formulate an IP that can be used to minimize the cost
# of producing 8,000 kwh of power.


# ["Turbine Number", "Minimum", "Maximum", "Kwh per Ton of Steam", "Processing Cost per Ton"]
   
# turbine1 = [1 300 600 4 2]
# turbine2 = [2 500 800 5 3]
# turbine3 = [3 600 900 6 4]


m = Model(HiGHS.Optimizer);
set_silent(m)
# Steam[Boilder, Turbine]
@variable(m, Steam[1:3,1:3] >= 0)

boilerCost = [ 10 8 6]

turbineCost = [2 3 4]
turbineEfficiency = [4 5 6]


# set_silent(m)

MaxVol= 1100

# Set boiler min and max steam
for j in 1:3
    @constraint(m, sum(Steam[1,j] for j in 1:3) >= 500)
    @constraint(m, sum(Steam[2,j] for j in 1:3) >= 300)
    @constraint(m, sum(Steam[3,j] for j in 1:3) >= 400)
    @constraint(m, sum(Steam[1,j] for j in 1:3) <= 1000)
    @constraint(m, sum(Steam[2,j] for j in 1:3) <= 900)
    @constraint(m, sum(Steam[3,j] for j in 1:3) <= 800)
end

# Set turbine min and max steam
for i in 1:3
    @constraint(m, sum(Steam[i,1] for i in 1:3) >= 300)
    @constraint(m, sum(Steam[i,2] for i in 1:3) >= 500)
    @constraint(m, sum(Steam[i,3] for i in 1:3) >= 600)
    @constraint(m, sum(Steam[i,1] for i in 1:3) <= 600)
    @constraint(m, sum(Steam[i,2] for i in 1:3) <= 800)
    @constraint(m, sum(Steam[i,3] for i in 1:3) <= 900)
end


@constraint(m, sum(turbineEfficiency[j]*Steam[i,j] for j in 1:3 for i in 1:3) == 8000)
# @constraint(m,Steam[1,3] >= 510)
# set Energy requirement


@objective(m, Min, sum(Steam[i,j]*(turbineCost[j] + boilerCost[i]) for j in 1:3 for i in 1:3))

println(m)
optimize!(m)
# println(solution_summary(m,verbose=true))\
println(" ---- Optimal Solution ---- ")
@printf "z  =  %f \n" objective_value(m)

println("Turbine  |     1     2     3")
println("---------+------------------")
for i in 1:3
    print("Boiler ", i, " | ")
    for j in 1:3
        @printf "%5i" value(Steam[i,j]) 
    end
    println()
end

