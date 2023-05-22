using JuMP
using HiGHS
using Printf


function madonna()
    m = Model(HiGHS.Optimizer)
    songs = 1:8
    sides = 1:2

    ballads = [1, 3, 5, 8]
    hits = [2, 4, 6, 8]
    M = 10
    # types = ["Ballad", "Hit", "Ballad", "Hit", "Ballad", "Hit", "", "Ballad and Hit"]

    @variable(m, x[songs,sides], Bin)
    @variable(m, r1, Bin)
    @variable(m, r2, Bin)
    
    for so in songs
        @constraint(m,x[so,1] + x[so,2] == 1) # each song can only appear on one side.
    end

    for si in sides
        @constraint(m, x[1,si] + x[3,si] + x[5,si] + x[8,si] == 2) # Each side j must have 2 ballads

        if si == 1
            @constraint(m,x[2, si] + x[4,si]+ x[6,si] + x[8,si] >= 3) # Side 1 must have 3 or more hits
            # @constraint(m,sum(x[h, si] for h in hits) >= 3) # Side 1 must have 3 or more hits
        end
        # @constraint(m, sum(x[b,si] for b in ballads) == 2) # Each side j must have 2 ballads
    end

    # println(all_constraints(model=m))
    # 



    # @constraint(m, x[5,1] <= M*r1)
    # @constraint(m, x[6,1] <= M*(1-r1))
    # @constraint(m, x[2,1] + x[4,1] <= M*r2)
    # @constraint(m, x[5,2] <= (1-r2))
    optimize!(m)
    for si in sides

        @printf "Side %d songs\n" si
        for so in songs 
            if value(x[so,si]) >= 1
                println(so)


            else
                println(so, " X")
            end
        end
    end



    return m



end
madonna()
# println(solution_summary(mad, verbose = true))
println()

