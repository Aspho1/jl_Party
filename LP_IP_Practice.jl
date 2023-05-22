using JuMP
using HiGHS

function p1()


    m = Model(HiGHS.Optimizer)
    
    cost = [3 2 3; 10 5 8; 1 3 10]
    supply = [50 70 20]
    demand = [50 60 30]

    @variable(m,x[1:3,1:3] >= 0)

    for wh in 1:3
        @constraint(m,sum(x[wh,1:3]) <= supply[wh])
    end
    for mkt in 1:3
        @constraint(m,sum(x[1:3,mkt]) == demand[mkt])
    end

    @objective(m, Min, sum(x[i,j]*cost[i,j] for i ∈ 1:3 for j ∈ 1:3))
    optimize!(m)
    solution_summary(m,verbose=true)
    

end


function dpManager()
    N_tasks = 10
    Y = rand(Int,10)
    println(Y)
    DP(Y,2)

end

function DP(y,k)
    return k-u


end

xs=[1,2]; f(xs...)

# dpManager()

# p1()