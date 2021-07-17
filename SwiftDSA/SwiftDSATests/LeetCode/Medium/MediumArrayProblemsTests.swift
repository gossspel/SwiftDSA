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

// MARK: - 15. 3Sum

class MediumArrayProblem15Tests: XCTestCase {
    func testThreeSum_with6Nums_shouldReturnListOfTwoThreeSums() {
        let nums: [Int] = [-1,0,1,2,-1,-4]
        let threeSums: [[Int]] = MediumArrayProblems().threeSum(nums)
        XCTAssertEqual(threeSums, [[-1,-1,2],[-1,0,1]])
    }
    
    func testThreeSum_with0Nums_shouldReturnEmptyList() {
        let nums: [Int] = []
        let threeSums: [[Int]] = MediumArrayProblems().threeSum(nums)
        XCTAssertEqual(threeSums, [])
    }
    
    func testThreeSum_with1Num_shouldReturnEmptyList() {
        let nums: [Int] = [0]
        let threeSums: [[Int]] = MediumArrayProblems().threeSum(nums)
        XCTAssertEqual(threeSums, [])
    }
    
    func testThreeSum_with3Nums_shouldReturnEmptyList() {
        let nums: [Int] = [0, 0, 0]
        let threeSums: [[Int]] = MediumArrayProblems().threeSum(nums)
        XCTAssertEqual(threeSums, [[0, 0, 0]])
    }
    
    func testThreeSum_with11Nums_shouldReturnListOf9ThreeSums() {
        let nums: [Int] = [-1,0,1,2,-1,-4,-2,-3,3,0,4]
        let threeSums: [[Int]] = MediumArrayProblems().threeSum(nums)
        XCTAssertEqual(threeSums, [[-4,0,4],[-4,1,3],[-3,-1,4],[-3,0,3],[-3,1,2],[-2,-1,3],[-2,0,2],[-1,-1,2],[-1,0,1]])
    }
}

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

class MediumArrayProblem39Tests: XCTestCase {
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

class MediumArrayProblem40Tests: XCTestCase {
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
    
class MediumArrayProblem45Tests: XCTestCase {
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

// MARK: - 46. Permutations

class MediumArrayProblem46Tests: XCTestCase {
    func testPermute_with1Num_shouldReturnCorrectPermutations() {
        let nums = [1]
        let permutations: [[Int]] = MediumArrayProblems().permute(nums)
        XCTAssertEqual(permutations, [[1]])
    }
    
    func testPermute_with2Nums_shouldReturnCorrectPermutations() {
        let nums = [0, 1]
        let permutations: [[Int]] = MediumArrayProblems().permute(nums)
        XCTAssertEqual(permutations, [[0, 1],[1, 0]])
    }
    
    func testPermute_with3Nums_shouldReturnCorrectPermutations() {
        let nums = [1, 2, 3]
        let permutations: [[Int]] = MediumArrayProblems().permute(nums)
        XCTAssertEqual(permutations, [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])
    }
    
    func testPermute_with4Nums_shouldReturnCorrectPermutations() {
        let nums = [1, 2, 3, 4]
        let permutations: [[Int]] = MediumArrayProblems().permute(nums)
        XCTAssertEqual(permutations.count, 24)
    }
    
    func testPermute_with5Nums_shouldReturnCorrectPermutations() {
        let nums = [1, 2, 3, 4, 5]
        let permutations: [[Int]] = MediumArrayProblems().permute(nums)
        XCTAssertEqual(permutations.count, 120)
    }
    
    func testPermute_with6Nums_shouldReturnCorrectPermutations() {
        let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let permutations: [[Int]] = MediumArrayProblems().permute(nums)
        XCTAssertEqual(permutations.count, 362880)
    }
}

// MARK: - 48. Rotate Image

class MediumArrayProblem48Tests: XCTestCase {
    func testRotate_with1x1Matrix_shouldDoNothing() {
        var matrix: [[Int]] = [[1]]
        MediumArrayProblems().rotate(&matrix)
        XCTAssertEqual(matrix, [[1]])
    }
    
    func testRotate_with3x3Matrix_shouldRotateProperly() {
        var matrix: [[Int]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        MediumArrayProblems().rotate(&matrix)
        XCTAssertEqual(matrix, [[7, 4, 1], [8, 5, 2], [9, 6, 3]])
    }
    
    func testRotate_with4x4Matrix_shouldRotateProperly() {
        var matrix: [[Int]] = [[5, 1, 9, 11], [2, 4, 8, 10], [13, 3, 6, 7], [15, 14, 12, 16]]
        MediumArrayProblems().rotate(&matrix)
        XCTAssertEqual(matrix, [[15, 13, 2, 5], [14, 3, 4, 1], [12, 6, 8, 9], [16, 7, 10, 11]])
    }
}

// MARK: - 55. Jump Game
    
class MediumArrayProblem55Tests: XCTestCase {
    func testCanJump_with1NumA_shouldReturnTrue() {
        let nums = [1]
        let canJump = MediumArrayProblems().canJump(nums)
        XCTAssert(canJump)
    }
    
    func testCanJump_with1NumB_shouldReturnTrue() {
        let nums = [0]
        let canJump = MediumArrayProblems().canJump(nums)
        XCTAssert(canJump)
    }
    
    func testCanJump_with5NumsA_shouldReturnTrue() {
        let nums = [2, 3, 1, 1, 4]
        let canJump = MediumArrayProblems().canJump(nums)
        XCTAssert(canJump)
    }
    
    func testCanJump_with5NumsB_shouldReturnTrue() {
        let nums = [3, 2, 1, 0, 4]
        let canJump = MediumArrayProblems().canJump(nums)
        XCTAssertFalse(canJump)
    }
}

// MARK: - 56. Merge Intervals

class MediumArrayProblem56Tests: XCTestCase {
    func testMerge_with4SortedIntervals3MergedIntervals_shouldReturn3MergedIntervals() {
        let intervals: [[Int]] = [[1, 3], [2, 6], [8, 10], [15, 18]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[1, 6], [8, 10], [15, 18]])
    }
    
    func testMerge_with4SortedIntervals2MergedIntervals_shouldReturn2MergedIntervals() {
        let intervals: [[Int]] = [[1, 3], [2, 9], [8, 10], [15, 18]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[1, 10], [15, 18]])
    }
    
    func testMerge_with4UnsortedIntervals3MergedIntervals_shouldReturn3MergedIntervals() {
        let intervals: [[Int]] = [[15, 18], [1, 3], [8, 10], [2, 6]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[1, 6], [8, 10], [15, 18]])
    }
    
    func testMerge_with4UnsortedIntervals2MergedIntervals_shouldReturn2MergedIntervals() {
        let intervals: [[Int]] = [[15, 18], [1, 3], [8, 10], [2, 9]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[1, 10], [15, 18]])
    }
    
    func testMerge_with2SortedIntervals1MergedInterval_shouldReturn1MergedInterval() {
        let intervals: [[Int]] = [[1, 4], [4, 5]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[1, 5]])
    }
    
    func testMerge_with2UnsortedIntervals1MergedInterval_shouldReturn1MergedInterval() {
        let intervals: [[Int]] = [[4, 5], [1, 4]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[1, 5]])
    }
    
    func testMerge_with3UnsortedIntervals1MergedInterval_shouldReturn1MergedInterval() {
        let intervals: [[Int]] = [[1, 4], [0, 2], [3, 5]]
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[0, 5]])
    }
    
    func testMerge_with100000UnsortedIntervals1MergedInterval_shouldReturn1MergedInterval() {
        var testArr: [Int] = [1, 2, 3]
        
        for (i, _) in testArr.enumerated().reversed() {
            testArr.remove(at: i)
        }
        
        var intervals: [[Int]] = []
        
        for i in 0..<100000 {
            intervals += [[0, i], [1, i + 1],  [2, i + 2],  [3, i + 3],  [4, i + 4],  [5, i + 5]]
        }
        
        let mergedIntervals: [[Int]] = MediumArrayProblems().merge(intervals)
        XCTAssertEqual(mergedIntervals, [[0, 100004]])
    }
}

// MARK: - 75. Sort Colors

class MediumArrayProblem75Tests: XCTestCase {
    func testSortColors_with6numsA_shouldSortProperly() {
        var nums: [Int] = [2, 0, 2, 1, 1, 0]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 0, 1, 1, 2, 2])
    }
    
    func testSortColors_with6numsB_shouldSortProperly() {
        var nums: [Int] = [2, 0, 1, 1, 1, 0]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 0, 1, 1, 1, 2])
    }
    
    func testSortColors_with6numsC_shouldSortProperly() {
        var nums: [Int] = [1, 1, 1, 0, 2, 2]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 1, 1, 2, 2])
    }
    
    func testSortColors_with6numsD_shouldSortProperly() {
        var nums: [Int] = [1, 1, 2, 2, 0, 0]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 0, 1, 1, 2, 2])
    }
    
    func testSortColors_with6numsE_shouldSortProperly() {
        var nums: [Int] = [1, 1, 0, 0, 2, 2]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 0, 1, 1, 2, 2])
    }
    
    func testSortColors_with3numsA_shouldSortProperly() {
        var nums: [Int] = [0, 1, 2]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 2])
    }
    
    func testSortColors_with3numsB_shouldSortProperly() {
        var nums: [Int] = [0, 2, 1]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 2])
    }
    
    func testSortColors_with3numsC_shouldSortProperly() {
        var nums: [Int] = [1, 2, 0]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 2])
    }
    
    func testSortColors_with3numsD_shouldSortProperly() {
        var nums: [Int] = [1, 0, 2]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 2])
    }
    
    func testSortColors_with3numsE_shouldSortProperly() {
        var nums: [Int] = [2, 0, 1]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 2])
    }
    
    func testSortColors_with3numsF_shouldSortProperly() {
        var nums: [Int] = [2, 1, 0]
        MediumArrayProblems().sortColors(&nums)
        XCTAssertEqual(nums, [0, 1, 2])
    }
}

// MARK: - 78. Subsets

class MediumArrayProblem78Tests: XCTestCase {
    func testSubsets_with3Nums_shouldReturnCorrectSubset() {
        let nums: [Int] = [1, 2, 3]
        let subsets: [[Int]] = MediumArrayProblems().subsets(nums)
        XCTAssert(subsets.contains([]))
        XCTAssert(subsets.contains([1]))
        XCTAssert(subsets.contains([2]))
        XCTAssert(subsets.contains([3]))
        XCTAssert(subsets.contains([1, 2]))
        XCTAssert(subsets.contains([1, 3]))
        XCTAssert(subsets.contains([2, 3]))
        XCTAssert(subsets.contains([1, 2, 3]))
        XCTAssertEqual(subsets.count, 8)
    }
    
    func testSubsets_with1Num_shouldReturnCorrectSubset() {
        let nums: [Int] = [0]
        let subsets: [[Int]] = MediumArrayProblems().subsets(nums)
        XCTAssert(subsets.contains([]))
        XCTAssert(subsets.contains([0]))
        XCTAssertEqual(subsets.count, 2)
    }
}

// MARK: - 79. Word Search

class MediumArrayProblem79Tests: XCTestCase {
    func testExist_with1x1BoardContainingWord_shouldReturnTrue() {
        let board: [[Character]] = [["A"]]
        let word = "A"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with1x1BoardNotContainingWord_shouldReturnFalse() {
        let board: [[Character]] = [["C"]]
        let word = "A"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with1x2BoardContainingWord_shouldReturnTrue() {
        let board: [[Character]] = [["A"], ["B"]]
        let word = "B"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with1x2BoardNotContainingWord_shouldReturnFalse() {
        let board: [[Character]] = [["C"], ["D"]]
        let word = "A"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with2x1BoardContainingWord_shouldReturnTrue() {
        let board: [[Character]] = [["A", "B"]]
        let word = "A"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with2x1BoardNotContainingWord_shouldReturnFalse() {
        let board: [[Character]] = [["A", "B"]]
        let word = "C"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with3x4BoardAContainingWord_shouldReturnTrue() {
        let word = "ABCCED"
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with3x4BoardBContainingWord_shouldReturnTrue() {
        let word = "SEE"
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssert(exist)
    }
    
    func testExist_with3x4BoardNotContainingWord_shouldReturnFalse() {
        let word = "ABCB"
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssertFalse(exist)
    }
    
    func testExist_with3x10000BoardContainingWord_shouldReturnTrue() {
        var board: [[Character]] = []
        
        for _ in 0..<10000 {
            board += [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        }
        
        let word = "ABCCED"
        let exist = MediumArrayProblems().exist(board, word)
        XCTAssert(exist)
    }
}

// MARK: - 128. Longest Consecutive Sequence

class MediumArrayProblem128Tests: XCTestCase {
    func testLongestConsecutive_with6Nums4LCS_shouldReturn4() {
        let nums = [100,4,200,1,3,2]
        let LCS = MediumArrayProblems().longestConsecutive(nums)
        XCTAssertEqual(LCS, 4)
    }
    
    func testLongestConsecutive_with10Nums9LCS_shouldReturn9() {
        let nums = [0,3,7,2,5,8,4,6,0,1]
        let LCS = MediumArrayProblems().longestConsecutive(nums)
        XCTAssertEqual(LCS, 9)
    }
    
    func testLongestConsecutive_with0Nums0LCS_shouldReturn0() {
        let nums: [Int] = []
        let LCS = MediumArrayProblems().longestConsecutive(nums)
        XCTAssertEqual(LCS, 0)
    }
    
    func testLongestConsecutive_with1Num1LCS_shouldReturn1() {
        let nums = [1]
        let LCS = MediumArrayProblems().longestConsecutive(nums)
        XCTAssertEqual(LCS, 1)
    }
}
