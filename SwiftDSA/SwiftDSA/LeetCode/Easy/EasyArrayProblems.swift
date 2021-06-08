//
//  EasyArrayProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/7/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyArrayProblems {}

// MARK: - 26. Remove Duplicates from Sorted Array
// LINK: https://leetcode.com/problems/remove-duplicates-from-sorted-array/
//
// Description: Given a sorted array nums, remove the duplicates in-place such that each element appears only once and
// returns the new length. Do not allocate extra space for another array, you must do this by modifying the input array
// in-place with O(1) extra memory.
//
// Strategy: Have four vars prev: Int? = nil, current: Int? = nil, maxLength: Int = nums.count, next: Int = 0,
// while (next < maxLength) loop throught the nums array. During each iteration, update current with the current value
// of the loop, compare it with prev, if it is the same, remove it and decrement maxLength, else increment next. At the
// end of each iteration, update prev with current.

extension EasyArrayProblems {
    static func removeDuplicates(_ nums: inout [Int]) -> Int {
        var prev: Int? = nil
        var current: Int? = nil
        var maxLength: Int = nums.count
        var next: Int = 0
        
        while next < maxLength {
            current = nums[next]
            
            if current == prev {
                let _ = nums.remove(at: next)
                maxLength -= 1
            } else {
                next += 1
            }
            
            prev = current
        }
        
        return nums.count
    }
    
    // OptimizedStrategy: Loop through the array, basically update the left y elements of the array with sorted unique
    // values as we loop through the array, where y is the size of the array with duplicates removed. After that,
    // remove the last (x - y) element of the array, where x is the size of the original array.
}
