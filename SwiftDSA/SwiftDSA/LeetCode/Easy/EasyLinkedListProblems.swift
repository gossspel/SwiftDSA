//
//  EasyLinkedListProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 7/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyLinkedListProblems {}

// MARK: - 21. Merge Two Sorted Lists
// LINK: https://leetcode.com/problems/merge-two-sorted-lists/
//
// Description: Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing
// together the nodes of the first two lists.
//
// Strategy: If either one of them list is empty, return the other one. Otherwise, compare the first node value of both
// list, if they equal to each other, append both as new nodes on the merged list and update the current pointer on
// both lists. If node.val from l1 is less than node.val from l2, append l1 node as a new node on the merged list and
// update the current pointer on l1. If node.val from l1 is greater than node.val from l2, append l2 node as a new node
// on the merged list and update the current pointer on l2. Continue until either l1 or l2 is empty, and then assign
// the leftover current pointer from the non empty list to the currentNewListNode.next. Return the new head in the end.

extension EasyLinkedListProblems {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let sureL1 = l1 else {
            return l2
        }
        
        guard let sureL2 = l2 else {
            return l1
        }
        
        var newHead: ListNode? = nil
        var currentNewListNode: ListNode? = nil
        var currentL1Node: ListNode? = sureL1
        var currentL2Node: ListNode? = sureL2
        
        while let sureCurrentL1Node = currentL1Node, let sureCurrentL2Node = currentL2Node {
            if sureCurrentL1Node.val == sureCurrentL2Node.val {
                if newHead == nil {
                    newHead = ListNode(sureCurrentL1Node.val)
                    newHead?.next = ListNode(sureCurrentL2Node.val)
                    currentNewListNode = newHead?.next
                } else {
                    currentNewListNode?.next = ListNode(sureCurrentL1Node.val)
                    currentNewListNode?.next?.next = ListNode(sureCurrentL2Node.val)
                    currentNewListNode = currentNewListNode?.next?.next
                }
                
                currentL1Node = sureCurrentL1Node.next
                currentL2Node = sureCurrentL2Node.next
            } else if sureCurrentL1Node.val < sureCurrentL2Node.val {
                if newHead == nil {
                    newHead = ListNode(sureCurrentL1Node.val)
                    currentNewListNode = newHead
                } else {
                    currentNewListNode?.next = ListNode(sureCurrentL1Node.val)
                    currentNewListNode = currentNewListNode?.next
                }
                
                currentL1Node = sureCurrentL1Node.next
            } else {
                if newHead == nil {
                    newHead = ListNode(sureCurrentL2Node.val)
                    currentNewListNode = newHead
                } else {
                    currentNewListNode?.next = ListNode(sureCurrentL2Node.val)
                    currentNewListNode = currentNewListNode?.next
                }
                
                currentL2Node = sureCurrentL2Node.next
            }
        }
        
        if let sureCurrentL1Node = currentL1Node {
            currentNewListNode?.next = sureCurrentL1Node
        } else if let sureCurrentL2Node = currentL2Node {
            currentNewListNode?.next = sureCurrentL2Node
        }
        
        return newHead
    }
}

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

// MARK: - 160. Intersection of Two Linked Lists
// LINK: https://leetcode.com/problems/intersection-of-two-linked-lists/
//
// Description: Given the heads of two singly linked-lists headA and headB, return the node at which the two lists
// intersect. If the two linked lists have no intersection at all, return null.
//
// Strategy: Use a strSet, traverse the first linkedlist, insert the mem address of each node into the strSet. Traverse
// the second linked list, insert the mem address of each node into the strSet, if the count of was not increased,
// return that node, otherwise return nil.

extension EasyLinkedListProblems {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var strSet: Set<String> = Set()
        var current: ListNode? = headA
        
        while let sureCurrent = current {
            strSet.insert("\(Unmanaged.passUnretained(sureCurrent).toOpaque())")
            current = sureCurrent.next
        }
        
        current = headB
        
        while let sureCurrent = current {
            let strSetCount: Int = strSet.count
            
            strSet.insert("\(Unmanaged.passUnretained(sureCurrent).toOpaque())")
            
            if strSetCount == strSet.count {
                return sureCurrent
            }
            
            current = sureCurrent.next
        }
        
        return nil
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
    
    func reverseListConstantSpace(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var current: ListNode? = head
        var temp: ListNode? = current?.next
        
        while current != nil {
            current?.next = prev
            prev = current
            current = temp
            temp = current?.next
        }
        
        return prev
    }
}
