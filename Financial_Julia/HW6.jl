using NPFinancial
using Printf
include("../Julia/Calc.jl")


function p1()
    InitialC = -730000
    life = 5
    salvage = 145000
    Ror = .24


    #calculate the total worth at year 0. 
    # the Initial cost is negative, and the PV of the salvage is a positive.
    PV = InitialC - pv(Ror,life,0,salvage)
    
    #Convert PW to an A
    ReqRev = pmt(Ror,5,PV)
    @printf "The Present Value is: %d" PV
    @printf "Minimum revenue required: %d" ReqRev
end

function p2()
    # The annual worth for years 1 through infinity of 
    # $50,000 now, 
    # $10,000 per year in years 1 through 15,
    # $20,000 per year in years 16 through infinity 
    # at 10% per year is closest to

    P = 50000 + pv(.1,15,10000) + 200000
    @printf "%d" (P/.1)


end

function p3()


#     The Briggs and Stratton Commercial Division designs and manufacturers small engines for golf turf maintenance equipment. 
#     A robotics-based testing system with support equipment will ensure that their new signature guarantee program entitled "Always Insta-Start" 
#     does indeed work for every engine produced.

 
#                       Pull System 	Push System
#     InitialC    	    $-1,650,000 	$-2,350,000
#     AOC per Year 	    $-760,000    	$-640,000
#     Salvage Value 	$120,000 	    $100,000
#     Estimated Life 	8 years 	    8 years
  
   
  
#     Compare the annual worth of the two systems at MARR = 10% per year. Select the better system.
  
    Pull = A_P(-1650000,.1,8) + A_F(120000,.1,8) -760000
    @printf "Pull: %d\n" Pull
    Push = A_P(-2350000,.1,8) + A_F(100000,.1,8) - 640000
    @printf "Push: %d" Push
   
end

function p5()
    Q = Array{Float64}(undef,5)

    for n in 1:5
        if n == 1
            Q[n] -= 32000
        elseif n == 2
            Q[n] -= 13000
        elseif n == 3
            Q[n] -= 44000
            # Q[n] += 1000
            # Q[n] -= 32000
        elseif n == 4
            Q[n] -= 13000
            # Q[n] -= 
        elseif n == 5
            Q[n] -= 12000
            # Q[n] += 1000
        end
    end
    println(Q, npv(.13,Q))

    R = Array{Float64}(undef,5)
    for n in 1:5
        if n == 1
            R[n] -= 74000
        elseif n == 2
            R[n] -= 8000
        elseif n == 3
            R[n] -= 9000
        elseif n == 4
            R[n] -= 10000
            # Q[n] -= 
        elseif n == 5
            R[n] -= 3000
            # Q[n] += 1000
        end
    end
    println(R, npv(.13,R))
    # Q[1:2:4] .= -32000
    # Q[2:5] .+= -13000
    # Q[3:2:5] += 1000
    # Q[]
    # R = Array{Float64}(undef,5)
    # R[1] = -74000

    # println(Q)

end

function p7()
    # Need to find A (years 0-14) equal to A_F()
    P = pv(.12,29,0,80000/.12)
    @printf "Answer: %d" (pmt(.12,14,P))
end
p7()
# p5()
# p3()
# p2()
# p1()