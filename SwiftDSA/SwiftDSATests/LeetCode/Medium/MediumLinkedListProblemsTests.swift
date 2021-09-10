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

class MediumLinkedListProblem92Tests: XCTestCase {
    func testReverseBetween_with5NodesLeftIs2RightIs4_shouldReturnLinkedListReversedBetweenPositions2To4() {
        let node5 = ListNode(5)
        let node4 = ListNode(4, node5)
        let node3 = ListNode(3, node4)
        let node2 = ListNode(2, node3)
        let head = ListNode(1, node2)
        let newHead = MediumLinkedListProblems().reverseBetween(head, 2, 4)
        
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
        
        XCTAssertEqual(resultValues, [1, 4, 3, 2, 5])
    }
    
    func testReverseBetween_with5NodesLeftIs1RightIs5_shouldReturnLinkedListReversedBetweenPositions1To5() {
        let node5 = ListNode(5)
        let node4 = ListNode(4, node5)
        let node3 = ListNode(3, node4)
        let node2 = ListNode(2, node3)
        let head = ListNode(1, node2)
        let newHead = MediumLinkedListProblems().reverseBetween(head, 1, 5)
        
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
        
        XCTAssertEqual(resultValues, [5, 4, 3, 2, 1])
    }
    
    func testReverseBetween_with1NodeLeftIs1RightIs1_shouldReturnIdenticalLinkedList() {
        let head = ListNode(5)
        let newHead = MediumLinkedListProblems().reverseBetween(head, 1, 1)
        
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
        
        XCTAssertEqual(resultValues, [5])
    }
}

// MARK: - 138. Copy List with Random Pointer

class MediumLinkedListProblem138Tests: XCTestCase {
    func testCopyRandomList_with3NodesA_shouldReturnHeadOfCopiedList() {
        let node3 = RandomListNode(3)
        let node2 = RandomListNode(3)
        let root = RandomListNode(3)
        root.next = node2
        node2.next = node3
        node2.random = root
        let copiedHead = MediumLinkedListProblems().copyRandomList(root)
        
        var current: RandomListNode? = copiedHead
        var nodes: [RandomListNode] = []
        
        while let sureCurrent = current {
            nodes.append(sureCurrent)
            current = sureCurrent.next
        }
        
        current = copiedHead
        var currentIndex: Int = 0
        
        while let sureCurrent = current {
            let memAddress: String = "\(Unmanaged.passUnretained(sureCurrent).toOpaque())"
            let expectedMemAddress: String = "\(Unmanaged.passUnretained(nodes[currentIndex]).toOpaque())"
            XCTAssertEqual(memAddress, expectedMemAddress)
            
            if currentIndex == 0 {
                let nextMemAddress: String = "\(Unmanaged.passUnretained(sureCurrent.next!).toOpaque())"
                let expectedNextMemAddress: String = "\(Unmanaged.passUnretained(nodes[currentIndex + 1]).toOpaque())"
                XCTAssertEqual(nextMemAddress, expectedNextMemAddress)
                XCTAssertNil(sureCurrent.random)
            } else if currentIndex == 1{
                let nextMemAddress: String = "\(Unmanaged.passUnretained(sureCurrent.next!).toOpaque())"
                let expectedNextMemAddress: String = "\(Unmanaged.passUnretained(nodes[currentIndex + 1]).toOpaque())"
                XCTAssertEqual(nextMemAddress, expectedNextMemAddress)
                
                let randomMemAddress: String = "\(Unmanaged.passUnretained(sureCurrent.random!).toOpaque())"
                let expectedRandomMemAddress: String = "\(Unmanaged.passUnretained(nodes[0]).toOpaque())"
                XCTAssertEqual(randomMemAddress, expectedRandomMemAddress)
            } else if currentIndex == 2 {
                XCTAssertNil(sureCurrent.next)
                XCTAssertNil(sureCurrent.random)
            }
            
            current = sureCurrent.next
            currentIndex += 1
        }
    }
    
    func testCopyRandomList_with0NodesA_shouldReturnNil() {
        let copiedHead = MediumLinkedListProblems().copyRandomList(nil)
        XCTAssertNil(copiedHead)
    }
}

// MARK: - 143. Reorder List

class MediumLinkedListProblem143Tests: XCTestCase {
    func testExample1() {
        let root = ListNode(1)
        root.next = ListNode(2)
        root.next?.next = ListNode(3)
        root.next?.next?.next = ListNode(4)
        
        MediumLinkedListProblems().reorderList(root)
        XCTAssertEqual(root.val, 1)
        XCTAssertEqual(root.next?.val, 4)
        XCTAssertEqual(root.next?.next?.val, 2)
        XCTAssertEqual(root.next?.next?.next?.val, 3)
        
        var nodeValues: [Int] = []
        
        var current: ListNode? = root
        
        while let sureCurrent = current {
            nodeValues.append(sureCurrent.val)
            current = sureCurrent.next
        }
        
        XCTAssertEqual(nodeValues, [1, 4, 2, 3])
    }
}

