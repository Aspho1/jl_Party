using LinearAlgebra, Distributions, Printf

function p_20_7_1()
    # Each week, the Columbus Record Club attracts 100 new
    # members. Members remain members for an average of one
    # year (1 year = 52 weeks). On the average, how many
    # members will the record club have?

    λ = 100 # new cust / week
    μ = 1/52 # weeks / member
    L = λ / μ

    @printf "\np_20_7_1: The expected number of members in the club is %d\n" L
end

function p_20_7_2()
    # The State U doctoral program in business admits an
    # average of 25 doctoral students each year. If a doctoral
    # student spends an average of 4 years in residence at State
    # U, how many doctoral students would one expect to find
    # there?

    λ = 25
    μ = 1/4
    L = λ / μ

    @printf "\np_20_7_2: The expected number of doctoral students is %d\n" L
end

function p_20_7_3()
    #     There are at present 40 solar energy construction firms
    # in the state of Indiana. An average of 20 solar energy
    # construction firms open each year in the state. The average
    # firm stays in business for 10 years. If present trends continue,
    # what is the expected number of solar energy construction
    # firms that will be found in Indiana? If the time between the
    # entries of firms into the industry is exponentially distributed,
    
    # what is the probability that (in the steady state) there will
    # be more than 300 solar energy firms in business? (Hint: For
    # large l, the Poisson distribution can be approximated by a
    # normal distribution.)

    S₀ = 40    # Start with 40 firms
    λ = 20     # new firms per year
    W = 10     # average number of years in the system 
    μ = inv(W) # Deathrate

    Act = Poisson(λ*W)
    ap = 
    act = ccdf(Act,300)
    approx = ccdf(Normal(λ*W,sqrt(λ*W)),300)

    @printf "\np_20_7_3: The probability that more than 300 firms will exist in Indiana is approximately %5.2e \nThe actual P is %5.2e \n" approx act
end

function p_20_8_3()
    # An average of 40 cars per hour arrive to be painted at a
    # single-server GM painting facility. 95% of the cars require
    # 1 minute to paint; 5% must be painted twice and require 2.5
    # minutes to paint. Assume that interarrival times are
    # exponential.

    λ = 40 # Cars arriving per hour

    cars = [.95 1; .05 2.5]
    μ = inv(sum(cars[i,1] * cars[i,2] for i in 1:2))*60 # Cars painted per hour
    ρ = λ/μ

    L = λ/(μ - λ)
    L_q = L - ρ 
    W_q = L_q / λ

    # a On the average, how long does a car wait before being painted?
    @printf "\np_20_8_3:\nA. On average, a car waits %4.3f minutes before being painted.\n" W_q*60 #inv(μ/60)


    # b If cars never had to be repainted, how would your
    # answer to part (a) change?
    μᵦ = 60
    ρᵦ = λ/μᵦ
    # println(ρ)

    Lᵦ = λ/(μᵦ - λ)
    L_qᵦ = Lᵦ - ρᵦ 
    W_qᵦ = L_qᵦ / λ
    @printf "B. Without repainting, the average time a car waits before being painted decreases by %.3f minutes.\n" (W_q-W_qᵦ)*60 #inv(μ/60)
end

function p_20_9_1()
    # A laundromat has 5 washing machines. A typical
    # machine breaks down once every 5 days. A repairer can
    # repair a machine in an average of 2.5 days. Currently, three
    # repairers are on duty. The owner of the laundromat has the
    # option of replacing them with a superworker, who can repair
    # a machine in an average of 5/6 day. The salary of the
    # superworker equals the pay of the three regular employees.
    # Breakdown and service times are exponential. Should the
    # laundromat replace the three repairers with the superworker?

    #            M/M/3/GD/5/5  vs  M/M/1/GD/5/5
    k = 5
    R = 3

    μₙ = 2 / 5   # Machines fixed per day
    μₛ = 1/(5/6)    # Machines fixed per day (one machine every (5/6)ths days) aka 6/5
    
    λ = 1 / 5   # One machine breaks every 5 days

    # Make nCr command for Julia....
    combin(n,r) = factorial(n)/((factorial(r)*(factorial(n-r))))

    # Calculate the probability vector for a given μ, number of workers, and number of machines
    function calc_pi_helper(μ, R, k)
        # Return a vector of πⱼ's. Using formula 52 from chapter 20.9
        #                                    IF  ?                  THEN                   : ELSE
        return [(combin(k, j) * (λ/μ)^j * (j > R ? factorial(j) / (factorial(R) * R^(j-R)) : 1)) for j in 0:k]
    end

    function π_Solver(k, pVector) # Use math to solve :) 
        b = [1;0;0;0;0;0]
        A = zeros(Float64, k+1, k+1)
        A = A - I(k+1)
        A[:,1] = pVector'
        A[1,:] .= 1        
        π = A\b
        L = sum(π[j+1] * (j) for j in 0:k)
        return π, L
    end
    #!
    PVectorₙ = calc_pi_helper(μₙ, 3, k) 
    PVectorₛ = calc_pi_helper(μₛ, 1, k)

    πₙ, Lₙ = π_Solver(k,PVectorₙ)
    πₛ, Lₛ = π_Solver(k,PVectorₛ)

    @printf "\np_20_9_1:\nL of the normal workers: %2.4f \n" Lₙ
    @printf "L of the super worker: %2.4f \n" Lₛ
    @printf "\nThe better option uses %s\n" (Lₙ < Lₛ ? "Normal workers " : "a Superworker")

    # # This is the LINGO Code.... same result.
    # MODEL:
    #     Tres_Normies = @PFS(5*(1/5)/(2/5),3,5);
    #     Uno_Super = @PFS(5*(1/5)/(6/5),1,5);
    # END
end


function p_20_9_2()
    # My dog just had 3 frisky puppies who jump in and out
    # of their whelping box. A puppy spends an average of 10
    # minutes (exponentially distributed) in the whelping box
    # before jumping out. Once out of the box, a puppy spends an
    # average of 15 minutes (exponentially distributed) before
    # jumping back into the box.

    ## States are the number of puppies in the box

    # M/M/3/GD/3/3

    # A) At any given time, what is the probability that more
    # puppies will be out of the box than will be in the box?
    K = 3    # Number of puppies
    λ = 1/15 # Puppies per minute into the box
    μ = 1/10 # Puppies per minute out of the box

    ρ = λ/(K*μ) # Puppy intensity

    States = [0 1 2 3]
    BR = [(K-j)*λ for j in 0:3]
    DR = [j*μ for j in 0:3]
    # @printf "|   S  |   λ  |   μ  \n" 
    # for i in 0:3
    #     @printf "|%4d  |%4.4f|%4.4f\n" i BR[i+1] DR[i+1]
    # end

    # println()
    combin(n,r) = factorial(n)/((factorial(r)*(factorial(n-r))))
    function calc_pi_helper(R, k)#R is parallel servers, k is customer population
        # Return a vector of πⱼ's. Using formula 52 from chapter 20.9
        #                                    IF  ?                  THEN                   : ELSE
        Pi_Coefficients = [(combin(k, j) * (λ/μ)^j * (j > R ? factorial(j) / (factorial(R) * R^(j-R)) : 1)) for j in 0:k]

        A = zeros(k+1,k+1)
        A = A - I(k+1)
        A[:,1] = Pi_Coefficients'
        A[1,:] .= 1
        b = [1; 0; 0; 0]
        return A\b
    end

    Puppy_π = calc_pi_helper(3,3) #  
    X = sum(Puppy_π[1:2]) # This is the correct answer → 0.6428571428571429

    @printf "\np_20_9_2: \nA. The probability more puppies will be out of the box than in the box is %4.4f \n" X 

    ## Lingo model
    # MODEL:
    #     Pups = @PFS(3*(1/15)/(1/10),3,3);
    # END
    # Pups = 1.2

    # B) On the average, how many puppies will be in the box?
    Y = sum(Puppy_π.*States')
    @printf "B. On the average, %2.1f puppies will be in the box.\n" Y
end

function p_20_9_3()
    # Gotham City has 10,000 streetlights. City investigators
    # have determined that at any given time, an average of 1,000
    # lights are burned out. A streetlight burns out after an average
    # of 100 days of use. The city has hired Mafia, Inc., to replace
    # burned-out lamps. Mafia, Inc.’s contract states that the
    # company is supposed to replace a burned-out street lamp in
    # an average of 7 days. Do you think that Mafia, Inc. is living
    # up to the contract?

    K, MTTF, W = 10000, 100, 7
    λ = K/MTTF
    L = λ*W
    D = Poisson(L)
    A = ccdf(D,1000) # This is realllly low (unlikely to happen naturally)
    @printf "\np_20_9_3:\nMafia Inc.'s contract states that an average of %.1f lights should be out of service at any time.\n" L
    @printf "Therefore, Mafia Inc. is in breach of contract (Suprise!) for having 1000 lights out of service.\n"

    # I have solved this atleast four ways and gotten different answers.
    # Lingo: @PFS(10000*.07, 10000,10000); = 654.2056
    # Equation 53 returned L = 0.0655
    # A simulation returned L ≈ 92.5??
end

function p_20_9_4()
    println("\np_20_9_4: This was a doozy.... ")
    # This problem illustrates balking. The Oryo Cookie Ice
    # Cream Shop in Dunkirk Square has three competitors. Since
    # people don’t like to wait in long lines for ice cream, the
    # arrival rate to the Oryo Cookie Ice Cream Shop depends on
    # the number of people in the shop. More specifically, while
    # j ≤ 4 customers are present in the Oryo shop, customers
    # arrive at a rate of (20 - 5j) customers per hour. If more than
    # 4 people are in the Oryo shop, the arrival rate is zero. For
    # each customer, revenues minus raw material costs are 50¢.
    # Each server is paid $3 per hour. A server can serve an
    # average of 10 customers per hour. To maximize expected
    # profits (revenues minus raw material and labor costs), how
    # many servers should Oryo hire? Assume that interarrival
    # and service times are exponential.
    
    combin(n,r) = factorial(n)/((factorial(r)*(factorial(n-r))))
    λ = 5  # Customers per hour
    K = 4
    # Λ(j) = j <= 4 ? (20-λ*j) : 0
    μ(R,j) = (10*min(R,j))
    λ = [20 15 10 5 0]
    function calc_pi_helper(R, k) #R is parallel servers, k is max customers in the system, j is the state
        Pi_Coefficients = [(combin(k, j) * (λ[j+1]/(μ(R,j)))^j * (j > R ? factorial(j) / (factorial(R) * R^(j-R)) : 1)) for j in 0:k]
        # @printf "%s\n" Pi_Coefficients
        A = zeros(k+1,k+1)
        A = A - I(k+1)
        A[:,1] = Pi_Coefficients'
        A[1,:] .= 1
        b = [1; 0; 0; 0; 0]
        println("`A` Matrix and `b` vector: ")
        for r in 1:5
            @printf "|"
            for c in 1:5
                @printf "% 2.2f |" A[r,c]
            end
            @printf "  |% 1d |" b[r]
            println()
        end
        
        return A\b # Return the steady state probabilities for each state
    end
    
    States = [0  1  2  3  4] # Number of customers
    # BR     = [20 15 10 5  0]

    for i in 1:4
        π = calc_pi_helper(i,4)
        L = sum(States[j] * π[j] for j in 1:5)
        CustomersServed = K - L
        profit = .5*CustomersServed - i*3
        @printf " - Expected length of line with %d servers is: %2.4f\n π_%d = %s\n" i L i π
        @printf " -- Expected number of customers served per hour with %2d servers = %4.4f\n" i CustomersServed
        @printf " --- Expected profit = \$%4.2f\n\n" profit
    end
    

end
function GAHHHHits12amstopit()
    @printf "--------------------------------------------------\n" 
    function calc_pi_helper(R, k)
        λ = [20, 15, 10, 5, 0]
        μ(R, j) = 10 * min(R, j)
        
        A = zeros(k+1, k+1)
        for j in 1:k
            A[j, j] = λ[j]
            A[j, j+1] = -μ(R, j)
        end
        A[k+1, :] .= 1
        b = [0; 0; 0; 0; 1]
        println(A)
        return A\b
    end
    
    States = [0, 1, 2, 3, 4]
    
    for i in 1:4
        π = calc_pi_helper(i, 4)
        L = sum(States[j] * π[j] for j in 1:5)
        CustomersServed = 4 - L
        profit = 0.5 * CustomersServed - i * 3
        @printf "Expected length of line with %d servers is: %2.4f\n" i L
        @printf "Expected number of customers served per hour with %2d servers is: %4.4f\n" i CustomersServed
        @printf "\nExpected profit \$%4.2f\n" profit
    end

    @printf "uhhh pick one server. I'd like to see how to do this correctly.\n" 
end

p_20_7_1() #!
p_20_7_2() #!
p_20_7_3() #!
p_20_8_3()
p_20_9_1() #!
p_20_9_2() #!
p_20_9_3() #!
p_20_9_4() #!

GAHHHHits12amstopit()

