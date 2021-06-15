//
//  MediumLinkedListProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/15/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

@testable import SwiftDSA
import XCTest

class MediumLinkedListProblemsTests: XCTestCase {}

// MARK: - 19. Remove Nth Node From End of List

extension MediumLinkedListProblemsTests {
    func testRemoveNthFromEnd_with5NodesLinkedListAndNIs2_shouldRemoveTheNodeSecondFromLast() {
        let node5 = ListNode(5)
        let node4 = ListNode(4, node5)
        let node3 = ListNode(3, node4)
        let node2 = ListNode(2, node3)
        let head = ListNode(1, node2)
        let newHead = MediumLinkedListProblems().removeNthFromEnd(head, 2)
        
        guard let sureNewHead = newHead else {
            XCTFail("The head is nil")
            return
        }
        
        var resultValues: [Int] = [sureNewHead.val]
        var currentNode: ListNode? = sureNewHead
        
        while let nextNode = currentNode?.next {
            resultValues.append(nextNode.val)
            currentNode = nextNode
        }
        
        XCTAssertEqual(resultValues, [1, 2, 3, 5])
    }
    
    func testRemoveNthFromEnd_with5NodesLinkedListAndNIs5_shouldRemoveTheNodeFifthFromLast() {
        let node5 = ListNode(5)
        let node4 = ListNode(4, node5)
        let node3 = ListNode(3, node4)
        let node2 = ListNode(2, node3)
        let head = ListNode(1, node2)
        let newHead = MediumLinkedListProblems().removeNthFromEnd(head, 5)
        
        guard let sureNewHead = newHead else {
            XCTFail("The head is nil")
            return
        }
        
        var resultValues: [Int] = [sureNewHead.val]
        var currentNode: ListNode? = sureNewHead
        
        while let nextNode = currentNode?.next {
            resultValues.append(nextNode.val)
            currentNode = nextNode
        }
        
        XCTAssertEqual(resultValues, [2, 3, 4, 5])
    }
    
    func testRemoveNthFromEnd_with1NodeLinkedListAndNIs1_shouldRemoveTheOnlyNode() {
        let head = ListNode(1)
        let newHead = MediumLinkedListProblems().removeNthFromEnd(head, 1)
        XCTAssertNil(newHead)
    }
    
    func testRemoveNthFromEnd_with2NodesLinkedListAndNIs1_shouldRemoveTheNodeFirstFromLast() {
        let node2 = ListNode(2)
        let head = ListNode(1, node2)
        let newHead = MediumLinkedListProblems().removeNthFromEnd(head, 1)
        
        guard let sureNewHead = newHead else {
            XCTFail("The head is nil")
            return
        }
        
        var resultValues: [Int] = [sureNewHead.val]
        var currentNode: ListNode? = sureNewHead
        
        while let nextNode = currentNode?.next {
            resultValues.append(nextNode.val)
            currentNode = nextNode
        }
        
        XCTAssertEqual(resultValues, [1])
    }
}
