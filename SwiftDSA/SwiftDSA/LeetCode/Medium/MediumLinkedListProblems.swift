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

public class Node {
    public var val: Int
    public var next: Node?
    public var random: Node?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        self.random = nil
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

// MARK: - 138. Copy List with Random Pointer
// LINK: https://leetcode.com/problems/copy-list-with-random-pointer/
//
// Description: A linked list of length n is given such that each node contains an additional random pointer, which
// could point to any node in the list, or null.
// Construct a deep copy of the list. The deep copy should consist of exactly n brand new nodes, where each new node
// has its value set to the value of its corresponding original node. Both the next and random pointer of the new nodes
// should point to new nodes in the copied list such that the pointers in the original list and copied list represent
// the same list state. None of the pointers in the new list should point to nodes in the original list.
// For example, if there are two nodes X and Y in the original list, where X.random --> Y, then for the corresponding
// two nodes x and y in the copied list, x.random --> y.
// Return the head of the copied linked list. The linked list is represented in the input/output as a list of n nodes.
// Each node is represented as a pair of [val, random_index] where:
// val: an integer representing Node.val
// random_index: the index of the node (range from 0 to n-1) that the random pointer points to, or null if it does not
// point to any node.
// Your code will only be given the head of the original linked list.
//
// Strategy: First loop through the whole linked list, record all the node values in nodes: [Node], each node in nodes
// should be an new instance of Node with val and next updated; record all the memory addresses in
// nodeIndexByMemoryAddress: [String: Int], with -1 being the index of nil random pointer; Loop through the whole
// linked list again with nodeIndexByMemoryAddress to create randomNodeIndices: [Int]. Loop through randomNodeIndices
// to update the random pointers of the node by nodes[i].random = nodes[randomNodeIndices[i]].

extension MediumLinkedListProblems {
    func copyRandomList(_ head: Node?) -> Node? {
        guard let _ = head else {
            return nil
        }
        
        var nodes: [Node] = []
        var nodeIndexByMemoryAddress: [String: Int] = [:]
        var current: Node? = head
        var currentIndex: Int = 0
        var randomNodeIndices: [Int] = []
        
        while let sureCurrent = current {
            let memAddress: String = "\(Unmanaged.passUnretained(sureCurrent).toOpaque())"
            nodeIndexByMemoryAddress[memAddress] = currentIndex
            
            nodes.append(Node(sureCurrent.val))
            current = sureCurrent.next
            currentIndex += 1
        }
        
        for i in 0..<(nodes.count - 1) {
            nodes[i].next = nodes[i + 1]
        }
        
        current = head
        
        while let sureCurrent = current {
            let randomIndex: Int
            
            if let random = sureCurrent.random {
                let memAddress: String = "\(Unmanaged.passUnretained(random).toOpaque())"
                randomIndex = nodeIndexByMemoryAddress[memAddress] ?? -1
            } else {
                randomIndex = -1
            }
            
            randomNodeIndices.append(randomIndex)
            current = sureCurrent.next
        }
        
        for (i, randomeIndex) in randomNodeIndices.enumerated() {
            if randomeIndex == -1 {
                nodes[i].random = nil
            } else {
                nodes[i].random = nodes[randomNodeIndices[i]]
            }
        }
        
        return nodes.first
    }
}
