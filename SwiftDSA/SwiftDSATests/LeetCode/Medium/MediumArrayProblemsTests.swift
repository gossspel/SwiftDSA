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

// MARK: - 33. Search in Rotated Sorted Array

extension MediumArrayProblemsTests {
    func testBinarySearch_with2ElementsNumsAndTargetNotInNums_shouldReturnNegativeOne() {
        let nums: [Int] = [6, 7]
        let target: Int = 8
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, -1)
    }
    
    func testBinarySearch_with2ElementsNumsAndTargetIsFirstValueInNums_shouldReturnZero() {
        let nums: [Int] = [6, 7]
        let target: Int = 6
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 0)
    }
    
    func testBinarySearch_with2ElementsNumsAndTargetIsSecondValueInNums_shouldReturnOne() {
        let nums: [Int] = [6, 7]
        let target: Int = 7
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 1)
    }
    
    func testBinarySearch_with5ElementsNumsAndTargetNotInNums_shouldReturnNegativeOne() {
        let nums: [Int] = [2, 3, 4, 5, 6]
        let target: Int = 8
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, -1)
    }
    
    func testBinarySearch_with5ElementsNumsAndTargetIsFifthValueInNums_shouldReturnFour() {
        let nums: [Int] = [2, 3, 4, 5, 6]
        let target: Int = 6
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 4)
    }
    
    func testBinarySearch_with5ElementsNumsAndTargetIsSecondValueInNums_shouldReturnOne() {
        let nums: [Int] = [2, 3, 4, 5, 6]
        let target: Int = 3
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 1)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetTooBig_shouldReturnNegativeOne() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 8
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, -1)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetTooSmall_shouldReturnNegativeOne() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 1
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, -1)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetIsFirstValueInNums_shouldReturnZero() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 2
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 0)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetIsSecondValueInNums_shouldReturnOne() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 3
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 1)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetIsThirdValueInNums_shouldReturnTwo() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 4
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 2)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetIsFourthValueInNums_shouldReturnThree() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 5
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 3)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetIsFifthValueInNums_shouldReturnFour() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 6
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 4)
    }
    
    func testBinarySearch_with6ElementsNumsAndTargetIsSixthValueInNums_shouldReturnFive() {
        let nums: [Int] = [2, 3, 4, 5, 6, 7]
        let target: Int = 7
        let result = MediumArrayProblems().binarySearch(nums, target)
        XCTAssertEqual(result, 5)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsZeroAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [0, 1, 2, 3]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 0)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsOneAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [1, 2, 3, 0]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 3)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsTwoAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [2, 3, 0, 1]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 2)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsThreeAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [3, 0, 1, 2]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 1)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsZeroAndTargetIsOne_shouldReturnCorrectIndex() {
        let nums: [Int] = [0, 1, 2, 3]
        let target: Int = 1
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 1)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsOneAndTargetIsOne_shouldReturnCorrectIndex() {
        let nums: [Int] = [1, 2, 3, 0]
        let target: Int = 1
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 0)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsTwoAndTargetIsOne_shouldReturnCorrectIndex() {
        let nums: [Int] = [2, 3, 0, 1]
        let target: Int = 1
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 3)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsThreeAndTargetIsOne_shouldReturnCorrectIndex() {
        let nums: [Int] = [3, 0, 1, 2]
        let target: Int = 1
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 2)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsZeroAndTargetIsTwo_shouldReturnCorrectIndex() {
        let nums: [Int] = [0, 1, 2, 3]
        let target: Int = 2
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 2)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsOneAndTargetIsTwo_shouldReturnCorrectIndex() {
        let nums: [Int] = [1, 2, 3, 0]
        let target: Int = 2
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 1)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsTwoAndTargetIsTwo_shouldReturnCorrectIndex() {
        let nums: [Int] = [2, 3, 0, 1]
        let target: Int = 2
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 0)
    }
    
    func testBinarySpecialSearch_with4ElementsAndPivotIsThreeAndTargetIsTwo_shouldReturnCorrectIndex() {
        let nums: [Int] = [3, 0, 1, 2]
        let target: Int = 2
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 3)
    }
    
    func testBinarySpecialSearch_with5ElementsAndPivotIsZeroAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [0, 1, 2, 3, 4]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 0)
    }
    
    func testBinarySpecialSearch_with5ElementsAndPivotIsOneAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [1, 2, 3, 4, 0]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 4)
    }
    
    func testBinarySpecialSearch_with5ElementsAndPivotIsTwoAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [2, 3, 4, 0, 1]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 3)
    }
    
    func testBinarySpecialSearch_with5ElementsAndPivotIsThreeAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [3, 4, 0, 1, 2]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 2)
    }
    
    func testBinarySpecialSearch_with5ElementsAndPivotIsFourAndTargetIsZero_shouldReturnCorrectIndex() {
        let nums: [Int] = [4, 0, 1, 2, 3]
        let target: Int = 0
        let result = MediumArrayProblems().binarySpecialSearch(nums, target)
        XCTAssertEqual(result, 1)
    }
}