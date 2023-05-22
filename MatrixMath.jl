using LinearAlgebra
using Printf
using Statistics
using Distributions
# using Distributions

# P = [.95 .05; .7 .3]
# Pt = [.95 .07; .05 .3]
# println(P)

# # Pt = transpose(P)
# vals = eigvals(P)
# vecs = eigvecs(P)

# println(vals)
# println(vecs)


# urban
# rural
# suburban
# p = [.15 .05 .06]
#     U   R   S
# U      .05  .15   
# R  .04      .06
# S  .06 .04

# P = [.8 .05 .15; .04 .9 .06; .06 .04 .9]
# for i in 1:3
#     println(P[:,i])
# end

# q = [1 0 0]

# partA = q*P^2

# @printf "\nUrban: %f" partA[1]
# @printf "\nRural: %f" partA[2]
# @printf "\nSuburban: %f" partA[3]

# q1 = [.4 .25 .35]

# partB = q1*P^2

# @printf "\nUrban: %f" partB[1]
# @printf "\nRural: %f" partB[2]
# @printf "\nSuburban: %f" partB[3]


function P15_3_8()
    # three balls
    # two containers
    # in each period a ball is randomly chosen and switched to the other containers

    # A) find (in the steady state) the fraction of te time a container will contain 0 1 2 3 balls

    # B) If container 1 contains no balls, on the average how many perriods will go by before it again contains no balls>
    #   Special case of Ehrenfest Diffusion Model, which models diffusion through a biological membrane)
    nballs = 3
    ncontainers = 2
    states = [0 1 2 3]

    # Total balls is always three, each stage a ball is randomly selected 
    # b_answer::Matrix{Float64} = Matrix{FLoat64}()

    # Probability from left state to top state 
    #        (3-0)  (2-1)   (1-2)   (0-3)      
    # (3-0)    0      1       0       0   
    # (2-1)   1/3     0      2/3      0
    # (1-2)    0     2/3      0      1/3
    # (0-3)    0      0       1       0

    P = [0 1 0 0; 1/3 0 2/3 0; 0 2/3 0 1/3; 0 0 1 0]
    P_replaced = [0 1 0 0; 1 1 1 1; 0 2/3 0 1/3; 0 0 1 0]

    # b = Matrix({Missing})
    b = [0; 1; 0; 0]

    println(P_replaced\b)

    # LinearAlgebra.r


    # P_replaced^50000000
    P^50000000
    
end


# P15_3_8()



