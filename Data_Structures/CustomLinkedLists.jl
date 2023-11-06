export CircularlyLinkedList, DoublyLinkedNode, ll_push!, display_circularly_linked_list


abstract type Node end

mutable struct SinglyLinkedNode{T} <: Node
    value::T
    nextNode::Union{Nothing,SinglyLinkedNode{T}}
    SinglyLinkedNode{T}(data::T) where T = new{T}(data, nothing)
end

mutable struct DoublyLinkedNode{T} <: Node
    value::T
    nextNode::Union{Nothing,DoublyLinkedNode{T}}
    prevNode::Union{Nothing,DoublyLinkedNode{T}}

    DoublyLinkedNode{T}(data::T) where T = new{T}(data, nothing, nothing)
end

abstract type LinkedList end

mutable struct SinglyLinkedList{T} <: LinkedList
    head::Union{Nothing,SinglyLinkedNode{T}}
    tail::Union{Nothing,SinglyLinkedNode{T}}
    n::Int
end
SinglyLinkedList{T}() where T = SinglyLinkedList{T}(nothing, nothing, 0)
SinglyLinkedList() = SinglyLinkedList{Any}()


mutable struct DoublyLinkedList{T} <: LinkedList
    head::Union{Nothing,DoublyLinkedNode{T}}
    tail::Union{Nothing,DoublyLinkedNode{T}}
    n::Int
end
DoublyLinkedList{T}() where T = DoublyLinkedList{T}(nothing, nothing, 0)
DoublyLinkedList() = DoublyLinkedList{Any}()

mutable struct CircularlyLinkedList{T} <: LinkedList
    head::Union{Nothing,DoublyLinkedNode{T}}
    tail::Union{Nothing,DoublyLinkedNode{T}}
    n::Int
end
CircularlyLinkedList{T}() where T = CircularlyLinkedList{T}(nothing, nothing, 0)
CircularlyLinkedList() = CircularlyLinkedList{Any}()
# Base.show(io::IO, m::CircularlyLinkedList) = print(io, "MyStruct with x: $(m.x) and y: $(m.y)")

function ll_push!(sll::SinglyLinkedList, value::T) where T
    newNode = SinglyLinkedNode{T}(value)
    if !isnothing(sll.head)
        newNode.nextNode = sll.head 
        sll.head = newNode
    else
        sll.head = newNode
        sll.tail = newNode
    end
    sll.n+=1 
end

function ll_push!(dll::DoublyLinkedList{T}, value::T) where T
    newNode = DoublyLinkedNode{T}(value)
    # newNode = DoublyLinkedNode{T}(value,nothing, nothing)
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

function ll_push!(cll::CircularlyLinkedList{T}, value::T) where T
    newNode = DoublyLinkedNode{T}(value)

    if !isnothing(cll.head)
        newNode.nextNode = cll.head
        newNode.prevNode = cll.tail
        cll.head.prevNode = newNode
        cll.tail.nextNode = newNode
        cll.head = newNode

    else
        newNode.nextNode = newNode
        newNode.prevNode = newNode
        cll.tail = newNode
        cll.head = newNode

    end

    cll.n+=1
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

function display_nodes_backwards(dll::DoublyLinkedList)
    println("Linked list with size ", dll.n, " Navigate backwards: ")
    node = dll.tail
    while node ≠ nothing
        println(node.value)
        node = node.prevNode
    end
end

function display_circularly_linked_list(cll::CircularlyLinkedList,;forwards = false)
    forwards ? pointer = cll.tail : pointer = cll.head
    forwards ? cll.tail : cll.head
    # pointer = cll.tail

    cont = true
    while cont
        println(pointer.value)
        pointer = (forwards ? pointer.prevNode : pointer.nextNode)
        cont = (pointer !== (forwards ? cll.tail : cll.head))
    end
end

function show_head_and_tail(ll::LinkedList)
    println("Head ", ll.head.value)
    println("Tail ", ll.tail.value)
end


function runSLL()
    sll = SinglyLinkedList{Int64}()
    ll_push!(sll,1)
    ll_push!(sll,2)
    ll_push!(sll,3)
    ll_push!(sll,4)
    ll_push!(sll,5)
    ll_push!(sll,6)
    ll_push!(sll,7)
    ll_pop!(sll)
    ll_push!(sll,7)
    ll_push!(sll,8)
    ll_push!(sll,9)
    ll_push!(sll,1)
    ll_push!(sll,2)
    display_nodes_forwards(sll)
    show_head_and_tail(sll)
end

function runDLL()
    dll = DoublyLinkedList{Int}()

    ll_push!(dll,1)
    ll_push!(dll,2)
    ll_push!(dll,3)


    # ll_pop!(sll)

    display_nodes_forwards(dll)
    display_nodes_backwards(dll)
    show_head_and_tail(dll)

end

function runCLL()
    cll = CircularlyLinkedList{Bool}()

    ll_push!(cll,false)
    ll_push!(cll,false)
    ll_push!(cll,false)
    ll_push!(cll,false)
    ll_push!(cll,false)
    ll_push!(cll,false)
    ll_push!(cll,false)
    ll_push!(cll,false)

    # ll_pop!(sll)

    display_circularly_linked_list(cll,forwards = true)
    # show_head_and_tail(cll)

end

# runSLL()

# runDLL()
# runCLL()