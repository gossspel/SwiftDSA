//
//  MediumArrayProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/15/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumArrayProblems {}

// MARK: - 31. Next Permutation
// LINK: https://leetcode.com/problems/next-permutation/
//
// Description: Implement next permutation, which rearranges numbers into the lexicographically next greater
// permutation of numbers. If such an arrangement is not possible, it must rearrange it as the lowest possible order
// (i.e., sorted in ascending order). The replacement must be in place and use only constant extra memory.
//
// Strategy: Descending numbers are the biggest, ascending numbers are the smallest. If nums.count == 1, we don't have
// to do anything, otherwise, we have to always start processing from the end of the array by using a variable called
// potentialFirstIndex, start by setting potentialFirstIndex = (nums.count - 2). If nums[potentialFirstIndex] ==
// nums[nums.count - 1], decrement potentialFirstIndex, keep decrementing until nums[potentialFirstIndex] !=
// nums[nums.count - 1].
// If nums[potentialFirstIndex] < nums[potentialFirstIndex + 1], we have easy case here in which we need to swap the
// values between potentialFirstIndex and (potentialFirstIndex + 1).
// If nums[potentialFirstIndex] > nums[potentialFirstIndex + 1], we will have to keep track of the last occuring value
// of potentialFirstIndex, and keep decrementing potentialFirstIndex until nums[potentialFirstIndex] <
// nums[lastPotentialFirstIndex]. At that point, we know that nums[lastPotentialFirstIndex..<nums.count] is a
// descending sequence, so we will have to loop through it to find the index of the last element that is bigger than
// nums[potentialFirstIndex]. Once we found indexToSwap, swap the values between potentialFirstIndex and indexToSwap,
// and then sort nums[lastPotentialFirstIndex..<nums.count] in an ascending order.
//
// Non-trivial case example: Consider 5 8 6 4 => 6 4 5 8; 5 8 6 4 = (5) + (8 6 4) in which we want to swap 5 with the
// next smallest value that is bigger than it. Notice that (8 6 4) is programmatically formatted to be descending, so
// we can safely to loop through it and find out 6 is the smallest value that is bigger than 5. Swap the 5 and 6 with
// their indices and we will get (6) + (8 5 4), if we just sort (8 5 4) in ascending order, we would get (4 5 8), in
// which 6 4 5 8 would be the next permutation.

extension MediumArrayProblems {
    func nextPermutation(_ nums: inout [Int]) {
        guard nums.count > 1 else {
            return
        }
        
        let lastIndex: Int = nums.count - 1
        var potentialFirstIndex: Int =  lastIndex - 1
        
        while (potentialFirstIndex > 0) && (nums[potentialFirstIndex] == nums[lastIndex]) {
            potentialFirstIndex -= 1
        }
        
        if nums[potentialFirstIndex] < nums[potentialFirstIndex + 1] {
            let temp: Int = nums[potentialFirstIndex + 1]
            nums[potentialFirstIndex + 1] = nums[potentialFirstIndex]
            nums[potentialFirstIndex] = temp
        } else if nums[potentialFirstIndex] > nums[potentialFirstIndex + 1] {
            var lastPotentialFirstIndex: Int = potentialFirstIndex
            
            while (potentialFirstIndex > 0) && (nums[potentialFirstIndex] >= nums[lastPotentialFirstIndex]) {
                lastPotentialFirstIndex = potentialFirstIndex
                potentialFirstIndex -= 1
            }
            
            var indexToSwap: Int? = nil
            
            for i in (potentialFirstIndex + 1)..<nums.count {
                if nums[i] > nums[potentialFirstIndex] {
                    indexToSwap = i
                }
            }
            
            if let sureIndexToSwap = indexToSwap {
                let temp: Int = nums[potentialFirstIndex]
                nums[potentialFirstIndex] = nums[sureIndexToSwap]
                nums[sureIndexToSwap] = temp
                nums[(potentialFirstIndex + 1)..<nums.count].sort()
            } else {
                nums.reverse()
            }
        }
    }
}

// MARK: - 33. Search in Rotated Sorted Array
// LINK: https://leetcode.com/problems/search-in-rotated-sorted-array/
//
// Descriptions: There is an integer array nums sorted in ascending order (with distinct values).Prior to being passed
// to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array
// is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7]
// might be rotated at pivot index 3 and become [4,5,6,7,0,1,2]. Given the array nums after the rotation and an integer
// target, return the index of target if it is in nums, or -1 if it is not in nums. You must write an algorithm with
// O(log n) runtime complexity.
//
// Strategy: lets call the search method binarySpecialSearch, we should also create a binarySearch method for utility
// purpose. In binarySpecialSearch, if nums[first] <= nums[last], we can just handle the search with binarySearch.
// If nums[first] > nums[last], we will check if nums[midPoint] == target, if it is, return midPoint. if not, we will do
// binarySpecialSearch on nums[0..<midPoint] and on nums[midPoint..<nums.count] and return the max among both, but we
// will have to adjust the index of the result from the right array since it doesn't start from zero.

extension MediumArrayProblems {
    func binarySpecialSearch(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 1 {
            return (target == nums[0]) ? 0 : -1
        }
        
        if nums[0] <= nums[nums.count - 1] {
            return binarySearch(nums, target)
        } else {
            let midPoint = (nums.count - 1) / 2
            
            if nums[midPoint] == target {
                return midPoint
            } else {
                let left: Int = ((midPoint - 1) >= 0) ? binarySpecialSearch(Array(nums[0..<midPoint]), target) : -1
                let right: Int

                if (midPoint + 1) <= (nums.count - 1) {
                    right = binarySpecialSearch(Array(nums[(midPoint + 1)..<nums.count]), target)
                } else {
                    right = -1
                }
                
                let adjustedRight: Int = (right != -1) ? (right + midPoint + 1) : -1
                return max(left, adjustedRight)
            }
        }
    }
    
    func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 1 {
            return (target == nums[0]) ? 0 : -1
        }
        
        var startIndex: Int = 0
        var endIndex: Int = nums.count - 1
        var midPoint: Int = (endIndex + startIndex) / 2
        
        while startIndex <= endIndex {
            if target == nums[midPoint] {
                return midPoint
            } else if target < nums[midPoint] {
                endIndex = midPoint - 1
                midPoint = (startIndex + endIndex) / 2
            } else if target > nums[midPoint] {
                startIndex = midPoint + 1
                midPoint = (startIndex + endIndex) / 2
            }
        }
        
        return -1
    }
}

// MARK: - 34. Find First and Last Position of Element in Sorted Array
// LINK: https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/
//
// Description: Given an array of integers nums sorted in ascending order, find the starting and ending position of a
// given target value. If target is not found in the array, return [-1, -1]. You must write an algorithm with O(log n)
// runtime complexity.
//
// Strategy: Start by trying to do a binary search, let result = [-1, -1]
// If target == nums[midPoint], check nums[midPoint - 1] != target and nums[midPoint + 1] != target, if both are true,
// set start & end = midPoint and return [start, end], else if nums[midPoint - 1] == target, perform searchRange on
// nums[0..<midPoint] and compare the result with the existing one and get the merged max from them. Repeat the same
// for the case in which nums[midPoint + 1] == target
// If target < nums[midPoint], do searchRange on nums[0..<midPoint]
// If target > nums[midPoint], do searchRange on nums[midPoint+1..<nums.count]

extension MediumArrayProblems {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard !nums.isEmpty else {
            return [-1, -1]
        }
        
        if nums.count == 1 {
            return (nums[0] == target) ? [0, 0] : [-1, -1]
        }
        
        var result: [Int] = [-1, -1]
        let midPoint: Int = (nums.count - 1) / 2
        let hasLeftArray: Bool = (midPoint - 1) >= 0
        let hasRightArray: Bool = (midPoint + 1) <= (nums.count - 1)
        
        if target == nums[midPoint] {
            result = [midPoint, midPoint]
            
            if hasLeftArray && (nums[midPoint - 1] == target) {
                let leftArrayResult: [Int] = searchRange(Array(nums[0...(midPoint - 1)]), target)
                result = getMaxRange(rangeA: result, rangeB: leftArrayResult)
            }
            
            if hasRightArray && (nums[midPoint + 1] == target) {
                let rightArrayResult: [Int] = searchRange(Array(nums[(midPoint + 1)...(nums.count - 1)]), target)
                let adjustedRightArrayResult: [Int] = getAdjustedRange(range: rightArrayResult,
                                                                       shiftNStepsToRight: midPoint + 1)
                result = getMaxRange(rangeA: result, rangeB: adjustedRightArrayResult)
            }
            
            return result
        } else if target < nums[midPoint] {
            if hasLeftArray {
                return searchRange(Array(nums[0...(midPoint - 1)]), target)
            } else {
                return result
            }
        } else {
            if hasRightArray {
                let rightArrayResult: [Int] = searchRange(Array(nums[(midPoint + 1)...(nums.count - 1)]), target)
                let adjustedRightArrayResult: [Int] = getAdjustedRange(range: rightArrayResult,
                                                                       shiftNStepsToRight: midPoint + 1)
                return adjustedRightArrayResult
            } else {
                return result
            }
        }
    }
    
    private func getMaxRange(rangeA: [Int], rangeB: [Int]) -> [Int] {
        guard rangeA.count == 2, rangeB.count == 2 else {
            return []
        }
        
        let minValue: Int = min(rangeA[0], rangeB[0])
        let maxValue: Int = max(rangeA[1], rangeB[1])
        return [minValue, maxValue]
    }
    
    private func getAdjustedRange(range: [Int], shiftNStepsToRight: Int) -> [Int] {
        guard range != [-1, -1] else {
            return range
        }
        
        let adjustedRange: [Int] = range.map { $0 + shiftNStepsToRight }
        return adjustedRange
    }
}
