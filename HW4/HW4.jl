
months = 1:4
demand = [1, 3, 2, 4]
A = 3
P = 1
h = 0.5
U = 5 #(is 5, julia doesn't use 0 for indexing)
Iₘ = 5 # (Is 4, julia doesn't use 0 for indexing)
Iₒ = 3
# Stage, State (Month, Onhand)
# Max Onhand is 4 units
x = zeros(Int64,4,Iₘ)

# min cost
f = zeros(Float64,4,Iₘ)
# c::Array;
# Memo::Dict{Int64, BigInt} = Dict(0=>0, 1=>1)

# function dp(fibn::Int,Memo::Dict)
#     # println(Memo)
#     if fibn <= 1
#         return fibn
#     elseif !(fibn ∈ keys(Memo))
#         Memo[fibn] =  dp(fibn-1, Memo) + dp(fibn-2, Memo) 
#     end
#     return values(Memo[fibn])
# end 

# for i in 1:10
#     println(i, ", ",dp(i,Memo))
# end

function c(z)
    if z == 0
        return 0
    else
        return A + P*z
    end
end

# x[1,1]=1

println(x)

function recu(month::Int, onhand::Int)
    println("FUNCTION CALL: ",month, " | ", onhand)
    if month == 4
        for i in 1:demand[month]
            produce = i - onhand - 1
            if produce <= 0
                f[month,i] = h*(onhand  + produce - demand[month])
                x[month,i] = 0
            else
                f[month,i] = c(produce) + h*onhand
                x[month,i] = 0
            end
        end
    elseif month != 1
        println("ELSEIF")
        for i in 1:U
            produce = i - onhand -1
            println(i)
            println(onhand  + produce - demand[month])
            println()
            if produce <= 0
                f[month,i] = h*(onhand  + produce - demand[month]) + recu(month+1, 1)
                x[month,i] = 0
            else
                f[month,i] = h*(onhand  + produce - demand[month]) + recu(month+1, onhand  + produce - demand[month] +1)
                x[month,i] = produce
            end
        end
        # return (demand[month] - onhand)
    else
        println("ELSE")
        for i in 1:U
            produce = i - Iₒ - 1
            println(produce)
            println(onhand  + produce - demand[month]+1)
            if produce <= 0
                f[month,i] = h*(onhand  + produce - demand[month]) + recu(month+1,1)
                x[month,i] = 0
            else
                f[month,i] = h*(onhand  + produce - demand[month]) + recu(month+1, onhand  + produce - demand[month])
                x[month,i] = produce
            end
        end        
    end
    # println(x)
    return f[month,onhand]

    
end


recu(1,Iₒ)
println(x)
for i in months
    println(i, " -> " , x[i,:])
end

println("f: ",f, ", ",sum(f))
# for i in months
    # println(min())