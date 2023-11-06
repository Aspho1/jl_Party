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
    w = copy(nodes)
    node_index = ((node_index - 1) % w.n) + 1
    working_node = w.head
    for _ in 1:node_index - 1
        working_node = working_node.nextNode
    end

    swap_state!(working_node)
    swap_state!(working_node.prevNode)
    swap_state!(working_node.nextNode)
    return w
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
    for depth_i in 1:remaining_depth
        for node_i in 1:8
            next_m = activate(m,node_i)
            display_circularly_linked_list(next_m)
        end
    end
end
testing = vector_to_cll(int_to_bool(128))
eval(128)
find_best_solution(testing,8)

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

