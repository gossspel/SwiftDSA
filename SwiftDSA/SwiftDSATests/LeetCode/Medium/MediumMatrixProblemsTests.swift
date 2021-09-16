//
//  MediumMatrixProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 9/16/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class MediumMatrixProblemsTests: XCTestCase {}

// MARK: - 79. Word Search

class MediumMatrixProblem79Tests: XCTestCase {
    func testExist_with1x1BoardContainingWord_shouldReturnTrue() {
        let board: [[Character]] = [["A"]]
        let word = "A"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with1x1BoardNotContainingWord_shouldReturnFalse() {
        let board: [[Character]] = [["C"]]
        let word = "A"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with1x2BoardContainingWord_shouldReturnTrue() {
        let board: [[Character]] = [["A"], ["B"]]
        let word = "B"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with1x2BoardNotContainingWord_shouldReturnFalse() {
        let board: [[Character]] = [["C"], ["D"]]
        let word = "A"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with2x1BoardContainingWord_shouldReturnTrue() {
        let board: [[Character]] = [["A", "B"]]
        let word = "A"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with2x1BoardNotContainingWord_shouldReturnFalse() {
        let board: [[Character]] = [["A", "B"]]
        let word = "C"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with3x4BoardAContainingWord_shouldReturnTrue() {
        let word = "ABCCED"
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with3x4BoardBContainingWord_shouldReturnTrue() {
        let word = "SEE"
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with3x4BoardNotContainingWord_shouldReturnFalse() {
        let word = "ABCB"
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with3x10000BoardContainingWord_shouldReturnTrue() {
        var board: [[Character]] = []
        
        for _ in 0..<10000 {
            board += [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        }
        
        let word = "ABCCED"
        let exist = MediumMatrixProblems().exist(board, word)
        XCTAssert(exist)
    }
}
