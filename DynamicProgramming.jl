# Using https://julia.quantecon.org/dynamic_programming/discrete_dp.html
using Graphs, SimpleWeightedGraphs, GraphPlot
using Printf
#       1   2   3   4   5   6   7       8   9   10
#  1    M   550 900 770 M   M   M       M   M   M
#  2    M   M   M   M   680 790 1050    M   M   M
#  3    M   M   M   M   580 760 660     M   M   M
#  4    M   M   M   M   510 700 830     M   M   M
#  5    M   M   M   M   M   M   M       610 790 M
#  6    M   M   M   M   M   M   M       540 940 M
#  7    M   M   M   M   M   M   M       790 270 M
#  8    M   M   M   M   M   M   M       M   M   1030
#  9    M   M   M   M   M   M   M       M   M   1390
# 10    M   M   M   M   M   M   M       M   M   M   
#
M = 99999
N = 10

# println(min(M,N))

S = [[1], [2, 3, 4], [5, 6, 7], [8, 9], [10]]

# dp

# nStages = length(S)
# # Left f_t(i) be the length of the shortest path from city i to Los Angeles (city 10), given that city i is a stage t city.
# # f = [1:nStages, 1:N]

# f = fill(M, (nStages-1,N-1))

# println(f)
weights = [
M   550 900 770 M   M   M       M   M   M;      # Stage 1 City
M   M   M   M   680 790 1050    M   M   M;      # Stage 2 Cities
M   M   M   M   580 760 660     M   M   M;
M   M   M   M   510 700 830     M   M   M;
M   M   M   M   M   M   M       610 790 M;      # Stage 3 Cities
M   M   M   M   M   M   M       540 940 M;
M   M   M   M   M   M   M       790 270 M;
M   M   M   M   M   M   M       M   M   1030;   # Stage 4 Cities
M   M   M   M   M   M   M       M   M   1390;
M   M   M   M   M   M   M       M   M   M       # Stage 5 City
]
# # println(weights)
# for i in 1:N
#     for j in 1:N-1
#         @printf " %s  " weights[i,j]
#     end
#     @printf "%s  \n" weights[i,N]
# end

# f[4,8] = weights[8,10]
# f[4,9] = weights[9,10]
# for s in nStages-1:-1:1
#     temp = M
#     for n in S[s] # The cities in the source stage
#         for c in S[s+1] # The cities in the sink stage
#             if (weights[n,c] < temp && weights[n,c] != M)
#                 temp = weights[n,c]
#             end
#             # f[s,n] = min


#         #     println(c,"  ", weights[n,c])
#         #     f[s,n] = weights[n,c]
#         # # println("n , c : ", c for c in 1:length(S[s]) )
#         end
#     f[s,n] = temp
#     end
# end

"""
    dp(Int::state, Int:: acti)

TBW
"""

Memo::Dict{Int64, BigInt} = Dict(0=>0, 1=>1)

function dp(fibn::Int,Memo::Dict)
    # println(Memo)
    if fibn <= 1
        return fibn
    elseif !(fibn ∈ keys(Memo))
        Memo[fibn] =  dp(fibn-1, Memo) + dp(fibn-2, Memo) 
    end
    return values(Memo[fibn])
end 


struct DDP{Costs, Stages}
    function DPP()
        println(Costs)
    end
end

# DPP()

# println(1000," --> ",dp(18596,Memo))





# println()
# for stage in 1:4
#     for city in 1:9
#         @printf "%d, " f[stage,city]
#     end
#     println()
# end
# println()
# println(f)


# println(weights[10,2])
G = SimpleWeightedDiGraph(10)
for i in 1:N
    for j in 1:N
        if weights[i,j] != M
            println("ij, weight | ", i, j,",  ", weights[i,j])
            add_edge!(G,i,j, weights[i,j] )
        end
    end
end


        # add_edge!(G,2,3)
        # add_edge!(G,2,4)
        # add_edge!(G,2,5)
        # add_edge!(G,6,7)
        # add_edge!(G,8,9)
        # add_edge!(G,2,9)
        # add_edge!(G,2,10)
# println(G)

println()
# println(weights)
println(enumerate_paths(dijkstra_shortest_paths(G,1),10))


show(G);
gplot(G,nodelabel=["New York",
    "Colombus",
    "Nashville", 
    "Lousville", 
    "Kansas City", 
    "Omaha", 
    "Dallas", 
    "Denver", 
    "San Antonio",
    "Los Angeles"],
    edgelinewidth=1)

# n = 2
# # S is the set of States
# S = [1:n]
# println(S)