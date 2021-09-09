//
//  EasyLinkedListProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 7/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

// MARK: - 21. Merge Two Sorted Lists

class EasyLinkedListProblem21Tests: XCTestCase {
    func testExample1() {
        let root1 = ListNode(1)
        root1.next = ListNode(2)
        root1.next?.next = ListNode(4)
        
        let root2 = ListNode(1)
        root2.next = ListNode(3)
        root2.next?.next = ListNode(4)
        
        let mergedList = EasyLinkedListProblems().mergeTwoLists(root1, root2)
        XCTAssertEqual(mergedList?.val, 1)
    }
}


// MARK: - 141. Linked List Cycle

class EasyLinkedListProblem141Tests: XCTestCase {
    func testHasCycle_with4CyclicalNodes_shouldReturnTrue() {
        let node3 = ListNode(-4)
        let node2 = ListNode(0, node3)
        let node1 = ListNode(2, node2)
        let root = ListNode(3, node1)
        node3.next = root
        XCTAssertTrue(EasyLinkedListProblems().hasCycle(root))
    }
    
    func testHasCycle_with4NonCyclicalNodes_shouldReturnFalse() {
        let node3 = ListNode(-4)
        let node2 = ListNode(0, node3)
        let node1 = ListNode(2, node2)
        let root = ListNode(-4, node1)
        XCTAssertFalse(EasyLinkedListProblems().hasCycle(root))
    }
    
    func testHasCycle_with2CyclicalNodes_shouldReturnTrue() {
        let node1 = ListNode(2)
        let root = ListNode(1, node1)
        node1.next = root
        XCTAssertTrue(EasyLinkedListProblems().hasCycle(root))
    }
    
    func testHasCycle_with1CyclicalNode_shouldReturnTrue() {
        let root = ListNode(1)
        root.next = root
        XCTAssertTrue(EasyLinkedListProblems().hasCycle(root))
    }
    
    func testHasCycle_with1NonCyclicalNode_shouldReturnFalse() {
        let root = ListNode(1)
        XCTAssertFalse(EasyLinkedListProblems().hasCycle(root))
    }
    
    func testHasCycle_with0CyclicalNodes_shouldReturnfalse() {
        XCTAssertFalse(EasyLinkedListProblems().hasCycle(nil))
    }
}

// MARK: - 206. Reverse Linked List

class EasyLinkedListProblem206Tests: XCTestCase {
    func testReverseList_with5Nodes_shouldReturnReversedList() {
        let node5 = ListNode(5)
        let node4 = ListNode(4, node5)
        let node3 = ListNode(3, node4)
        let node2 = ListNode(2, node3)
        let head = ListNode(1, node2)
        let reverseHead = EasyLinkedListProblems().reverseList(head)
        
        let expectedValues: [Int] = [5, 4, 3, 2, 1]
        var iteration: Int = 0
        var current: ListNode? = reverseHead
        
        XCTAssertNotNil(current)
        
        while current != nil {
            XCTAssertEqual(current?.val, expectedValues[iteration])
            iteration += 1
            current = current?.next
        }
    }
}
