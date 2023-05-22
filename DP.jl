using JuMP
using HiGHS
# using Plots

# 4) The number of crimes in each of a city’s three police
# precincts depends on the number of patrol cars assigned to
# each precinct (see Table 11). Five patrol cars are available.
# Use dynamic programming to determine how many patrol
# cars should be assigned to each precinct.



# T A B L E 11
# Precinct / N   0   1   2   3   4   5
# 1             14  10  7   4   1   0
# 2             25  19  16  14  12  11
# 3             20  14  11   8  6   5

crimes = [14 10 7 4 1 0;
          25 19 16 14 12 11;
          20 14 11 8 6 5]

precincts = [1, 2, 3]


function IPSolve(crimes)
    m = Model(HiGHS.Optimizer)

    @variable(m,x[1:3,1:6], Bin)

    for i in 1:3
        @constraint(m, sum(x[i,j] for j in 1:6) == 1)
    end
    @constraint(m, sum(x[i,j]*(j-1) for j in 1:6 for i in 1:3) == 5)


    @objective(m, Min, sum(x[i,j]*crimes[i,j] for i in 1:3 for j in 1:6)) # + crimes[2,x2] + crimes[3,x3] 


    optimize!(m)

    println(solution_summary(m,verbose=true))
end

function get_min(stage, state, MaxWeight)
    if stage == 3
        
    end
    return x[stage,state] + min([x[stage+1, MaxWeight-state]])
end

function DPSolve(crimes)
    ans = [[-1 for _ in 1:6] for _ in 1:3]
    println(ans)
end

DPSolve(crimes)