include("CustomLinkedLists.jl")

function swap_state!(node::Node)
    node.value = !node.value
end

function activate!(nodes::CircularlyLinkedList{Bool}, node_index::Int)
    node_index = ((node_index - 1) % nodes.n) + 1
    working_node = nodes.head
    for _ in 1:node_index - 1
        working_node = working_node.nextNode
    end

    swap_state!(working_node)
    swap_state!(working_node.prevNode)
    swap_state!(working_node.nextNode)
end

function activate(nodes::CircularlyLinkedList{Bool}, node_index::Int)
    # w = copy(nodes)
    node_index = ((node_index - 1) % nodes.n) + 1
    working_node = nodes.head
    for _ in 1:node_index - 1
        working_node = working_node.nextNode
    end

    swap_state!(working_node)
    swap_state!(working_node.prevNode)
    swap_state!(working_node.nextNode)
    return nodes
end


function make_board()
    cll = CircularlyLinkedList{Bool}()

    ll_push!(cll,Bool(1)) # 8
    ll_push!(cll,false) # 7
    ll_push!(cll,false) # 6
    ll_push!(cll,false) # 5
    ll_push!(cll,false) # 4
    ll_push!(cll,false) # 3
    ll_push!(cll,false) # 2
    ll_push!(cll,false) # 1

    # display_circularly_linked_list(cll,forwards = true)
    return cll

end

function vector_to_cll(vector)
    cll = CircularlyLinkedList{Bool}()
    for v in vector
        ll_push!(cll,v)
    end
    return cll
end

function int_to_bool(x,;n=8)
    [((x >> i) & 1) == 1 for i in 0:(n-1)]
end

function make_initital_state_dict()
    initital_states = Dict{Int, CircularlyLinkedList}()
    
    for init in 0:254
        initital_states[init] = vector_to_cll(int_to_bool(init,8))
    end
    
    initital_states
end

function eval(m::CircularlyLinkedList{Bool})
    p = m.head
    cont = true
    while cont
        if p.value
            p = p.nextNode
        else
            return false
        end
        if p === m.head
            return true
        end
    end
end


function find_best_solution(m::CircularlyLinkedList{Bool}, remaining_depth::Int)
    println("Start")
    for depth_i in 1:remaining_depth
        for node_i in 1:8
            println("   Node: ", node_i)
            next_m = activate(m,node_i)
            display_circularly_linked_list(next_m)
        end
    end
end

function activateV!(v::Vector{Bool}, i::Int)
    if i == 1
        v[8] = !v[8]
        v[i] = !v[i]
        v[i+1] = !v[i+1]
    elseif i == 8
        v[1] = !v[1]
        v[i] = !v[i]
        v[i-1] = !v[i-1]
    else
        v[i-1] = !v[i-1]
        v[i] = !v[i]
        v[i+1] = !v[i+1]        
    end
    return v
end


function recurseM(m::Vector{Bool}, memory::Vector{Int}, depth::Int, bestSolution::Vector{Int})
    if all(m)
        return length(memory) < length(bestSolution) || isempty(bestSolution) ? copy(memory) : bestSolution
    end

    if depth >= length(m)
        return bestSolution
    end
    for i in 1:length(m)
        # Avoid reactivating the same node
        if i in memory
            continue
        end

        # Create new temporary memory and state to test this path
        tempmemory = [memory; i]  # Append i to the memory
        tempm = copy(m)

        activateV!(tempm, i)  # Activate the node
        
        # Recurse and get the result
        candidateSolution = recurseM(tempm, tempmemory, depth + 1, bestSolution)

        # If the new candidate is better, update bestSolution
        if !isempty(candidateSolution) && (isempty(bestSolution) || length(candidateSolution) < length(bestSolution))
            bestSolution = candidateSolution
        end
    end
    
    return bestSolution
end


# testing = vector_to_cll(int_to_bool(0))
# eval(128)
# find_best_solution(testing,1)
# m = zeros(Int, 8)

# initial = int_to_bool(15)
# println(initial)
mapping = Dict{Vector{Bool},Vector{Int}}()
for i in 0:254

    solution = recurseM(int_to_bool(i), Int[], 0, Vector{Int}())
    mapping[int_to_bool(i)] = solution

    # println("$i -> $out")
end

sorted = sort(collect(mapping), by=x->length(x[2]))


println("Full list of ")
for s in keys(sorted)
    println("$(sorted[s][1])  ==>  $(sorted[s][2]) ")

end
# for key ∈ keys(mapping)

# end

# x = int_to_bool(0)
# for i in 1:8
#     println(activateV(x,i))
# end


# board = make_board();

# moves = [1, 3, 5, 7, 2, 4, 6, 8]
# for i in moves
#     activate!(board,i)
# end

# display_circularly_linked_list(board)

# println("Initial State: ", board.n)

# display_circularly_linked_list(board)

# activate!(board,8)

# println("Move 1: ")

# display_circularly_linked_list(board)

# activate!(board,1)

# println("Move 2: ")

# display_circularly_linked_list(board)

