//
//  EasyStackProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 7/22/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyStackProblems {}

// MARK: - 155. Min Stack
// LINK: https://leetcode.com/problems/min-stack/
//
// Description: Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
// Implement the MinStack class:
// MinStack() initializes the stack object.
// void push(val) pushes the element val onto the stack.
// void pop() removes the element on the top of the stack.
// int top() gets the top element of the stack.
// int getMin() retrieves the minimum element in the stack.
//
// Strategy: Use an array as the data structure for most functionalities of the stack, keep an instance var
// valueAndMinValueList to keep track of the min element at every node so the min can be easily restrieved after push
// or pop operations.

class MinStack {
    var valueAndMinValueList: [(Int, Int)] = []

    /** initialize your data structure here. */
    init() {}
    
    func push(_ val: Int) {
        if valueAndMinValueList.isEmpty {
            valueAndMinValueList.append((val, val))
        } else {
            let newMin = min(val, self.getMin())
            valueAndMinValueList.append((val, newMin))
        }
    }
    
    func pop() {
        valueAndMinValueList.removeLast()
    }
    
    func top() -> Int {
        return valueAndMinValueList[valueAndMinValueList.count - 1].0
    }
    
    func getMin() -> Int {
        return valueAndMinValueList[valueAndMinValueList.count - 1].1
    }
}
