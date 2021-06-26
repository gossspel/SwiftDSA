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

// MARK: - 34. Find First and Last Position of Element in Sorted Array

extension MediumArrayProblemsTests {
    func testSearchRange_withHappyPathA_shouldReturnCorrectRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 8
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [3, 4])
    }
    
    func testSearchRange_withHappyPathB_shouldReturnCorrectRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 5
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [0, 0])
    }
    
    func testSearchRange_withHappyPathC_shouldReturnCorrectRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 7
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [1, 2])
    }
    
    func testSearchRange_withHappyPathD_shouldReturnCorrectRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 10
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [5, 5])
    }
    
    func testSearchRange_withSadPathA_shouldReturnNotFoundRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 6
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [-1, -1])
    }
    
    func testSearchRange_withSadPathB_shouldReturnNotFoundRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 4
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [-1, -1])
    }
    
    func testSearchRange_withSadPathC_shouldReturnNotFoundRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 9
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [-1, -1])
    }
    
    func testSearchRange_withSadPathD_shouldReturnNotFoundRange() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 11
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [-1, -1])
    }
    
    func testSearchRange_withEmptyPath_shouldReturnNotFoundRange() {
        let nums: [Int] = []
        let target: Int = 0
        let result = MediumArrayProblems().searchRange(nums, target)
        XCTAssertEqual(result, [-1, -1])
    }
}

// MARK: - 39. Combination Sum

class MediumArrayProblems39Tests: XCTestCase {
    func testCombinationSum_with4CandidatesAndValidTarget_shouldReturnCombosArray() {
        let candidates: [Int] = [2, 3, 6, 7]
        let target: Int = 7
        let combos: [[Int]] = MediumArrayProblems().combinationSum(candidates, target)
        XCTAssertEqual(combos, [[2, 2, 3], [7]])
    }
    
    func testCombinationSum_with3CandidatesAndValidTarget_shouldReturnCombosArray() {
        let candidates: [Int] = [2, 3, 5]
        let target: Int = 8
        let combos: [[Int]] = MediumArrayProblems().combinationSum(candidates, target)
        XCTAssertEqual(combos, [[2, 2, 2, 2], [2, 3, 3], [3, 5]])
    }
    
    func testCombinationSum_with1CandidateAndInvalidTarget_shouldReturnEmptyArray() {
        let candidates: [Int] = [2]
        let target: Int = 1
        let combos: [[Int]] = MediumArrayProblems().combinationSum(candidates, target)
        XCTAssert(combos.isEmpty)
    }
    
    func testCombinationSum_with1CandidateAndValidTargetA_shouldReturnCombosArray() {
        let candidates: [Int] = [1]
        let target: Int = 1
        let combos: [[Int]] = MediumArrayProblems().combinationSum(candidates, target)
        XCTAssertEqual(combos, [[1]])
    }
    
    func testCombinationSum_with1CandidateAndValidTargetB_shouldReturnCombosArray() {
        let candidates: [Int] = [1]
        let target: Int = 2
        let combos: [[Int]] = MediumArrayProblems().combinationSum(candidates, target)
        XCTAssertEqual(combos, [[1, 1]])
    }
}

// MARK: - 40. Combination Sum II

class MediumArrayProblems40Tests: XCTestCase {
    func testCombinationSum2_with7CandidatesAndValidTarget_shouldReturnCombosArray() {
        let candidates: [Int] = [10, 1, 2, 7, 6, 1, 5]
        let target: Int = 8
        let combos: [[Int]] = MediumArrayProblems().combinationSum2(candidates, target)
        XCTAssertEqual(combos, [[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]])
    }
    
    func testCombinationSum2_with5CandidatesAndValidTarget_shouldReturnCombosArray() {
        let candidates: [Int] = [2, 5, 2, 1, 2]
        let target: Int = 5
        let combos: [[Int]] = MediumArrayProblems().combinationSum2(candidates, target)
        XCTAssertEqual(combos, [[1, 2, 2], [5]])
    }
    
    func testCombinationSum2_withManyCandidatesAndValidTarget_shouldReturnCombosArray() {
        let candidates: [Int] = [1, 1, 2, 2, 3, 5, 6, 7, 8, 1, 1, 2, 2, 3, 5, 6, 7, 8, 1, 1, 2, 2, 3, 5, 6, 7, 8,
                                 1, 1, 2, 2, 3, 5, 6, 7, 8, 1, 1, 2, 2, 3, 5, 6, 7, 8, 9, 10]
        let target: Int = 100
        let combos: [[Int]] = MediumArrayProblems().combinationSum2(candidates, target)
        XCTAssertEqual(combos.count, 57578)
    }
}

// MARK: - 45. Jump Game II
    
class MediumArrayProblems45Tests: XCTestCase {
    func testJump_withTwoNums_shouldReturn1() {
        let nums = [2, 1]
        let jumpCount = MediumArrayProblems().jump(nums)
        XCTAssertEqual(jumpCount, 1)
    }
    
    func testJump_with5NumsA_shouldReturn2() {
        let nums = [2, 3, 1, 1, 4]
        let jumpCount = MediumArrayProblems().jump(nums)
        XCTAssertEqual(jumpCount, 2)
    }
    
    func testJump_with5NumsB_shouldReturn2() {
        let nums = [2, 3, 0, 1, 4]
        let jumpCount = MediumArrayProblems().jump(nums)
        XCTAssertEqual(jumpCount, 2)
    }
    
    func testJump_withSomeNums_shouldReturn10() {
        let nums = [2, 3, 0, 1, 4, 5, 1, 2, 1, 1, 2, 1, 2, 3, 4, 1, 2, 3, 1, 0, 5, 2, 3, 1, 2, 5, 6, 1, 2, 1, 2]
        let jumpCount = MediumArrayProblems().jump(nums)
        XCTAssertEqual(jumpCount, 10)
    }
}
