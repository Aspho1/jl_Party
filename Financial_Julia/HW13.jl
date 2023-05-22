using NPFinancial

function p1()
    FixedAnnual = 675000


    VariableUnit = 290
    AnnualUnits = 4400

    TC = FixedAnnual + VariableUnit* AnnualUnits
    println(TC, ",  ", TC/AnnualUnits)
end 


function p2()
    FC = 40000
    QrtyFee = 1000
    QrtySavings = 13500

    t = nper(0.08,(QrtySavings-QrtyFee), -FC)
    t
end

function p3()
    # Two membrane systems are under consideration for treating cooling tower blowdown to reduce its volume.
    # A low-pressure seawater reverse osmosis (SWRO) system will operate at 500 psi and produce 800,000 gallons of permeate per day.
    # It will have a fixed cost of $570 per day and an operating cost of $530 per day. 
    # A higher-pressure SWRO system operating at 800 psi will produce 950,000 gallons per day at a cost of $1,100 per day. 
    # The fixed cost of the high-pressure SWRO system will be only $311 per day because fewer membranes will be required.
    
    #How many gallons of blowdown water will require treatment each day for the two systems to break even?


    FC1 = 570
    OC1 = 530
    g1 = 800000
    lowp = g1 * (FC1+OC1)

    FC2 = 1100 
    OC2 = 311
    g2 = 950000
    highp = g2* (FC2+OC2)

    lowp, highp, highp/lowp



end

function p4()
    Prod = 40000
    salesp = 66
    FixedProdCost = 215000
    VarProdCost_p_y = 1660000
    VariableSalesExpenses_p_y = 93000
    VarProdCost = VarProdCost_p_y/Prod
    VariableSalesExpenses = VariableSalesExpenses_p_y/ Prod
    


    # costs = -FixedProdCost -VarProdCost - VariableSalesExpenses

    # costs/salesp

    # Need Revenue to equal cost...\

    # TC = FixedProdCost + X * (VarProdCost + VariableSalesExpenses)
    # FixedProdCost + X * (VarProdCost + VariableSalesExpenses) = salesp*X
    # FixedProdCost = X*(salesp - (VarProdCost + VariableSalesExpenses))
    # TR = salesp*X
    println(VarProdCost + VariableSalesExpenses)
    println(salesp - VarProdCost + VariableSalesExpenses)
    (1000000 + FixedProdCost)/(salesp - ( VarProdCost + VariableSalesExpenses))
    # TP = TR - TC
    # (Prod*salesp) - (FixedProdCost + Prod * (VariableSalesExpenses + VarProdCost))
end

function p7()
    V = 275000
    MonthlyC = 675
    monthlyi = 0.0075

    nper(monthlyi,MonthlyC, V)
end




# p1()
# p2()
# p3()
# p4()


p7()