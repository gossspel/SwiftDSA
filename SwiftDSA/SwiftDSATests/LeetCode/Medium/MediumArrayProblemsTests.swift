//
//  MediumArrayProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/17/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

@testable import SwiftDSA
import XCTest

class MediumArrayProblemsTests: XCTestCase {}

// MARK: - 31. Next Permutation

extension MediumArrayProblemsTests {
    func testNextPermutation_withPotentialStartLessThanNextA_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [1, 2, 3]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [1, 3, 2])
    }
    
    func testNextPermutation_withPotentialStartLessThanNextB_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [1, 1, 5]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [1, 5, 1])
    }
    
    func testNextPermutation_withPotentialStartLessThanTheDescendingNumsAfterItA_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [5, 8, 6, 4]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [6, 4, 5, 8])
    }
    
    func testNextPermutation_withPotentialStartLessThanTheDescendingNumsAfterItB_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [5, 8, 5, 4]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [8, 4, 5, 5])
    }
    
    func testNextPermutation_withPotentialStartLessThanTheDescendingNumsAfterItC_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [5, 8, 6, 4, 4]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [6, 4, 4, 5, 8])
    }
    
    func testNextPermutation_withPotentialStartLessThanTheDescendingNumsAfterItD_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [5, 8, 6, 6, 4]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [6, 4, 5, 6, 8])
    }
    
    func testNextPermutation_withPotentialStartLessThanTheDescendingNumsAfterItE_shouldMutateArrayToNextPermutation() {
        var nums: [Int] = [5, 8, 8, 6, 4]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [6, 4, 5, 8, 8])
    }
    
    func testNextPermutation_withDescendingSequence_shouldMutateArrayToAscendingSequence() {
        var nums: [Int] = [3, 2, 1]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [1, 2, 3])
    }
    
    func testNextPermutation_withSingleElementNums_shouldDoNothing() {
        var nums: [Int] = [1]
        MediumArrayProblems().nextPermutation(&nums)
        XCTAssertEqual(nums, [1])
    }
}
