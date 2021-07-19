//
//  EasyLinkedListProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 7/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

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
        
        while current != nil {
            XCTAssertEqual(current?.val, expectedValues[iteration])
            iteration += 1
            current = current?.next
        }
    }
}
