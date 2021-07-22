//
//  EasyLinkedListProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 7/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyLinkedListProblems {}

// MARK: - 141. Linked List Cycle
// LINK: https://leetcode.com/problems/linked-list-cycle/
// VIDEO: https://www.youtube.com/watch?v=gBTe7lFR3vc
//
// Description: Given head, the head of a linked list, determine if the linked list has a cycle in it. There is a cycle
// in a linked list if there is some node in the list that can be reached again by continuously following the next
// pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that
// pos is not passed as a parameter. Return true if there is a cycle in the linked list. Otherwise, return false.
//
// Strategy: Loop through the linked list, record the memory address of every node in a set. If the set already
// contains that memory address, return true, otherwise continue until we get to a node in which node.next == nil and
// return false.
//
// Optimal Strategy: Use Floyd's tortoise and hare algorithm and return true if slow === fast at some point. This is
// because the fast pointer will always catch up with the slow pointer at some point if a cycle exists. For example, if
// there is 5 nodes between fast and slow pointer, at the next iteration there will be (5 + 1 - 2) = 4 nodes between
// fast and slow pointer. Effectively, the distance between fast and slow pointers is decreased by 1 node at each
// iteration.

extension EasyLinkedListProblems {
    func hasCycle(_ head: ListNode?) -> Bool {
        var fast: ListNode? = head?.next?.next
        var slow: ListNode? = head?.next
        var iterationCount: Int = 0

        while let sureFast = fast, let sureSlow = slow {
            if sureFast === sureSlow {
                return true
            }

            fast = sureFast.next?.next
            slow = sureSlow.next
            iterationCount += 1
        }

        return false
    }
    
    func hasCycleSlow(_ head: ListNode?) -> Bool {
        var memAddressSet: Set<String> = Set()
        var current: ListNode? = head
        
        while let sureCurrent = current {
            let memAddress: String = "\(Unmanaged.passUnretained(sureCurrent).toOpaque())"
            
            if memAddressSet.contains(memAddress) {
                return true
            } else {
                memAddressSet.insert(memAddress)
            }
            
            current = sureCurrent.next
        }
        
        return false
    }
}

// MARK: - 206. Reverse Linked List
// LINK: https://leetcode.com/problems/reverse-linked-list/
//
// Description: Given the head of a singly linked list, reverse the list, and return the reversed list.
//
// Strategy: Copy the head as the reverseListHead. Loop through the linked list, use a stack (array and append as push
// and removeLast as pop) to record all the value, and then loop through the reverseListHead and update each node while
// popping the stack.

extension EasyLinkedListProblems {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var current: ListNode? = head
        var stack: [Int] = []
        
        while let sureCurrent = current {
            stack.append(sureCurrent.val)
            current = sureCurrent.next
        }
        
        current = head
        
        while current != nil {
            current?.val = stack.removeLast()
            current = current?.next
        }
        
        return head
    }
}
