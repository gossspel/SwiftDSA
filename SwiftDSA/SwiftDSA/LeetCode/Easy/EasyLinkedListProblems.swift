//
//  EasyLinkedListProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 7/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyLinkedListProblems {}

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
