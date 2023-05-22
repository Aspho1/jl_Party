using NPFinancial
using Printf
export F_P, P_F, 
       P_A, A_P,
       F_A, A_F,
       Pg_A



function F_P(P, i, n)
    return -P * (1+i)^n
end

function P_F(F, i, n)      
    return -F/((1+i)^n)
end

function P_A(A, i, n, WHEN=0)
    if WHEN >= 1
        WHEN = 1
    end
    comp = (1+i)^n
    return -A*(((1+i*WHEN)*(comp-1)/i)/comp)
end

function A_P(P, i, n)
    return P*(i*((1+i)^n))/(((1+i)^n) - 1)
end

function F_A(A, i, n)
    return A*((1+i)^n -1)/i
end

function A_F(F, i, n)
    return F*i/((1+i)^n - 1)
end

function P_G

end

function A_G

end

function Pg_A

end







function pp2()
    y = 10

    y = 30
    W = 70000

    i = 0.13

    # invest X in years 0 to 9

    # Sustainably Withdraw 75000 annually at year 32
    F33 = W/i

    #Convert this to a "present" at year 9

    # convert this to an Annual cost
    P_F_9 = .18027
    a_F = .062
    Annual = F33 * P_F_9 * a_F


    # function print_factor_table()
    # end


    @printf "Annual: %d" A_P(P_F(F33, i, 30),i, 11)

end


# "Hello %d"
# pp2()

i = .11
n = 14
A = 1231

pvv = pv(i,n,0,A)
p_v = P_F(A,i,n)
@printf "\nNPF PV : %f\nJankPV : %f\n" pvv p_v


fvv = fv(i,n,0,A)
f_v = F_P(A,i,n)
@printf "NPF FV : %f\nJankFV : %f\n" fvv f_v
