using JuMP

import DataFrames


# Define the model
m = Model(Clp.Optimizer)
sRange = 1:3
dRange = 1:4
# Define the decision variables
@variable(m, x[sRange, dRange] >= 0)

# Define the supply and demand constraints
supply = [35, 50, 40]
demand = [40, 20, 30, 30]

for i in sRange
    @constraint(m, sum(x[i,j] for j in dRange) == supply[i])
end
for j in dRange
    @constraint(m, sum(x[i,j] for i in sRange) == demand[j])
end

# Define the objective function
@objective(m, Min, sum(10*x[i,j] + 5*x[i,j] for i in sRange, j in dRange))

print(m)
# Solve the optimization problem

# optimize!(m)

# Print the optimal solution
# println("Optimal solution:")
