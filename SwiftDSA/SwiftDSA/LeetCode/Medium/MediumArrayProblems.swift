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
