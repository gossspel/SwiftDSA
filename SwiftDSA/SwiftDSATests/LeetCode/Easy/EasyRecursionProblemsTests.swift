//
//  EasyRecursionProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/20/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class EasyRecursionProblemsTests: XCTestCase {}

// MARK: - 70. Climbing Stairs

extension EasyRecursionProblemsTests {
    func testClimbStairs_withNIsOne_shouldReturnOneWay() {
        let n: Int = 1
        let ways: Int = EasyRecursionProblems().climbStairs(n)
        XCTAssertEqual(ways, 1)
    }
    
    func testClimbStairs_withNIsTwo_shouldReturnTwoWays() {
        let n: Int = 2
        let ways: Int = EasyRecursionProblems().climbStairs(n)
        XCTAssertEqual(ways, 2)
    }
    
    func testClimbStairs_withNIsThree_shouldReturnThreeWays() {
        let n: Int = 3
        let ways: Int = EasyRecursionProblems().climbStairs(n)
        XCTAssertEqual(ways, 3)
    }
    
    func testClimbStairs_withNIsFour_shouldReturnFiveWays() {
        let n: Int = 4
        let ways: Int = EasyRecursionProblems().climbStairs(n)
        XCTAssertEqual(ways, 5)
    }
    
    func testClimbStairs_withNIsFive_shouldReturnEightWays() {
        let n: Int = 5
        let ways: Int = EasyRecursionProblems().climbStairs(n)
        XCTAssertEqual(ways, 8)
    }
    
    func testClimbStairs_withNIsSix_shouldReturnThirteenWays() {
        let n: Int = 6
        let ways: Int = EasyRecursionProblems().climbStairs(n)
        XCTAssertEqual(ways, 13)
    }
}
