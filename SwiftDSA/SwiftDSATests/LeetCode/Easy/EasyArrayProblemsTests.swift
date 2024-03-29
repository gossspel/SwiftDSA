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

// MARK: - 1. Two Sum

class EasyArrayProblem1Tests: XCTestCase {
    func testTwoSum_with4NumsAndTargetIs9_shouldReturn0And1() {
        let nums = [2,7,11,15]
        let target = 9
        let indices = EasyArrayProblems().twoSum(nums, target)
        XCTAssertEqual(indices, [0, 1])
    }
    
    func testTwoSum_with3NumsAndTargetIs6_shouldReturn0And1() {
        let nums = [3, 2, 4]
        let target = 6
        let indices = EasyArrayProblems().twoSum(nums, target)
        XCTAssertEqual(indices, [1, 2])
    }
    
    func testTwoSum_with2NumsAndTargetIs6_shouldReturn0And1() {
        let nums = [3, 3]
        let target = 6
        let indices = EasyArrayProblems().twoSum(nums, target)
        XCTAssertEqual(indices, [0, 1])
    }
}

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

// MARK: - 53. Maximum Subarray

extension EasyArrayProblemsTests {
    func testMaxSubArray_withHappyPathA_shouldReturnSumOfMaxSubArray() {
        let nums: [Int] = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
        let sumOfMaxSubArray: Int = EasyArrayProblems().maxSubArray(nums)
        XCTAssertEqual(sumOfMaxSubArray, 6)
    }
    
    func testMaxSubArray_withHappyPathB_shouldReturnSumOfMaxSubArray() {
        let nums: [Int] = [5, 4, -1, 7, 8]
        let sumOfMaxSubArray: Int = EasyArrayProblems().maxSubArray(nums)
        XCTAssertEqual(sumOfMaxSubArray, 23)
    }
    
    func testMaxSubArray_withHappyPathC_shouldReturnSumOfMaxSubArray() {
        let nums: [Int] = [-2, 1, -3, 4, -1, 2, 1, -5, 4, 2]
        let sumOfMaxSubArray: Int = EasyArrayProblems().maxSubArray(nums)
        XCTAssertEqual(sumOfMaxSubArray, 7)
    }
    
    func testMaxSubArray_withMinPath_shouldReturnSumOfMaxSubArray() {
        let nums: [Int] = [1]
        let sumOfMaxSubArray: Int = EasyArrayProblems().maxSubArray(nums)
        XCTAssertEqual(sumOfMaxSubArray, 1)
    }
    
    func testMaxSubArray_withAllNegativeElements_shouldReturnMaxOfArray() {
        let nums: [Int] = [-3, -2, -1, -4, -5]
        let sumOfMaxSubArray: Int = EasyArrayProblems().maxSubArray(nums)
        XCTAssertEqual(sumOfMaxSubArray, -1)
    }
    
    func testMaxSubArray_withAllPositiveElements_shouldReturnSumOfArray() {
        let nums: [Int] = [3, 2, 1, 4, 5]
        let sumOfMaxSubArray: Int = EasyArrayProblems().maxSubArray(nums)
        XCTAssertEqual(sumOfMaxSubArray, 15)
    }
}

class EasyArrayProblem121Tests: XCTestCase {
    func testMaxProfit_with1Price_shouldReturn0() {
        let prices: [Int] = [7]
        let maxProfit: Int = EasyArrayProblems().maxProfit(prices)
        XCTAssertEqual(maxProfit, 0)
    }
    
    func testMaxProfit_with2PricesA_shouldReturn6() {
        let prices: [Int] = [1, 7]
        let maxProfit: Int = EasyArrayProblems().maxProfit(prices)
        XCTAssertEqual(maxProfit, 6)
    }
    
    func testMaxProfit_with2PricesB_shouldReturn0() {
        let prices: [Int] = [7, 1]
        let maxProfit: Int = EasyArrayProblems().maxProfit(prices)
        XCTAssertEqual(maxProfit, 0)
    }
    
    func testMaxProfit_with2PricesC_shouldReturn0() {
        let prices: [Int] = [7, 7]
        let maxProfit: Int = EasyArrayProblems().maxProfit(prices)
        XCTAssertEqual(maxProfit, 0)
    }
    
    func testMaxProfit_with6Prices_shouldReturn5() {
        let prices: [Int] = [7, 1, 5, 3, 6, 4]
        let maxProfit: Int = EasyArrayProblems().maxProfit(prices)
        XCTAssertEqual(maxProfit, 5)
    }
    
    func testMaxProfit_with5Prices_shouldReturn0() {
        let prices: [Int] = [7, 6, 4, 3, 1]
        let maxProfit: Int = EasyArrayProblems().maxProfit(prices)
        XCTAssertEqual(maxProfit, 0)
    }
}

// MARK: - 136. Single Number

class EasyArrayProblem136Tests: XCTestCase {
    func testSingleNumber_with3NumsAnd1AsSingleNumber_shouldReturn1() {
        let nums = [2, 2, 1]
        let result = EasyArrayProblems().singleNumber(nums)
        XCTAssertEqual(result, 1)
    }
    
    func testSingleNumber_with5NumsAnd4AsSingleNumber_shouldReturn4() {
        let nums = [4, 1, 2, 1, 2]
        let result = EasyArrayProblems().singleNumber(nums)
        XCTAssertEqual(result, 4)
    }
    
    func testSingleNumber_with1NumAnd1AsSingleNumber_shouldReturn1() {
        let nums = [1]
        let result = EasyArrayProblems().singleNumber(nums)
        XCTAssertEqual(result, 1)
    }
}

// MARK: - 167. Two Sum II - Input array is sorted

class EasyArrayProblem167Tests: XCTestCase {
    func testTwoSum2_with4NumsAndTargetIs9_shouldReturn0And1() {
        let nums = [2,7,11,15]
        let target = 9
        let indices = EasyArrayProblems().twoSum2(nums, target)
        XCTAssertEqual(indices, [1, 2])
    }
    
    func testTwoSum2_with3NumsAndTargetIs6_shouldReturn0And1() {
        let nums = [2, 3, 4]
        let target = 6
        let indices = EasyArrayProblems().twoSum2(nums, target)
        XCTAssertEqual(indices, [1, 3])
    }
    
    func testTwoSum2_with2NumsAndTargetIs6_shouldReturn0And1() {
        let nums = [3, 3]
        let target = 6
        let indices = EasyArrayProblems().twoSum2(nums, target)
        XCTAssertEqual(indices, [1, 2])
    }
}

// MARK: - 217. Contains Duplicate

class EasyArrayProblem217Tests: XCTestCase {
    func testContainDuplicate_with4NumsWithDuplicates_shouldReturnTrue() {
        let nums = [1,2,3,1]
        XCTAssertTrue(EasyArrayProblems().containsDuplicate(nums))
    }
    
    func testContainDuplicate_with4NumsWithoutDuplicates_shouldReturnFalse() {
        let nums = [1,2,3,4]
        XCTAssertFalse(EasyArrayProblems().containsDuplicate(nums))
    }
    
    func testContainDuplicate_with10NumsWithDuplicates_shouldReturnTrue() {
        let nums = [1,1,1,3,3,4,3,2,4,2]
        XCTAssertTrue(EasyArrayProblems().containsDuplicate(nums))
    }
}
