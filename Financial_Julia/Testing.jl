using NPFinancial
using JuMP
using HiGHS
using Ipopt

include("CompareAlternatives.jl")







# print("The julia Financial packages seem old and poorly documented. Hopefully I can update them to my needs.")

# pv(.05,2,100)


function p_3_58()

    # A large water utility is planning to upgrade its SCADA system for controlling well pumps, booster pumps,
    # and disinfection equipment so that everything can be centrally controlled. Phase I will reduce labor and travel costs
    # by $28,000 per year. Phase II will reduce costs by an additional $20,000 per year, that is, $48,000. 
    # Phase I savings should occur in years 0, 1, 2, and 3 and 
    # phase II savings should occur in years 4 through 10.
    # Let i = 8% per year.
    N = 11
    PI_Reduced = 28000
    PII_Reduced = 48000



    # PI_Years = [1:4]
    # PII_Years = [5:N]
    i = 0.08
    pay = [28000, 28000, 28000, 28000, 48000, 48000, 48000, 48000, 48000, 48000, 48000]
    PV = [pay[z] / ((1+i)^(z-1)) for z in 1: (N)]

    # a)
        # Determine the present worth of the upgraded system for years 1 to 10.
    println("NPV: ", npv(i, pay))
    # b)
        # The utility General Manager had hoped for a present worth of at least $400,000....
        # Determine the interest rate at which this would be correct.

    m = Model(Ipopt.Optimizer)
    # register(m, :npv, 2, npv, autodiff=true)
    # set_silent(m)

    @variable(m, interest >= 0.001)
    @NLconstraint(m, sum(pay[r]/((1+interest)^(r-1)) for r in 1:N) == 400000)
    @NLobjective(m, Min, interest)
    optimize!(m)
    println("Z = ", objective_value(m))
    println("i = ", value(interest))
end


a = Project("A", 10000.0, 1.1, 0.07, 5) #, 0.1, 100.1, 0.1, 1.0, 10
calculatePW(a)