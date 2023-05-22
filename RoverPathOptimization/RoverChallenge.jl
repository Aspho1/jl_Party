using JuMP, HiGHS, Printf

export makeDistancesTable, ActualModel2, printDT

## 15 x 15 ft area

# DVs x1 and x2 are cylinders and roofs
# Name, X cord, Y cord, Max Visits 

function makeDistancesTable(info)
    distances = zeros(Float64, 8,8)

    for i_row in 1:8
        r = info[i_row,:]
        for i_col in 1:8
            c = info[i_col,:]
            distances[i_row, i_col] = sqrt((r[2]-c[2])^2 + (r[3]-c[3])^2)
        end
        
    end
    return distances
end

# println(distances)
function printDT(distances)
    for startp in 1:8
        for endp in 1:8
            @printf "%5.2f, " distances[startp,endp]
        end
        println()
    end
end
# println(distances)
#
# Considered recursion but went with the big stick instead.
# function rec(start_position, end_position, B1C, B1R, B2C, B2R)
#     if (B1C == 2 & B1R == 1 & B2C == 2 & B2R == 1)
#         return "DONE"
#     else
#         if start_position[1] == "S"
#         elseif position[1] == "B"
#         end
#     end
# end
# Must do 2 Cx -> Bx
# Must do 1 R  -> Bx
# Must begin at S
# Cannot go to a B or R more times than allowed 

# States are Position, B1C, B1R, B2C, B2R

# Begin at S
# From S, can go to C1 C2 C3 C4 or R.
    # No value added, only cost.
#   From C can go B1 or B2
        # Adds B1C or B2C value, adds cost
#   From R can go B1 or B2
        # Adds B1R or B2R value, adds cost
#   From B1 and B2, can go to C1 C2 C3 C4 R.

# Formulating this as an IP
# Binary variables with state


# Do I need another variable with each of the twelve states (moves) needed to be made? I think so...
function ActualModel(distances)
    m = Model(HiGHS.Optimizer)
    @variable(m, x[1:8,1:8,1:12], Bin)

    for pos in 1:5
        @constraint(m, sum(x[pos, :, :]) == 1) # Only one cylinder available per location
    end

    @constraint(m, sum(x[6, :, :]) == 2) # Only two roofs available
    # @constraint(m, sum(x[7, :, :]) == 2) # Must leave B1 twice to get materials
    # @constraint(m, sum(x[8, :, :]) == 2) # Must leave B2 twice to get materials

    @constraint(m, sum(x[1,2:5]) == 1) # Must start at start and goto C


    for b in 7:8
        @constraint(m, sum(x[2:5,b]) == 2) # Two cylinders must be included in each B
        @constraint(m, x[6,b] == 1) # One roof per B
    end

    @objective(m, Min, sum(x[spos,epos]*distances[spos,epos] for spos in 1:8 for epos in 1:8))

    optimize!(m)

    solution_summary(m,verbose=true)
    # @constraint(m, sum(x[2:5,7]) == 2) # If at C or R, must go to B
    # @constraint(m, sum(x[2:5,8]) == 2) # If at C or R, must go to B
end


function ActualModel2(distances)
     m = Model(HiGHS.Optimizer)

    @variable(m, x[1:8,1:8,1:12], Bin) #Start Position, End Position, Turn)

    for pos in 1:5
        @constraint(m, sum(x[pos, :, :]) == 1) # Only one cylinder available per location
    end
    

    for turn in 1:12
        @constraint(m, sum(x[:,:,turn]) == 1) # Only one move per turn
        if turn == 1
            @constraint(m, sum(x[1,:,turn])== 1) # Must begin at S
        else
            for s in 1:8
                @constraint(m, sum(x[s, s, turn]) == 0)
                @constraint(m, sum(x[s, :, turn]) == sum(x[:, s, turn-1])) # Must begin where you last finished
            end

        end
        # @constraint(m,  ) Cannot go to R until two Cs are on a B
        for b in 7:8
            @constraint(m,2*x[6, b, turn] <= sum(x[2:5, b, 1:turn]))

        end
        # @constraint(m,2*x[:, 6, turn] <= sum(x[2:5, ]))
    end

    for b in 7:8
        @constraint(m, sum(x[2:5,b,:]) == 2)  # Two Cs per building
        @constraint(m, sum(x[6,b,:]) == 1) # one R per building
    end


    @objective(m, Min, sum(x[i, j, k]*distances[i,j] for i in 1:8 for j in 1:8 for k in 1:12))
    optimize!(m)

    # println(solution_summary(m,verbose = true))
    for k in 1:12
        for i in 1:8
            for j in 1:8
               if value(x[i,j,k]) > 0
                @printf "On turn %2d, move from %d to %d (distance is %6.2f)\n" k i j distances[i,j]
                # @printf " %d, %d, %d\n" i j k
               end
            end
        end
    end
    @printf "The total distance is %5.2f feet\n" objective_value(m) 
    return m
end

# ActualModel2(distances)
