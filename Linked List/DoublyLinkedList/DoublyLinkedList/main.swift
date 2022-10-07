//
//  main.swift
//  DoublyLinkedList
//
//  Created by Byeongjo Koo on 2022/10/05.
//

struct DoublyLinkedList<T>: Sequence where T: CustomStringConvertible {
    
    private var head: Node
    private var tail: Node
    private var elementCount: Int
    
    init() {
        head = Node()
        tail = Node()
        elementCount = 0
    }
    
    /// 제일 앞의 노드를 반환합니다.
    var front: Node? {
        head.next
    }
    
    /// 가장 뒤의 노드를 반환합니다.
    var back: Node? {
        tail.next
    }
    
    /// 리스트가 비어있는지 여부를 반환합니다.
    var isEmpty: Bool {
        head.next == nil
    }
    
    /// 리스트의 크기를 반환합니다.
    var size: Int {
        elementCount
    }
    
    func makeIterator() -> Iterator {
        Iterator(current: head)
    }
    
    /// 리스트의 제일 앞에 노드를 추가합니다.
    /// - Parameter data: 추가할 노드의 데이터.
    mutating func pushFront(data: T) {
        let newNode = Node(data: data)
        if isEmpty {
            tail.next = newNode
        }
        head.next?.prev = newNode
        newNode.next = head.next
        head.next = newNode
        elementCount += 1
    }
    
    /// 리스트의 제일 마지막에 노드를 추가합니다.
    /// - Parameter data: 추가할 노드의 데이터.
    mutating func pushBack(data: T) {
        let newNode = Node(data: data)
        if isEmpty {
            head.next = newNode
        }
        tail.next?.next = newNode
        newNode.prev = tail.next
        tail.next = newNode
        elementCount += 1
    }
    
    /// 특정 위치에 노드를 추가합니다. 리스트의 길이를 초과하면 제일 마지막에 추가합니다.
    /// - Parameters:
    ///   - position: 노드를 추가할 위치.
    ///   - data: 추가할 노드의 데이터.
    mutating func insert(at position: Int, data: T) {
        if position == 0 {
            pushFront(data: data)
        } else if elementCount <= position {
            pushBack(data: data)
        } else {
            var current: Node?
            if position < elementCount / 2 {
                current = head.next
                for _ in 0 ..< position {
                    current = current?.next
                }
            } else {
                current = tail.next
                for _ in 0 ..< elementCount - position - 1 {
                    current = current?.prev
                }
            }
            let newNode = Node(data: data)
            current?.prev?.next = newNode
            newNode.prev = current?.prev
            current?.prev = newNode
            newNode.next = current
            elementCount += 1
        }
    }
    
    /// 제일 앞의 노드를 제거합니다.
    /// - Returns: 제거된 노드.
    @discardableResult
    mutating func popFront() -> T? {
        if isEmpty { return nil }
        let front = head.next
        head.next = front?.next
        head.next?.prev = nil
        if head.next == nil {
            tail.next = nil
        }
        elementCount -= 1
        return front?.data
    }
    
    /// 제일 뒤의 노드를 제거합니다.
    /// - Returns: 제거된 노드.
    @discardableResult
    mutating func popBack() -> T? {
        if isEmpty { return nil }
        let back = tail.next
        back?.prev?.next = nil
        tail.next = back?.prev
        if tail.next == nil {
            head.next = nil
        }
        elementCount -= 1
        return back?.data
    }
    
    @discardableResult
    /// 특정 위치의 노드를 제거합니다.
    /// - Parameter position: 제거할 노드의 위치.
    /// - Returns: 제거된 노드.
    mutating func erase(at position: Int) -> T? {
        if isEmpty || elementCount <= position {
            return nil
        } else if position == 0 {
            return popFront()
        } else {
            var current: Node?
            if position < elementCount / 2 {
                current = head.next
                for _ in 0 ..< position {
                    current = current?.next
                }
            } else {
                current = tail.next
                for _ in 0 ..< elementCount - position - 1 {
                    current = current?.prev
                }
            }
            current?.prev?.next = current?.next
            current?.next?.prev = current?.prev
            elementCount -= 1
            return current?.data
        }
    }
}

extension DoublyLinkedList {
    
    final class Node {
        
        var data: T?
        var next: Node?
        weak var prev: Node?
        
        init(data: T? = nil, next: Node? = nil, prev: Node? = nil) {
            self.data = data
            self.next = next
            self.prev = prev
        }
        
        deinit {
            print((data?.description ?? "head/tail") + " released")
        }
    }
    
    struct Iterator: IteratorProtocol {
        
        var current: Node?
        
        init(current: Node? = nil) {
            self.current = current
        }
        
        mutating func next() -> Node? {
            current = current?.next
            return current
        }
    }
}

// MARK: - Test

fileprivate func test() {
    var list = DoublyLinkedList<Int>()
    list.pushFront(data: 4)
    list.insert(at: 0, data: 1)
    list.pushBack(data: 5)
    list.insert(at: 10, data: 7)
    list.insert(at: 1, data: 2)
    list.insert(at: 2, data: 3)
    list.pushBack(data: 8)
    list.insert(at: 5, data: 6)
    list.popFront()
    list.popFront()
    list.popBack()
    list.popBack()
    list.erase(at: 2)
    list.erase(at: 1)
    list.erase(at: 1)
    list.popFront()
    print("\n[current elements]")
    for element in list {
        print(element.data ?? Int.min)
    }
    print("\n[head->next]: \(list.front?.data ?? Int.min)")
    print("[tail->next]: \(list.back?.data ?? Int.min)")
    print("[size]: \(list.size)")
    print("-------end-------")
}
test()
