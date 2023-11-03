mutable struct Node
    index::Int
    prevNode::Union{Nothing, Node}
    NextNode::Union{Nothing, Node}
    state::Bool
end

mutable struct DCLL
    head::Union{Nothing, Node}
    tail::Union{Nothing, Node}
    n::Int

    function node_push!(newNode)
        if n == 0
        head = newNode
        tail = newNode
        n+=1
        else
        head = newNode
        end
    
    end
end


# Nodes = Vector{Union{Nothing,Node}}(nothing,8)

function swap_state(state::Bool)
    return !state
end

function swap_state(node::Node)
    node.state = !node.state
end

function activate(nodes, node_index::Int)
    working_node = nodes[node_index]
    swap_state(working_node)
    swap_state(working_node.prevNode)
    swap_state(working_node.NextNode)
end

function display_nodes(nodes)
    node = nodes[1]
    println(node)
    while node.index < 8
        println(node.state, node.index)
        node = node.NextNode
    end
end

for i in 1:8
    if i == 1
        Nodes[i] = Node(i, Nodes[8], Nodes[i+1], 0)
    elseif i == 8
        Nodes[i] = Node(i, Nodes[i-1], Nodes[1], 0)
    else
        Nodes[i] = Node(i, Nodes[i-1], Nodes[i+1], 0)
    end
    
end


linked_list = DCLL(nothing, 0)
Node()
# println(Nodes)
# display_nodes(Nodes)

# activate(Nodes,1)

# display_nodes(Nodes)
