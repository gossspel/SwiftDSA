//
//  MediumDynamicProgrammingProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 7/4/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

// MARK: - 62. Unique Paths

class MediumDynamicProgrammingProblem62Tests: XCTestCase {
    func testUniquePaths_with1by1_shouldReturn1() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(1, 1)
        XCTAssertEqual(uniquePaths, 1)
    }
    
    func testUniquePaths_with3by1_shouldReturn1() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(3, 1)
        XCTAssertEqual(uniquePaths, 1)
    }
    
    func testUniquePaths_with1by3_shouldReturn1() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(1, 3)
        XCTAssertEqual(uniquePaths, 1)
    }
    
    func testUniquePaths_with3by2_shouldReturn3() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(3, 2)
        XCTAssertEqual(uniquePaths, 3)
    }
    
    func testUniquePaths_with7by3_shouldReturn28() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(7, 3)
        XCTAssertEqual(uniquePaths, 28)
    }
    
    func testUniquePaths_with3by7_shouldReturn28() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(3, 7)
        XCTAssertEqual(uniquePaths, 28)
    }
    
    func testUniquePaths_with3by3_shouldReturn6() {
        let uniquePaths: Int = MediumDynamicProgrammingProblems().uniquePaths(3, 3)
        XCTAssertEqual(uniquePaths, 6)
    }
}

// MARK: - 64. Minimum Path Sum

class MediumDynamicProgrammingProblem64Tests: XCTestCase {
    func testMinPathSum_with3x3grid_shouldReturn7() {
        let grid: [[Int]] = [[1, 3, 1], [1, 5, 1], [4, 2, 1]]
        let minPathSum: Int = MediumDynamicProgrammingProblems().minPathSum(grid)
        XCTAssertEqual(minPathSum, 7)
    }
    
    func testMinPathSum_with3x2grid_shouldReturn12() {
        let grid: [[Int]] = [[1, 2, 3], [4, 5, 6]]
        let minPathSum: Int = MediumDynamicProgrammingProblems().minPathSum(grid)
        XCTAssertEqual(minPathSum, 12)
    }
    
    func testMinPathSum_with1x3grid_shouldReturn6() {
        let grid: [[Int]] = [[1, 2, 3]]
        let minPathSum: Int = MediumDynamicProgrammingProblems().minPathSum(grid)
        XCTAssertEqual(minPathSum, 6)
    }
    
    func testMinPathSum_with3x1grid_shouldReturn15() {
        let grid: [[Int]] = [[4], [5], [6]]
        let minPathSum: Int = MediumDynamicProgrammingProblems().minPathSum(grid)
        XCTAssertEqual(minPathSum, 15)
    }
    
    func testMinPathSum_with1x1grid_shouldReturn4() {
        let grid: [[Int]] = [[4]]
        let minPathSum: Int = MediumDynamicProgrammingProblems().minPathSum(grid)
        XCTAssertEqual(minPathSum, 4)
    }
}
