using LinearAlgebra

I = [1 0 0 0; 0 0 1 0; 0 0 1 0; 0 0 0 1]
# Q = [0.8 0.1 0.05; 0.1 0.6 0.1; 0.1 0.1 .5]

# A = (I - Q)
# println(A^(-1))

## Table of successes and failures 
#      1  2  3  4
# 1 [ .1  0  0  0 ]
# 2 [  0 .2  0  0 ]
# 3 [  0  0 .5  0 ]
# 4 [  0  0  0  1 ]

# This P is holding chance of success and failure

# Z = [ .1  .9  0  0;  0 .2  .8  0; 0  0 .5  .5; 0  0  0  1 ]

# Lets make a P That only holds failure
# Pi_Vector = zeros(1,5)
# Pi_Vector[5] = 1

P = [.1 .9 0 0; .2 0 .8 0; .5 0 0 .5; .1 .9 0 0]
println(P^50000)

println("\n")

Q = I - P'
println(Q)
# Add an additional constraint by augmenting P
P_augmented = vcat(Q, ones(1, size(P, 1)))
println("\n",P_augmented,"\n")

# Define the right-hand side of the equation
b = vcat(zeros(size(P, 1)), [1.0])
println("\n",b,"\n")
# Solve the linear system to find the steady-state probabilities
pi_vector = P_augmented \ b
# println(pi_vector)
# Create the steady-state probability transition matrix
steady_state_matrix = repeat(pi_vector', size(P, 1), 1)

println("\nSteady-state probability row vector:")
println(pi_vector)

println("\nSteady-state probability transition matrix:")
println(steady_state_matrix)
## Table of failures 
#     1  2  3  4
# 1 [.1 .9  0  0 ]
# 2 [.2  0 .8  0 ]
# 3 [.5  0  0 .5 ]
# 4 [ 1  0  0  0 ]
# 5 [ ]

# Cost_Fail = 1000
# Cost_new = 500
# println(P)
# println()


# Z[5,:] = Pi_Vector

# println(Z)

# println(Pi_Vector)


# Pi_Vector = transpose(Pi_Vector)*Z




# Plan to replace a machine at the beginning of its fourth month of operation.
# Plan to replace a machine at the beginning of its third month of operation.
# Plan to replace a machine at the beginning of its second month of operation.

# PV = Matrix{Float64}(undef,2,1)

# T = [.95 .05; .2 .8]



# T*PV