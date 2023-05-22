

function p18_4_2(w::Int)
    Items = zeros(Int64,1,3)
    Benefit = [5, 4, 2]
    Weight = [4, 3, 2]
    function subF(item,subw)
        if item == 4
            return 0
        else
            return maximum([Benefit[item]*Items[item] + subF(item+1, subw-Weight[item]*Items[item])])
        end
        # println(Items[item])
        # Items[item] = subw/Weight[item]
        # Z = Items*Benefit
        # println("Total Benefit: ", Z[1])
    end
    

    return subF(1, w)
    println("  Items: ", Items)
    println(" Weight: ", Weight)
    println("Benefit: ", Benefit)
    
end

println(p18_4_2(8))

