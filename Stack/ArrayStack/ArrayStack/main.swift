//
//  main.swift
//  ArrayStack
//
//  Created by Byeongjo Koo on 2022/10/11.
//

struct Stack<T> {
    
    /// 현재 마지막 원소의 인덱스.
    private var topIndex: Int
    /// 저장공간 배열.
    private var array: [T?]
    
    init(arraySize: Int) {
        topIndex = 0
        array = Array(repeating: nil, count: arraySize)
    }
    
    /// 스택이 비어있는지 여부.
    var isEmpty: Bool { topIndex == 0 && array[topIndex] == nil }
    /// 현재 스택에 들어있는 원소의 수.
    var size: Int { isEmpty ? 0 : topIndex + 1 }
    /// 스택이 가득 차 있는지 여부.
    var isFull: Bool { size == array.count }
    /// 스택에서 가장 위(뒤)에 있는 원소.
    var top: T? { array[topIndex] }
    
    /// 스택의 가장 뒤에 원소를 추가합니다.
    mutating func pushBack(data: T) {
        if isFull { return }
        if isEmpty {
            array[topIndex] = data
        } else if topIndex + 1 < array.endIndex {
            topIndex += 1
            array[topIndex] = data
        }
    }
    
    /// 스택의 가장 위(뒤)에 있는 원소를 반환합니다.
    mutating func popBack() -> T? {
        if isEmpty { return nil }
        let top = array[topIndex]
        array[topIndex] = nil
        if isEmpty == false {
            topIndex -= 1
        }
        return top
    }
}
