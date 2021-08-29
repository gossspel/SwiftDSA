//
//  MediumTreeProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class MediumTreeProblemsTests: XCTestCase {}

// MARK: - 102. Binary Tree Level Order Traversal

extension MediumTreeProblemsTests {
    func testLevelOrder_withThreeLevelsA_shouldReturnCorrectTraversalSequence() {
        let node5 = TreeNode(7)
        let node4 = TreeNode(15)
        let node3 = TreeNode(20, node4, node5)
        let node2 = TreeNode(9)
        let root = TreeNode(3, node2, node3)
        let results = MediumTreeProblems().levelOrder(root)
        XCTAssertEqual(results, [[3], [9, 20], [15, 7]])
    }
    
    func testLevelOrder_withThreeLevelsB_shouldReturnCorrectTraversalSequence() {
        let node5 = TreeNode(7)
        let node4 = TreeNode(15)
        let node3 = TreeNode(20, node4, nil)
        let node2 = TreeNode(9, node5, nil)
        let root = TreeNode(3, node2, node3)
        let results = MediumTreeProblems().levelOrder(root)
        XCTAssertEqual(results, [[3], [9, 20], [7, 15]])
    }
    
    func testLevelOrder_withOneLevel_shouldReturnSingleElementInDoubleArray() {
        let root = TreeNode(1)
        let results = MediumTreeProblems().levelOrder(root)
        XCTAssertEqual(results, [[1]])
    }
    
    func testLevelOrder_withNil_shouldReturnEmptyArray() {
        let results = MediumTreeProblems().levelOrder(nil)
        XCTAssertEqual(results, [])
    }
}

// MARK: - 211. Design Add and Search Words Data Structure

class MediumTreeProblem211Tests: XCTestCase {
    func testLong() {
        let dict = WordDictionary()
        dict.addWord("a")
        dict.addWord("ab")
        XCTAssertTrue(dict.search("a"))
        XCTAssertTrue(dict.search("a."))
        XCTAssertTrue(dict.search("ab"))
        XCTAssertFalse(dict.search(".a"))
        XCTAssertTrue(dict.search(".b"))
        XCTAssertFalse(dict.search("ab."))
        XCTAssertTrue(dict.search("."))
        XCTAssertTrue(dict.search(".."))
    }
}

