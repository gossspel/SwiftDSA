//
//  EasyTreeProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class EasyTreeProblemsTests: XCTestCase {}

// MARK: - 94. Binary Tree Inorder Traversal

extension EasyTreeProblemsTests {
    func testInOrderTraversal_withNil_shouldReturnEmptyArray() {
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(nil)
        XCTAssertTrue(traversalSequence.isEmpty)
    }
    
    func testInOrderTraversal_withOneNodeTree_shouldReturnOneElementArrayWithSameValue() {
        let root = TreeNode(1)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [1])
    }
    
    func testInOrderTraversal_withTwoNodesTreeA_shouldReturnInOrderTraversalSequence() {
        let node2 = TreeNode(2)
        let root = TreeNode(1, node2, nil)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [2, 1])
    }
    
    func testInOrderTraversal_withTwoNodesTreeB_shouldReturnInOrderTraversalSequence() {
        let node2 = TreeNode(2)
        let root = TreeNode(1, nil, node2)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [1, 2])
    }
    
    func testInOrderTraversal_withThreeNodesTreeA_shouldReturnInOrderTraversalSequence() {
        let node3 = TreeNode(3)
        let node2 = TreeNode(2, node3, nil)
        let root = TreeNode(1, nil, node2)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [1, 3, 2])
    }
    
    func testInOrderTraversal_withThreeNodesTreeB_shouldReturnInOrderTraversalSequence() {
        let node3 = TreeNode(3)
        let node2 = TreeNode(2, nil, node3)
        let root = TreeNode(1, nil, node2)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [1, 2, 3])
    }
    
    func testInOrderTraversal_withThreeNodesTreeC_shouldReturnInOrderTraversalSequence() {
        let node3 = TreeNode(3)
        let node2 = TreeNode(2, node3, nil)
        let root = TreeNode(1, node2, nil)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [3, 2, 1])
    }
    
    func testInOrderTraversal_withThreeNodesTreeD_shouldReturnInOrderTraversalSequence() {
        let node3 = TreeNode(3)
        let node2 = TreeNode(2, nil, node3)
        let root = TreeNode(1, node2, nil)
        let traversalSequence: [Int] = EasyTreeProblems().inorderTraversal(root)
        XCTAssertEqual(traversalSequence, [2, 3, 1])
    }
}
