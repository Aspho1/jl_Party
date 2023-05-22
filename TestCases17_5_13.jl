using Random

function simulate_machine(policy, months)
    failure_prob = [0.1, 0.2, 0.5, 1.0]
    cost = 0
    
    for _ in 1:months
        age = 0
        while true
            age += 1
            if age == policy
                cost += 500
                break
            elseif rand() < failure_prob[age]
                cost += 1000
                break
            end
        end
    end
    
    return cost / months
end

function main()
    num_simulations = 10000
    total_months = 12
    
    avg_costs = [0.0, 0.0, 0.0]
    
    for i in 1:3
        for _ in 1:num_simulations
            avg_costs[i] += simulate_machine(i + 1, total_months)
        end
        avg_costs[i] /= num_simulations
    end
    
    println("Policy 1 average cost: \$", avg_costs[1])
    println("Policy 2 average cost: \$", avg_costs[2])
    println("Policy 3 average cost: \$", avg_costs[3])
end



function p17_5_7()
    p1 = [10; 20]
    p2 = [10; 25]
    s1 = [.8 .2; .1 .9]
    s2 = [.9 .1; .15 .85]
    s1S = s1^50000
    s2S = s2^50000
    println(s1S,"\n")
    println(s2S,"\n")
    println("S1S: ",(s1S) * p1)
    println("S2S: ",(s2S) * p2)
end

# p17_5_7()

# main()

function p()
    P = [.8 .1 .05 .05;
        .1 .6 .1 .2;
        .1 .1 .5 .3;
         0 0 0 1]
    
    nP = P^50000
    # queue = qr(P)
    # (I - queue.Q)' #*queue.R
    println(nP)
end
function z()
    f = [.03 .97 0;
         .05 0 .95;
         .07 0 .93]
        
    zzz = qr(f)
    # println(zzz)
    sum(([1 0 0; 0 1 0; 0 0 1] - zzz.Q)' * zzz.R)
end
z()

