//
//  EasyArrayProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/7/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

@testable import SwiftDSA
import XCTest

class EasyArrayProblemsTests: XCTestCase {}

// MARK: - 26. Remove Duplicates from Sorted Array

extension EasyArrayProblemsTests {
    func testRemoveDuplicates_withSortedArrayWithOneDuplicatedElement_shouldReturnTwo() {
        var nums: [Int] = [1, 1, 2]
        let resultLength: Int = EasyArrayProblems.removeDuplicates(&nums)
        let expectedResult: [Int] = [1, 2]
        
        XCTAssertEqual(resultLength, expectedResult.count)
        XCTAssertEqual(nums.count, expectedResult.count)
        
        for (i, _) in expectedResult.enumerated() {
            XCTAssertEqual(nums[i], expectedResult[i])
        }
    }
    
    func testRemoveDuplicates_withSortedArrayWithFiveDuplicatedElements_shouldReturnFive() {
        var nums: [Int] = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
        let resultLength: Int = EasyArrayProblems.removeDuplicates(&nums)
        let expectedResult: [Int] = [0, 1, 2, 3, 4]
        
        XCTAssertEqual(resultLength, expectedResult.count)
        XCTAssertEqual(nums.count, expectedResult.count)
        
        for (i, _) in expectedResult.enumerated() {
            XCTAssertEqual(nums[i], expectedResult[i])
        }
    }
}
