abstract type Node end

mutable struct SinglyLinkedNode <: Node
    value::Int
    nextNode::Union{Nothing,Node}
end

mutable struct DoublyLinkedNode{T} <: Node
    value::T
    nextNode::Union{Nothing,DoublyLinkedNode{T}}
    prevNode::Union{Nothing,DoublyLinkedNode{T}}

    DoublyLinkedNode(data::T) where T = new{T}(data, nothing, nothing)
end

abstract type LinkedList end

mutable struct SinglyLinkedList <: LinkedList
    head::Union{Nothing,Node}
    tail::Union{Nothing,Node}
    n::Int
end

mutable struct DoublyLinkedList{T} <: LinkedList
    head::Union{Nothing,DoublyLinkedNode{T}}
    tail::Union{Nothing,DoublyLinkedNode{T}}
    n::Int
end
DoublyLinkedList{T}() where T = DoublyLinkedList{T}(nothing, nothing, 0)
DoublyLinkedList() = DoublyLinkedList{Any}()

mutable struct CircularlyLinkedList <: LinkedList
    head::Union{Nothing,Node}
    tail::Union{Nothing,Node}
    n::Int
end

function ll_push!(sll::SinglyLinkedList, newNode::SinglyLinkedNode)
    if !isnothing(sll.head)
        newNode.nextNode = sll.head 
        sll.head = newNode
    else
        sll.head = newNode
        sll.tail = newNode
    end
    sll.n+=1 
end

function ll_push!(dll::DoublyLinkedList, value::T) where T
    newNode = DoublyLinkedNode{T}(value)
    println(newNode.nextNode, " " ,newNode.prevNode)
    if !isnothing(dll.head)
        dll.head.prevNode = newNode
        newNode.nextNode = dll.head
    else
        dll.tail = newNode
    end
    dll.head = newNode
    println(newNode.nextNode, " " ,newNode.prevNode)
    dll.n+=1
end

function ll_pop!(sll::SinglyLinkedList)
    sll.head = sll.head.nextNode
    sll.n-=1
end

function display_nodes_forwards(ll::LinkedList)
    println("Linked list with size ", ll.n, " Navigate forwards: ")
    node = ll.head
    while node ≠ nothing
        println(node.value)
        node = node.nextNode
    end
end

function display_nodes_backwards(ll::Union{CircularlyLinkedList, DoublyLinkedList})
    println("Linked list with size ", ll.n, " Navigate backwards: ")
    node = ll.tail
    while node ≠ nothing
        println(node.value)
        node = node.prevNode
    end
end


function show_head_and_tail(ll::LinkedList)
    println("Head ", ll.head)
    println("Tail ", ll.tail)
end


function runSLL()
    sll = SinglyLinkedList(nothing, nothing, 0)

    ll_push!(sll,SinglyLinkedNode(1,nothing))
    ll_push!(sll,SinglyLinkedNode(2,nothing))
    ll_push!(sll,SinglyLinkedNode(3,nothing))
    ll_push!(sll,SinglyLinkedNode(4,nothing))
    ll_push!(sll,SinglyLinkedNode(5,nothing))
    ll_push!(sll,SinglyLinkedNode(6,nothing))
    ll_pop!(sll)
    ll_push!(sll,SinglyLinkedNode(7,nothing))
    ll_push!(sll,SinglyLinkedNode(8,nothing))
    ll_push!(sll,SinglyLinkedNode(9,nothing))
    ll_push!(sll,SinglyLinkedNode(10,nothing))
    ll_push!(sll,SinglyLinkedNode(11,nothing))
    display_nodes_forwards(sll)
    show_head_and_tail(sll)
end

function runDLL()
    dll = DoublyLinkedList{Int}()

    ll_push!(dll,DoublyLinkedNode(1))
    ll_push!(dll,DoublyLinkedNode(2))
    ll_push!(dll,DoublyLinkedNode(3))


    # ll_pop!(sll)

    display_nodes_forwards(dll)
    display_nodes_backwards(dll)
    show_head_and_tail(dll)

end

# runSLL()

runDLL()