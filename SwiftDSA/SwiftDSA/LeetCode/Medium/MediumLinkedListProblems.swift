//
//  MediumLinkedListProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/14/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumLinkedListProblems {}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init() {
        self.val = 0
        self.next = nil
    }
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

// MARK: - 19. Remove Nth Node From End of List
// LINK: https://leetcode.com/problems/remove-nth-node-from-end-of-list/
//
// Description: Given the head of a linked list, remove the nth node from the end of the list and return its head.
//
// Strategy: Traverse the linked list to the end, count all the nodes. Get the indexToRemove of the node that needs to
// be removed by letting (indexToRemove = length - n). Traverse the linked list, treat the head as index 0, next node
// as index 1, so on. When we get to the node in which the index is (indexToRemove - 1), assign
// self.next = self.next.next.

extension MediumLinkedListProblems {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard let sureHead = head else {
            return nil
        }
        
        var length: Int = 1
        var currentNode: ListNode? = sureHead
        
        while let nextNode = currentNode?.next {
            currentNode = nextNode
            length += 1
        }
        
        guard length > 1 else {
            return nil
        }
        
        let indexToRemove: Int = length - n
        
        if indexToRemove == 0 {
            let newHead = sureHead.next
            sureHead.next = nil
            return newHead
        } else {
            var currentIndex: Int = 0
            currentNode = sureHead
            
            if currentIndex == (indexToRemove - 1) {
                currentNode?.next = currentNode?.next?.next
            }
            
            while let nextNode = currentNode?.next {
                currentNode = nextNode
                currentIndex += 1
                
                if currentIndex == (indexToRemove - 1) {
                    currentNode?.next = currentNode?.next?.next
                }
            }
            
            return sureHead
        }
    }
}

// MARK: - 92. Reverse Linked List II
// LINK: https://leetcode.com/problems/reverse-linked-list-ii/
//
// Description: Given the head of a singly linked list and two integers left and right where left <= right, reverse the
// nodes of the list from position left to position right, and return the reversed list.
//
// Strategy: Traverse the linked list once, when the current node is within the left right limit, append the node value
// to valuesStackArray, which is an array that acts as a stack. Now traverse the linked list the second time, when the
// current node is within the left right limit, call removeLast on valuesStackArray and update the value of the current
// node with it.

extension MediumLinkedListProblems {
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        var valuesStackArray: [Int] = []
        var currentPosition: Int = 1
        var currentNode: ListNode? = head
        var nodeToStartReversing: ListNode? = nil
        var nodeToStopReversing: ListNode? = nil
        
        while let sureCurrentNode = currentNode, nodeToStopReversing == nil {
            if currentPosition >= left && currentPosition <= right {
                if currentPosition == left {
                    nodeToStartReversing = currentNode
                } else if currentPosition == right {
                    nodeToStopReversing = currentNode
                }
                
                valuesStackArray.append(sureCurrentNode.val)
            }
            
            currentNode = sureCurrentNode.next
            currentPosition += 1
        }
        
        guard let sureNodeToStartReversing = nodeToStartReversing else {
            return nil
        }
        
        currentNode = sureNodeToStartReversing
        
        while currentNode != nil && !valuesStackArray.isEmpty {
            guard let value = valuesStackArray.popLast() else {
                return nil
            }
            
            currentNode?.val = value
            currentNode = currentNode?.next
        }
        
        return head
    }
}
