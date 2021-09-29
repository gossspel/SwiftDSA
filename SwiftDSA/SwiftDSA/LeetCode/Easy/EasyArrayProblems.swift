//
//  EasyArrayProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/7/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyArrayProblems {}

// MARK: - 1. Two Sum
// LINK: https://leetcode.com/problems/two-sum/
//
// Description: Given an array of integers nums and an integer target, return indices of the two numbers such that they
// add up to target. You may assume that each input would have exactly one solution, and you may not use the same
// element twice. You can return the answer in any order.
//
// Strategy: Brute force, use 2 d loop to record any indices pair that sum up to target.
//
// Optimized Strategy: loop through the array, insert each element to a set. Loop through the array again and check if
// the set contains the result of (target - element), and make sure the 2 indices aren't identical since we can use the
// same element twice.

extension EasyArrayProblems {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {        
        var indexListByValueDict: [Int: [Int]] = [:]
        
        for i in 0..<nums.count {
            if let indexList = indexListByValueDict[nums[i]] {
                indexListByValueDict[nums[i]] = indexList + [i]
            } else {
                indexListByValueDict[nums[i]] = [i]
            }
        }
        
        for i in 0..<nums.count {
            let result: Int = target - nums[i]
            
            guard let indexList = indexListByValueDict[result] else {
                continue
            }
            
            let filteredIndexList = indexList.filter { $0 != i }
            
            guard let resultIndex = filteredIndexList.first else {
                continue
            }
            
            return [i, resultIndex]
        }
        
        return []
    }
    
    func twoSumOptimized(_ nums: [Int], _ target: Int) -> [Int] {
        var indexByValueDict: [Int: Int] = [:]
        
        for (i, value) in nums.enumerated() {
            indexByValueDict[value] = i
        }
        
        for i in 0..<nums.count {
            let result: Int = target - nums[i]
            
            if let indexOfResult = indexByValueDict[result], i != indexOfResult {
                return [i, indexOfResult]
            }
        }
        
        return []
    }
}


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

// MARK: - 53. Maximum Subarray
// LINK: https://leetcode.com/problems/maximum-subarray/
//
// Description: Given an integer array nums, find the contiguous subarray (containing at least one number) which has
// the largest sum and return its sum.
//
// Strategy: We are looping through the array, and at each iteration, we are basically determining to keep growing the
// existing potentialMaxSubArray or make a new potentialMaxSubArray with the new start.

extension EasyArrayProblems {
    func maxSubArray(_ nums: [Int]) -> Int {
        var sumOfPotentialMaxSubArray: Int = nums[0]
        var sumOfMaxSubArray: Int = sumOfPotentialMaxSubArray
        
        for i in 1..<nums.count {
            sumOfPotentialMaxSubArray = max(sumOfPotentialMaxSubArray + nums[i], nums[i])
            
            if sumOfPotentialMaxSubArray > sumOfMaxSubArray {
                sumOfMaxSubArray = sumOfPotentialMaxSubArray
            }
        }
        
        return sumOfMaxSubArray
    }
}

// MARK: - 121. Best Time to Buy and Sell Stock
// LINK: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
//
// Description: You are given an array prices where prices[i] is the price of a given stock on the ith day. You want to
// maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell
// that stock. Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit,
// return 0.
//
// Strategy:
// Base case: price is an array of 1 element, return 0 because we can only buy, but not sell
// Recursive case: price is an array of n elements, where n >= 2. Get the minPrice of prices[0..<n-1] and maxProfit of
// prices[0..<n-1]. if price[n - 1] - minPrice > maxProfit, return it else return maxProfit. So we just need to build
// the minPrices array and maxProfits array, update them each iteration and return maxProfits[n - 1].

extension EasyArrayProblems {
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else {
            return 0
        }
        
        var minPrices: [Int] = Array(repeating: 0, count: prices.count)
        var maxProfits: [Int] = Array(repeating: 0, count: prices.count)
        
        for (i, price) in prices.enumerated() {
            if i == 0 {
                minPrices[i] = price
                maxProfits[i] = 0
            } else {
                minPrices[i] = min(price, minPrices[i - 1])
                maxProfits[i] = max(price - minPrices[i - 1], maxProfits[i - 1])
            }
        }
        
        return maxProfits[prices.count - 1]
    }
    
    func maxProfitNonDP(_ prices: [Int]) -> Int {
        var minPrice: Int = Int.max
        var maxProfit: Int = 0
        
        for price in prices {
            if price < minPrice {
                minPrice = price
            } else {
                maxProfit = max(maxProfit, price - minPrice)
            }
        }
        
        return maxProfit
    }
}

// MARK: - 136. Single Number
// LINK: https://leetcode.com/problems/single-number/
// VIDEO: https://www.youtube.com/watch?v=krgK0UlfNYY
//
// Description: Given a non-empty array of integers nums, every element appears twice except for one. Find that single
// one. You must implement a solution with a linear runtime complexity and use only constant extra space.
//
// Strategy: In order to do this with O(N) time and O(1) space, we need to take advantage of the XOR operator. In XOR,
// N XOR N = 0; N XOR 0 = N; 0 XOR N = N; 0 XOR 0 = 0; Since getting idential LHS and RHS with an XOR operator would
// yield a zero, we can just link every number up with XOR operators and only the lone single number would be result of
// the massive comparison.

extension EasyArrayProblems {
    func singleNumber(_ nums: [Int]) -> Int {
        var result: Int = 0
        
        for num in nums {
            result ^= num
        }
        
        return result
    }
}

// MARK: - 167. Two Sum II - Input array is sorted
// LINK: https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/
//
// Description: Given an array of integers numbers that is already sorted in non-decreasing order, find two numbers
// such that they add up to a specific target number. Return the indices of the two numbers (1-indexed) as an integer
// array answer of size 2, where 1 <= answer[0] < answer[1] <= numbers.length. The tests are generated such that there
// is exactly one solution. You may not use the same element twice.
//
// Strategy: Since numbers is sorted, we can use two pointer, one left and one right to keep track of the sum. Have the
// left pointer start as the first index, and right pointer start as the last index. If numbers[left] + numbers[right]
// > target, we can decrement right in order to have a lesser value on the numbers[right]. If numbers[left] +
// numbers[right] < target, we can increment left in order o have a greater value on the numbers[left]. If
// numbers[left] + numbers[right] == target, we will return [left, right]. We will repeat this process until left ==
// right.

extension EasyArrayProblems {
    func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
        guard numbers.count > 1 else {
            return []
        }
        
        var left: Int = 0
        var right: Int = numbers.count - 1
        
        while left < right {
            if numbers[left] + numbers[right] > target {
                right -= 1
            } else if numbers[left] + numbers[right] < target {
                left += 1
            } else {
                // NOTE: has to return the (1-indexed) indices
                return [left + 1, right + 1]
            }
        }
        
        return []
    }
}

// MARK: - 217. Contains Duplicate
// LINK: https://leetcode.com/problems/contains-duplicate/
//
// Description: Given an integer array nums, return true if any value appears at least twice in the array, and return
// false if every element is distinct.
//
// Strategy: Init a set with the nums, return nums.count != setNums.count

extension EasyArrayProblems {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        let setNums: Set<Int> = Set(nums)
        return nums.count != setNums.count
    }
}

// MARK: - 252. Meeting Rooms
// LINK: https://leetcode.com/problems/meeting-rooms/
//
// Description: Given an array of meeting time intervals where intervals[i] = [starti, endi], determine if a person
// could attend all meetings.
//
// Concise Strategy:
// - sort all intervals by the beginning (first value)
// - loop through the sortedIntervals, and use a lastEnding pointer, if the beginning of an interval is less than the
// lastEnding pointer, return false, else update the lastEnding pointer
// - return true after finishing the loop

extension EasyArrayProblems {
    func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        let sortedIntervals: [[Int]] = intervals.sorted { $0[0] < $1[0] }
        var lastEnding: Int = 0
        
        for interval in sortedIntervals {
            if interval[0] < lastEnding {
                return false
            }
            
            lastEnding = interval[1]
        }
        
        return true
    }
}
