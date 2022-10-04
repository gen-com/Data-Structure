//
//  main.swift
//  SinglyLinkedList
//
//  Created by Byeongjo Koo on 2022/09/28.
//

struct SinglyLinkedList<T>: Sequence where T: Equatable, T: CustomStringConvertible {
    
    /// 첫 원소를 가리킵니다.
    private let head: Node
    /// 마지막 원소를 가리킵니다.
    private let tail: Node
    /// 현재 원소의 수.
    private var elementsCount: Int
    
    // MARK: Initializer
    /**
     단일 연결 리스트를 초기화 합니다.
     첫 원소를 가리킬 head와 마지막 원소를 가리킬 tail을 생성합니다.
    */
    init() {
        head = Node(next: nil)
        tail = Node(next: nil)
        elementsCount = 0
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
        elementsCount
    }
    
    /// 반복자를 생성합니다.
    func makeIterator() -> Iterator {
        Iterator(current: head)
    }
    
    /**
     새로운 노드를 제일 앞에 추가합니다.
     - Parameter data: 새로운 노드의 데이터.
     */
    mutating func pushFront(data: T) {
        let newNode = Node(data: data)
        if isEmpty {
            tail.next = newNode
        }
        newNode.next = head.next
        head.next = newNode
        elementsCount += 1
    }
    /**
     새로운 노드를 제일 뒤에 추가합니다.
     - Parameter data: 새로운 노드의 데이터.
     */
    mutating func pushBack(data: T) {
        let newNode = Node(data: data)
        if isEmpty {
            head.next = newNode
        }
        tail.next?.next = newNode
        tail.next = newNode
        elementsCount += 1
    }
    /**
     특정 위치의 노드 앞에 새로운 노드를 추가합니다.
     리스트의 길이를 초과하는 위치 정보가 들어올 경우 제일 마지막에 추가합니다.
     - Parameters:
       - position: 새로운 노드를 추가할 위치정보.
       - data: 새로운 노드의 데이터.
    */
    mutating func insert(at position: Int, data: T) {
        var previous = head.next
        if position == 0 {
            pushFront(data: data)
        } else if 0 < position {
            for _ in 0 ..< position - 1 {
                if let next = previous?.next {
                    previous = next
                }
            }
            if previous?.next == nil {
                pushBack(data: data)
            } else {
                let newNode = Node(data: data)
                newNode.next = previous?.next
                previous?.next = newNode
                elementsCount += 1
            }
        }
    }
    
    @discardableResult
    mutating func popFront() -> Node? {
        if isEmpty {
            return nil
        } else {
            let front = front
            head.next = front?.next
            if head.next == nil {
                tail.next = nil
            }
            elementsCount -= 1
            return front
        }
    }
    
    /**
     특정 위치의 노드를 삭제합니다.
     - Parameter position: 삭제할 노드의 위치 정보.
    */
    @discardableResult
    mutating func erase(at position: Int) -> Node? {
        if isEmpty {
            return nil
        } else if position == 0 {
            return popFront()
        } else {
            elementsCount -= 1
            var current = head.next
            var previous: Node? = head
            for _ in 0 ..< position {
                previous = current
                current = current?.next
            }
            previous?.next = current?.next
            if previous?.next == nil {
                tail.next = previous
            }
            return current
        }
    }
}

extension SinglyLinkedList {
    
    /// 연결 리스트의 원소 입니다.
    final class Node: CustomStringConvertible {
        
        var data: T?
        /// 다음 노드를 가리킵니다.
        var next: Node?
        var description: String {
            if let data {
                return "Node data: \(data)"
            } else {
                return "nil"
            }
        }
        
        init(data: T? = nil, next: Node? = nil) {
            self.data = data
            self.next = next
        }
        
        deinit {
            print((data?.description ?? "head/tail") + " released")
        }
    }
    
    /// 리스트의 반복자입니다.
    struct Iterator: IteratorProtocol {
        
        var current: Node?
        
        mutating func next() -> Node? {
            current = current?.next
            return current
        }
        
        init(current: Node? = nil) {
            self.current = current
        }
    }
}
