using NPFinancial
using Printf
include("../Julia/Calc.jl")

# P_A(100,10,.1)
# pv(.01,10,100)





function p1()

    FC = [-1]
    A_A = 1030615.6
    S_A = 2465.29
    A = A_A + S_A + -1100000
    @printf "%d\n" A

end
p1()

function p4()
    Ci = -340000000
    A = -720000
    nTurf = 11
    cTurf = -820000
    nPaint = 9
    cPaint = -82000
    i = 0.06

    TurfAnnualCost = pmt(i,11,cTurf) 
    PaintAnnualCost = pmt(i,9,cPaint)
    @printf "%d , %d \n" TurfAnnualCost PaintAnnualCost 
    #
    answer = Ci +  (A + TurfAnnualCost + PaintAnnualCost)/i  
    @printf "%d " answer
end

function p5and6()
    # An electric switch manufacturing company is trying to decide between three different assembly methods.
    # Method A has an estimated first cost of $42,000, an annual operating cost (AOC) of $9,000, and a service life of 2 years.
    # Method B will cost $82,000 to buy and will have an AOC of $9,000 over its 4-year service life.
    # Method C costs $139,000 initially with an AOC of $4,000 over its 8-year life.
    # Methods A and B will have no salvage value, but Method C will have equipment worth 8% of its first cost.
    FC = [42000, 82000, 139000]
    AOC = [9000, 9000, 4000]
    SL = [2, 4, 8]
    SALV = [0, 0, 0.08* FC[3]]
    i = 0.11
    #Perform a FW analysis

    for j in 1:3
        @printf "FW_%d = %d\n" j fv(i,SL[j],AOC[j],FC[j])
    end
    println()
    for j in 1:3
        @printf "PW_%d = %d\n" j (FC[j] + P_A(AOC[j],i,SL[j]-1) + P_F(SALV[j],i,SL[j]))
        # @printf "PW_%d = %d\n" j pv(i,SL[j],AOC[j],FC[j])
    end
    



end

function p7()
    # A small strip-mining coal company is trying to decide whether it should purchase or lease a new clamshell. 
    # If purchased, the “shell” will cost $145,000 and is expected to have a $42,500 salvage value after 6 years. 
    # Alternatively, the company can lease a clamshell for only $13,000 per year, but the lease payment will have to be 
    # made at the beginning of each year. If the clamshell is purchased, it will be leased to other strip-mining companies 
    # whenever possible, an activity that is expected to yield revenues of $6,000 per year. 
    # If the company’s MARR is 10% per year, should the clamshell be purchased or leased on the basis of a future worth analysis? 
    # Assume the annual M&O cost is the same for both options.

    Cost = 145000
    SalvageV = 42500
    i ::Real = .1
    Years ::Int = 6

    #FW when purchased:
    @printf "The future worth when purchased is %d \n" (fv(i, Years,0 ,Cost) - fv(i,Years,6000,0) + SalvageV)
    
    #FW when leased
    @printf "The future worth when leased is %d" (fv(i, Years, 13000, 0,:begin))


end

function p8()
    # Compare the alternatives C and D on the basis of a present worth analysis using an 
    # interest rate of 8% per year 
    # and a study period of 10 years.

    # Alternative                       	           C 	        D
    # First Cost 	                               | $-36,000 	$-28,000
    # AOC, per Year 	                           | $-12,000 	$-6,000
    # Annual Increase in Operating Cost per Year   | $-800 	    $-900
    # Salvage Value                                | $13,000 	$800
    # Life, Years    	                           | 10 	    5
    FirstCost = [-36000, -28000]
    AOC = [-12000, -6000]
    AOC_G = [-800,-900]
    SV = [13000, 800]
    Life = [10,5]
    i = .08
    n = 10
    C = Array{Float64}(undef,11)
    D = Array{Float64}(undef,11)
    # D = [1:11,1]
    C[1] = FirstCost[1]
    D[1] = FirstCost[2]


    for j in 1:11
        C[j] += AOC[1] + AOC_G[1]*(j-1) 
        D[j] += AOC[2] + AOC_G[2]*((j-1)%5) 
        if j == Life[2]+1
            D[j] += (FirstCost[2]+SV[2])
        println(j,"  ==>  ", AOC_G[2]*((j-1)%5) )
        end

    end 
    C[11] += SV[1]
    D[11] += SV[2]

    PWc = npv(i,C[2:11]) + C[1]
    PWd = npv(i,D[2:11]) + D[1]


    println(C)
    println(D)
    @printf "The present worth of alternative C is %i \nand that of alternative D is %i." PWc PWd

    # _____ offers the lower present worth.
end


# p5and6()
# p7()



function practice()
    # Compare the alternatives C and D on the basis of a present worth analysis using an 
    # interest rate of 8% per year 
    # and a study period of 10 years.

    # Alternative                       	           C 	        D
    # First Cost 	                               | $-36,000 	$-28,000
    # AOC, per Year 	                           | $-12,000 	$-6,000
    # Annual Increase in Operating Cost per Year   | $-800 	    $-900
    # Salvage Value                                | $13,000 	$800
    # Life, Years    	                           | 10 	    5
    FirstCost = [-15000, -18000]
    AOC = [-3500, -3100]
    # AOC_G = [-800,-900]
    SV = [1000, 2000]
    Life = [6,9]
    i = .14
    n :: Int= 6*9/3 + 1
    println(n)
    A = Array{Float64}(undef,n)
    B = Array{Float64}(undef,n)
    # D = [1:11,1]
    A[1] = FirstCost[1]
    B[1] = FirstCost[2]


    for j in 1:n
        A[j] += AOC[1] 
        B[j] += AOC[2] 
        if mod((j-1),Life[1]) == 0
            B[j] += (FirstCost[2]+SV[2])
        end

    end 
    A[11] += SV[1]
    B[11] += SV[2]

    PWa = npv(i,A[2:11]) + A[1]
    PWb = npv(i,B[2:11]) + B[1]

    # PWc = FirstCost[1] + pv(i,n, AOC)


    println(A)
    println(B)
    @printf "The present worth of alternative A is %i \nand that of alternative B is %i." PWa PWb

    # _____ offers the lower present worth.
end

# practice()
p8()