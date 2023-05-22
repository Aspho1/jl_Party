using JuMP
using HiGHS
using Printf

# A Sunco oil delivery truck contains five compartments,
# holding up to 2,700, 2,800, 1,100, 1,800, and 3,400 gallons
# of fuel, respectively. The company must deliver three types
# of fuel (super, regular, and unleaded) to a customer. The
# demands, penalty per gallon short, and the maximum allowed
# shortage are given in Table 29. Each compartment of the
# truck can carry only one type of gasoline. Formulate an IP
# whose solution will tell Sunco how to load the truck in a way
# that minimizes shortage costs.

m = Model(HiGHS.Optimizer)
set_silent(m)
compartments = [2700 2800 1100 1800 3400] # size Gal
gas_types = ["Super"  "Regular" "Unleaded"]
demand = [2900 4000 4900]
penalty_per_short = [10 8 6]
shortage = [500 500 500]

M = 500001
# let Gij denote gallons of fuel where i is fuel type, j is tank
@variable(m, gallons_of_fuel[i = eachindex(gas_types), j = eachindex(compartments)] >= 0, integer = true, container=Array)

# let Bij denote existence of fuel where i is fuel type, j is tank
@variable(m, existence_of_fuel[eachindex(gas_types), eachindex(compartments)], binary = true, container=Array)
# Shortage (DVs)
@variable(m, shortage_of_fuel[eachindex(gas_types)] >= 0, integer = true, container=Array)

# limit each compartment to one type of gas
for j in eachindex(compartments)
    @constraint(m,sum(existence_of_fuel[1:length(gas_types),j]) <= 1)
    # @constraint(m,sum(gallons_of_fuel[1:length(gas_types),j]) <= compartments[j])
    for i in eachindex(gas_types)
        @constraint(m, gallons_of_fuel[i,j] <= existence_of_fuel[i,j]*compartments[j])
    end
end

# Must meet demand

for i in eachindex(gas_types)
    # @constraint(m,sum(gallons_of_fuel[i, 1:length(compartments)]) >= demand[i] - cap[i])
    @constraint(m,shortage_of_fuel[i] == demand[i] - sum(gallons_of_fuel[i,j] for j in eachindex(compartments)))
    @constraint(m,shortage_of_fuel[i] <= 500)
end
# @constraint(m, shortage_of_fuel[1] <= 0)

@objective(m, Min, sum(shortage_of_fuel[i] * penalty_per_short[i] for i in eachindex(gas_types)))
optimize!(m)

println(" ---- Optimal Solution ---- ")
@printf "z  =  %d\n" objective_value(m)
# for g in gallons_of_fuel
#     @printf "%s  =>  %d \n" rpad(g,6) value(g)
# end

# for b in existence_of_fuel
#     @printf "%s  =>  %d \n" rpad(b,6) value(b)
# end
# for e in shortage_of_fuel
#     @printf "%s  =>  %d \n" rpad(e,6) value(e)
# end
println("          Var         |  Binary  |  Gallons  |  Shortage")
for gas in eachindex(gas_types)
    for comp in eachindex(compartments)
        #   
        @printf " %s |   %3i    | %7i   | %6d \n" gallons_of_fuel[gas,comp] value(existence_of_fuel[gas,comp]) value(gallons_of_fuel[gas,comp]) value(shortage_of_fuel[gas])
        # gallons_of_fuel[gas,comp], "  |  ", lpad(value(existence_of_fuel[gas,comp]),6),"  |  ", lpad(value(gallons_of_fuel[gas,comp]),7), "  |  ", lpad(value(shortage_of_fuel[gas]),6))
    end
end