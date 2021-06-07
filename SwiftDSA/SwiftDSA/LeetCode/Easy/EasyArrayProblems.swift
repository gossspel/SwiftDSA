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
// Strategy: Have four vars prev: Int? = nil, current: Int? = nil, maxLength: Int = nums.count,
// numberOfProcessedElement: Int = 0, While (numberOfProcessedElement < maxLength) loop throught the nums array. During
// each iteration, update current with the current value of the loop, compare it with prev, if it is the same, remove
// it and decrement maxLength. At the end of each iteration, update prev with current, increment
// numberOfProcessedElement.

extension EasyArrayProblems {
    static func removeDuplicates(_ nums: inout [Int]) -> Int {
        var prev: Int? = nil
        var current: Int? = nil
        var maxLength: Int = nums.count
        var numberOfProcessedElement: Int = 0
        
        while numberOfProcessedElement < maxLength {
            current = nums[numberOfProcessedElement]
            
            if current == prev {
                let _ = nums.remove(at: numberOfProcessedElement)
                maxLength -= 1
            }
            
            prev = current
            numberOfProcessedElement += 1
        }
        
        return nums.count
    }
}
