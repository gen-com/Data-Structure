//
//  main.swift
//  SinglyLinkedList
//
//  Created by Byeongjo Koo on 2022/09/28.
//

struct SinglyLinkedList<T> where T: Equatable, T: CustomStringConvertible {
    
    /// 첫 원소를 가리킵니다.
    private let head: Node
    /// 마지막 원소를 가리킵니다.
    private let tail: Node
    
    // MARK: Initializer
    /// 단일 연결 리스트를 초기화 합니다.
    /// 첫 원소를 가리킬 head와 마지막 원소를 가리킬 tail을 생성합니다.
    init() {
        head = Node(data: nil, next: nil)
        tail = Node(data: nil, next: nil)
    }
    
    var isEmpty: Bool {
        head.next == nil
    }
    
    /// 새로운 노드를 제일 앞에 추가합니다.
    /// - Parameter data: 새로운 노드가 가질 데이터.
    func addNodeToHead(data: T) {
        let newNode = Node(data: data)
        if isEmpty {
            tail.next = newNode
        }
        newNode.next = head.next
        head.next = newNode
    }
    
    /// 새로운 노드를 제일 뒤에 추가합니다.
    /// - Parameter data: 새로운 노드가 가질 데이터.
    func addNodeToTail(data: T) {
        let newNode = Node(data: data)
        if isEmpty {
            head.next = newNode
        }
        tail.next?.next = newNode
        tail.next = newNode
    }
    
    /// 특정 데이터를 가지는 노드 뒤에 새로운 노드를 추가합니다.
    /// 찾는 특정 데이터가 리스트 내에 존재하지 않을 시 추가하지 않습니다.
    /// - Parameters:
    ///   - target: 찾는 노드의 데이터.
    ///   - data: 새로운 노드가 가질 데이터.
    func addNodeAfter(target: T, data: T) {
        let newNode = Node(data: data)
        var current: Node? = head.next
        while current != nil && current?.data != target {
            current = current?.next
        }
        if current != nil {
            newNode.next = current?.next
            if newNode.next == nil {
                tail.next = newNode
            }
            current?.next = newNode
        }
    }
    
    /// 특정 노드를 삭제합니다.
    /// - Parameter target: 삭제할 노드의 데이터.
    func removeNode(target: T) {
        var current = head.next
        var previous: Node? = head
        while current != nil && current?.data != target {
            previous = current
            current = current?.next
        }
        previous?.next = current?.next
        if previous?.next == nil {
            tail.next = previous
        }
    }
    
    /// 모든 리스트를 방문합니다.
    func traverse() {
        var route = ""
        var currentNode: Node? = head.next
        while currentNode != nil {
            if let data = currentNode?.data {
                route.append("\(data.description)\t")
            }
            currentNode = currentNode?.next
        }
        print(route)
    }
}

extension SinglyLinkedList {
    
    /// 연결 리스트의 원소 입니다.
    private final class Node {
        
        var data: T?
        /// 다음 노드를 가리킵니다.
        var next: Node?
        
        init(data: T? = nil, next: Node? = nil) {
            self.data = data
            self.next = next
        }
        
        deinit {
            print((data?.description ?? "head or tail") + " released")
        }
    }
}
