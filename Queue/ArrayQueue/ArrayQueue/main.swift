//
//  main.swift
//  ArrayQueue
//
//  Created by Byeongjo Koo on 2022/10/07.
//

struct Queue<T> {
    
    /// 가장 앞의 원소를 가리키는 인덱스.
    private var frontIndex: Int
    /// 가장 뒤의 원소를 가리키는 인덱스.
    private var backIndex: Int
    /// 현재 큐에 있는 원소들의 수.
    private(set) var count: Int
    /// 저장공간 배열.
    private var array: Array<T?>
    
    init(size: Int) {
        frontIndex = 0
        backIndex = 0
        count = 0
        array = Array(repeating: nil, count: size)
    }
    
    /// 큐가 비어 있는지 여부.
    var isEmpty: Bool {
        frontIndex == backIndex && array[frontIndex] == nil
    }
    
    /// 큐가 가득차 있는지 여부.
    var isFull: Bool {
        (backIndex + 1) % array.count == frontIndex
    }
    
    /// 가장 앞의 원소.
    var front: T? {
        array[frontIndex]
    }
    
    /// 가장 뒤의 원소.
    var back: T? {
        array[backIndex]
    }
    
    /// 큐의 마지막에 원소를 삽입합니다.
    mutating func pushBack(data: T) {
        if isFull { return }
        if isEmpty == false {
            backIndex += 1
            backIndex %= array.count
        }
        array[backIndex] = data
        count += 1
    }
    
    /// 큐의 제일 앞의 원소를 반환합니다.
    mutating func popFront() -> T? {
        if isEmpty { return nil }
        let front = array[frontIndex]
        array[frontIndex] = nil
        if isEmpty == false {
            frontIndex += 1
            frontIndex %= array.count
        }
        count -= 1
        return front
    }
}
