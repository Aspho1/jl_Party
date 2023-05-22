using NPFinancial

export Project
# workspace()
    # intrest<:Real
    # FirstCost<:Real
    # AnnualCost<:Real
    # SalvageValue<:Real
    # Life<:Real
    # Alternative(Label,intrest,FirstCost,AnnualCost,SalvageValue,Life)

    # function set_rank(nRank::Int)
    #     Rank=nRank
    # end

struct Project
    name::String
    initial_investment::Float64
    intrest::Float64
    SalvageValue::Float64
    duration::Int

    function calculatePW()
        PresentWorth = initial_investment 
    end
end

# function go()
#     v = B("A", 0.1, 100.0, 0.0, 0, 10)

#     v.calculatePW()   
# end

# go()

# struct FinancialProject
#     name::String
#     initial_investment::Float64
#     expected_return_rate::Float64
#     duration::Int
# end

# project = FinancialProject("Project A", 10000.0, 0.07, 5)