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

// MARK: - 101. Symmetric Tree

class EasyTreeProblem101Tests: XCTestCase {
    func testIsSymmetric_with7NodesSymmetricTree_shouldReturnTrue() {
        let node7 = TreeNode(3)
        let node6 = TreeNode(4)
        let node5 = TreeNode(4)
        let node4 = TreeNode(3)
        let node3 = TreeNode(2, node6, node7)
        let node2 = TreeNode(2, node4, node5)
        let root = TreeNode(1, node2, node3)
        XCTAssertTrue(EasyTreeProblems().isSymmetric(root))
    }
    
    func testIsSymmetric_with5NodesAsymmetricTree_shouldReturnTrue() {
        let node7 = TreeNode(3)
        let node5 = TreeNode(3)
        let node3 = TreeNode(2, nil, node7)
        let node2 = TreeNode(2, nil, node5)
        let root = TreeNode(1, node2, node3)
        XCTAssertFalse(EasyTreeProblems().isSymmetric(root))
    }
    
    func testIsSymmetric_with5NodesSymmetricTreeA_shouldReturnTrue() {
        let node7 = TreeNode(3)
        let node4 = TreeNode(3)
        let node3 = TreeNode(2, nil, node7)
        let node2 = TreeNode(2, node4, nil)
        let root = TreeNode(1, node2, node3)
        XCTAssertTrue(EasyTreeProblems().isSymmetric(root))
    }
    
    func testIsSymmetric_with5NodesSymmetricTreeB_shouldReturnTrue() {
        let node6 = TreeNode(3)
        let node5 = TreeNode(3)
        let node3 = TreeNode(2, node6, nil)
        let node2 = TreeNode(2, nil, node5)
        let root = TreeNode(1, node2, node3)
        XCTAssertTrue(EasyTreeProblems().isSymmetric(root))
    }
    
    func testIsSymmetric_with1NodeSymmetricTree_shouldReturnTrue() {
        let root = TreeNode(1)
        XCTAssertTrue(EasyTreeProblems().isSymmetric(root))
    }
}

// MARK: - 104. Maximum Depth of Binary Tree

class EasyTreeProblem104Tests: XCTestCase {
    func testMaxDepth_with5Nodes3Levels_shouldReturn3() {
        let node7 = TreeNode(7)
        let node6 = TreeNode(15)
        let node3 = TreeNode(20, node6, node7)
        let node2 = TreeNode(2, nil, nil)
        let root = TreeNode(1, node2, node3)
        let maxLevels: Int = EasyTreeProblems().maxDepth(root)
        XCTAssertEqual(maxLevels, 3)
    }
    
    func testMaxDepth_with2Nodes2Levels_shouldReturn3() {
        let node3 = TreeNode(2, nil, nil)
        let root = TreeNode(1, nil, node3)
        let maxLevels: Int = EasyTreeProblems().maxDepth(root)
        XCTAssertEqual(maxLevels, 2)
    }
    
    func testMaxDepth_with0Nodes0Levels_shouldReturn0() {
        let maxLevels: Int = EasyTreeProblems().maxDepth(nil)
        XCTAssertEqual(maxLevels, 0)
    }
    
    func testMaxDepth_with1Node1Level_shouldReturn1() {
        let root = TreeNode(1, nil, nil)
        let maxLevels: Int = EasyTreeProblems().maxDepth(root)
        XCTAssertEqual(maxLevels, 1)
    }
}
