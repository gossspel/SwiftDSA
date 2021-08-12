//
//  MediumArrayProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/15/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumArrayProblems {
    var hasFoundWord: Bool = false
}

// MARK: - 11. Container With Most Water
// LINK: https://leetcode.com/problems/container-with-most-water/
//
// Description: Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n
// vertical lines are drawn such that the two endpoints of the line i is at (i, ai) and (i, 0). Find two lines, which,
// together with the x-axis forms a container, such that the container contains the most water. Notice that you may not
// slant the container.
//
// Strategy: Use a left and right pointer approach. Use the left most line and right most line as the starting point,
// measure the area between them, if leftHeight < rightHeight, increment leftIndex by 1; if leftHeight > rightHeight,
// decrement rightIndex by 1; if leftHeight == rightHeight, increment leftIndex by 1 and decrement rightIndex by 1;
// Continue as long as leftIndex < rightIndex. The rationale of this approach is that we are always trying to produce a
// higher maxArea by pruning the bar with lower height.

extension MediumArrayProblems {
    func maxArea(_ height: [Int]) -> Int {
        var maxArea: Int = -1
        var leftIndex: Int = 0
        var rightIndex: Int = height.count - 1
        
        while leftIndex < rightIndex {
            maxArea = max(maxArea, min(height[leftIndex], height[rightIndex]) * (rightIndex - leftIndex))
            
            if height[leftIndex] < height[rightIndex] {
                leftIndex += 1
            } else if height[leftIndex] > height[rightIndex] {
                rightIndex -= 1
            } else {
                leftIndex += 1
                rightIndex -= 1
            }
        }
        
        return maxArea
    }
    
    // Strategy: Use brute force with 2 dimensional loop, calculate the area of water of each beginning line, use a
    // variable maxHeight to keep track of the maxHeight of the beginning line, use another variable maxArea to keep
    // track of the maxArea. In the next iteration of the outer loop, only proceed if the height of the next beginning
    // line is greater than maxHeight, and update maxHeight to it. After everything finishes, return maxArea.
    func maxAreaSlow(_ height: [Int]) -> Int {
        var maxHeight: Int = -1
        var maxArea: Int = -1
        
        for i in 0..<(height.count - 1) {
            guard height[i] > maxHeight else {
                continue
            }
            
            maxHeight = height[i]
            
            for j in (i + 1)..<(height.count) {
                maxArea = max((j - i) * min(height[i], height[j]), maxArea)
            }
        }
        
        return maxArea
    }
}

// MARK: - 15. 3Sum
// LINK: https://leetcode.com/problems/3sum/
//
// Description: Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i !=
// k, and j != k, and nums[i] + nums[j] + nums[k] == 0. Notice that the solution set must not contain duplicate
// triplets.
//
// [-1,0,1,2,-1,-4] = > [-4, -1, -1, 0, 1, 2]
//                            ^            ^
//                         left            right
//
// Strategy: Since this is not asking us to return the list of index pair, we can probably take advantage of it and
// sort the array in order to prune the repeated cases. We can loop through nums with an enumerated for loop to get its
// index and value in each iteration. After picking up the first number, we just have to find the two sum in which b +
// c = -a with the rest of the numbers. Since the numbers are sorted, we can use the left and right pointer approach.
// let left start as (i + 1) and right start as (nums.count - 1). Continue the loop as long as left < right. If value +
// sortedNums[left] + sortedNums[right] = 0, add [value, sortedNums[left], sortedNums[right]) into the result and keep
// incrementing left until sortedNums[newleft] > sortedNums[left], and make sure left < right in order to avoid
// duplicated combos. For the next iteration of the for loop, make sure sortedNums[i] != sortedNums[i - 1] since we
// want to avoid repeated elements. Continue the initial for loop until its value is greater than zero, because at that
// point, both b and c will positive numbers and there will be no more combinations that would sum up to zero.

extension MediumArrayProblems {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var results: [[Int]] = []
        let sortedNums: [Int] = nums.sorted()
        
        for (i, value) in sortedNums.enumerated() {
            if value > 0 {
                return results
            }
            
            if i != 0, sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            
            var left: Int = i + 1
            var right: Int = sortedNums.count - 1
            
            while left < right {
                if value + sortedNums[left] + sortedNums[right] == 0 {
                    results.append([value, sortedNums[left], sortedNums[right]])
                    left += 1
                    
                    while sortedNums[left - 1] == sortedNums[left], left < right {
                        left += 1
                    }
                } else if value + sortedNums[left] + sortedNums[right] > 0 {
                    right -= 1
                } else {
                    left += 1
                }
            }
        }
        
        return results
    }
}

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

// MARK: - 39. Combination Sum
// LINK: https://leetcode.com/problems/combination-sum/
//
// Description: Given an array of distinct integers candidates and a target integer target, return a list of all unique
// combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order. The
// same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency
// of at least one of the chosen numbers is different.It is guaranteed that the number of unique combinations that sum
// up to target is less than 150 combinations for the given input.
//
// Strategy: use backtracking, a form of recursion in which we handle the leafNode (if target <= 0) and return. For
// non-leafNode, we recursively call backtracking to break down the non-leafNode to eventually get to the leafNode.
// https://www.cis.upenn.edu/~matuszek/cit594-2012/Pages/backtracking.html
//
// [2, 3, 5], target = 8
// 2
// 2 2
// 2 2 2
// 2 2 2 2
// 2 2 2 3
// 2 2 2 5
// 2 2 3
// 2 2 3 3
// 2 2 5
// 2 3
// 2 3 3
// 2 5
// 2 5 5
// 3
// 3 3
// 3 3 3
// 3 5
// 5
// 5 5

extension MediumArrayProblems {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var combos: [[Int]] = []
        backtrack(candidates: candidates, combos: &combos, target: target, inProgressCombo: [], indexOfCandidates: 0)
        return combos
    }
    
    func backtrack(candidates: [Int],
                   combos: inout [[Int]],
                   target: Int,
                   inProgressCombo: [Int],
                   indexOfCandidates: Int)
    {
        if target <= 0 {
            if target == 0 {
                combos.append(inProgressCombo)
            }
        } else {
            for i in indexOfCandidates..<candidates.count {
                guard candidates[i] <= target else {
                    return
                }
                
                backtrack(candidates: candidates,
                          combos: &combos,
                          target: target - candidates[i],
                          inProgressCombo: inProgressCombo + [candidates[i]],
                          indexOfCandidates: i)
            }
            
            // backtrackA backtrack(target: 8, inProgressCombo: [], indexOfCandidates: 0)
            // backtrackB backtrack(target: 6, inProgressCombo: [2], indexOfCandidates: 0)
            // backtrackC backtrack(target: 4, inProgressCombo: [2, 2], indexOfCandidates: 0)
            // backtrackD backtrack(target: 2, inProgressCombo: [2, 2, 2], indexOfCandidates: 0)
            // backtrackE backtrack(target: 0, inProgressCombo: [2, 2, 2, 2], indexOfCandidates: 0)
            // backtrackE returns, continue execution on backtrackD
            // backtrackF backtrack(target: -1, inProgressCombo: [2, 2, 2, 3], indexOfCandidates: 1)
            // backtrackF returns, continue execution on backtrackD
            // backtrackG backtrack(target: -3, inProgressCombo: [2, 2, 2, 5], indexOfCandidates: 2)
            // backtrackG returns, backtrackD returns, continue execution on backtrackC
            // backtrackH backtrack(target: 1, inProgressCombo: [2, 2, 3], indexOfCandidates: 1)
            // backtrackI backtrack(target: -2, inProgressCombo: [2, 2, 3, 3], indexOfCandidates: 1)
            // backtrackI returns, continue execution on backtrackC
            // .... keeps going until backtrackA returns.
        }
    }
    
    // Sunny Special
    // Strategy: First sort the array, then loop through the array with each candidate, find all possible combination
    // sums with only one candidate, and then find all possible combintation sums with only 2 candidates, repeat and
    // until we proceed to find all possible combination sums with n candidates, where n = target/candidate. After that
    // we move to the next iteration of candidate and repeat the process until everything is finished.
    //
    // [1, 2, 3], target = 8
    // combination with 1 1. => result of combinationSum([2, 3], 7).map { [1] + $0 }
    // combination with 2 1s. => result of combinationSum([2, 3], 6).map { [1, 1] + $0 }
    // ...
    // combination with target/1 1s => result of combinationSum([2, 3], 0).map { [1, 1, 1, 1, 1, 1, 1, 1] + $0 }
    // combination with 1 2. => result of combinationSum([3], 6).map { [2] + $0 }
    // combination with 2 2s. => result of combinationSum([3], 4).map { [2, 2] + $0 }
    func combinationSumSunny(_ candidates: [Int], _ target: Int) -> [[Int]] {
        guard !candidates.isEmpty else {
            return []
        }

        if candidates.count == 1 {
            if target % candidates[0] == 0 {
                let sum = [Array(repeating: candidates[0], count: target / candidates[0])]
                return sum
            } else {
                return []
            }
        }

        var results: [[Int]] = []
        let sortedCandidates: [Int] = candidates.sorted()

        for i in 0..<sortedCandidates.count {
            guard target / sortedCandidates[i] >= 1 else {
                continue
            }

            for j in 1...(target / sortedCandidates[i]) {
                if j == (target / sortedCandidates[i]) {
                    if (sortedCandidates[i] * j) == target {
                        let repeatingElements: [Int] = Array(repeating: sortedCandidates[i], count: j)
                        results.append(repeatingElements)
                    }
                } else {
                    guard (i + 1) < sortedCandidates.count else {
                        continue
                    }

                    let subCandidates: [Int] = Array(sortedCandidates[(i + 1)..<sortedCandidates.count])
                    let subTarget: Int = target - (sortedCandidates[i] * j)
                    let incompleteCurrentResults: [[Int]] = combinationSum(subCandidates, subTarget)

                    guard !incompleteCurrentResults.isEmpty else {
                        continue
                    }

                    let repeatingElements: [Int] = Array(repeating: sortedCandidates[i], count: j)
                    let currentResults: [[Int]] = incompleteCurrentResults.map { repeatingElements + $0 }
                    results += currentResults
                }
            }
        }

        return results
    }
}

// MARK: - 40. Combination Sum II
// LINK: https://leetcode.com/problems/combination-sum-ii/
//
// Description: Given a collection of candidate numbers (candidates) and a target number (target), find all unique
// combinations in candidates where the candidate numbers sum to target. Each number in candidates may only be used
// once in the combination. Note: The solution set must not contain duplicate combinations.
//
// Strategy: use backtracking, a form of recursion in which we handle the leafNode (if target <= 0) and return. For
// non-leafNode, we recursively call backtracking to break down the non-leafNode to eventually get to the leafNode.
// https://www.cis.upenn.edu/~matuszek/cit594-2012/Pages/backtracking.html
//

extension MediumArrayProblems {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let potentialComboElements: [Int] = candidates.sorted()
        var combos: [[Int]] = []
        var inProgressCombo: [Int] = []
        backtrack2(candidates: candidates,
                   inProgressCombo: &inProgressCombo,
                   potentialComboElements: potentialComboElements,
                   combos: &combos,
                   target: target)
        return combos
    }
    
    func backtrack2(candidates: [Int],
                    inProgressCombo: inout [Int],
                    potentialComboElements: [Int],
                    combos: inout [[Int]],
                    target: Int)
    {
        if target == 0 {
            combos.append(inProgressCombo)
            return
        }
        
        if (target < 0) || potentialComboElements.isEmpty {
            return
        }
        
        for i in 0..<potentialComboElements.count {
            // NOTE: since potentialComboElements has been sorted by combinationSum2, no point to recur if its current
            // element is greater than target because we know none of those path would end up with valid combo.
            // For example, it is obvious that in candidates = [3, 3, 4, 5], target = 1 has no valid combo.
            guard potentialComboElements[i] <= target else {
                return
            }
            
            // NOTE: skip backtracking the redundant element
            if ((i - 1) > -1) && potentialComboElements[i] == potentialComboElements[i - 1] {
                continue
            }
            
            let nextPCEs: [Int]
            
            if ((i + 1) < potentialComboElements.count) {
                nextPCEs = Array(potentialComboElements[(i + 1)..<potentialComboElements.count])
            } else {
                nextPCEs = []
            }
            
            inProgressCombo.append(potentialComboElements[i])
            backtrack2(candidates: candidates,
                       inProgressCombo: &inProgressCombo,
                       potentialComboElements: nextPCEs,
                       combos: &combos,
                       target: target - potentialComboElements[i])
            inProgressCombo.removeLast()
        }
        
        // backtrack2A backtrack2(inProgressCombo: [], potentialComboElements: [2, 2, 3, 5], target: 8)
        // backtrack2B backtrack2(inProgressCombo: [2], potentialComboElements: [2, 3, 5], target: 6)
        // backtrack2C backtrack2(inProgressCombo: [2, 2], potentialComboElements: [3, 5], target: 4, index: 0)
        // backtrack2D backtrack2(inProgressCombo: [2, 2, 3], potentialComboElements: [5], target: 1, index: 0)
        // backtrack2E backtrack2(inProgressCombo: [2, 2, 3, 5], potentialComboElements: [], target: -4, index: 0)
        // backtrack2E returns, backtrack2D finished loop and returns, continue on backtrack2C
        // backtrack2F backtrack2(inProgressCombo: [2, 2, 5], potentialComboElements: [], target: 1, index: 0)
        // backtrack2F returns, backtrack2C finished loop and returns, continue on backtrack2B
        // backtrack2G backtrack2(inProgressCombo: [2, 3], potentialComboElements: [5], target: 3, index: 0)
        // backtrack2H backtrack2(inProgressCombo: [2, 3, 5], potentialComboElements: [], target: -2, index: 0)
        // backtrack2H returns, backtrack2G finished loop and returns, continue on backtrack2B
        // backtrack2I backtrack2(inProgressCombo: [2, 5], potentialComboElements: [], target: 1, index: 0)
        // backtrack2I returns, backtrack2B finished loop and returns, continue on backtrack2A
        // backtrack2J backtrack2(inProgressCombo: [3], potentialComboElements: [5], target: 5)
        // backtrack2K backtrack2(inProgressCombo: [3, 5], potentialComboElements: [], target: 0)
        // backtrack2K returns, backtrack2J finished loop and returns, continue on backtrack2A
        // backtrack2J backtrack2(inProgressCombo: [5], potentialComboElements: [], target: 3)
        // backtrack2J returns, backtrack2A finished looping and returns.
    }
}

// MARK: - 45. Jump Game II
// LINK: https://leetcode.com/problems/jump-game-ii/
//
// Description: Given an array of non-negative integers nums, you are initially positioned at the first index of the
// array. Each element in the array represents your maximum jump length at that position. Your goal is to reach the
// last index in the minimum number of jumps. You can assume that you can always reach the last index.
//
// Strategy: Construct the tree with visited index values. Using breadth first search to find the tree path
// sequence count. Avoid processing the same node that has been visited, and observe that the maxReach of each
// level is the max of every node + their reach, because every node is consecutive to each other. It would easier
// to make this observation if we write down the array value and highlight the reach of every node. Every single
// node from the start of current level to maxReach would be visited.
//
// 2 3 1 1 4
//        0
//       / \
//      1   2
//     / \
//    3   4
// 4 is equal to nums.count - 1, return 2 (jumps)

extension MediumArrayProblems {
    func jump(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return 0
        }

        var visited: [Bool] = Array(repeating: false, count: nums.count)
        var level: Int = 1
        var indexValuesOfCurrentLevel: [Int] = Array(1...nums[0])

        for i in 0...min(nums[0], nums.count - 1) {
            visited[i] = true
        }

        while !indexValuesOfCurrentLevel.isEmpty {
            var reaches: [Int] = []
            var maxReach: Int = 0

            for indexValue in indexValuesOfCurrentLevel {
                if indexValue == (nums.count - 1) {
                    return level
                }

                visited[indexValue] = true
                let currentReach: Int = indexValue + nums[indexValue]
                if currentReach > maxReach {
                    maxReach = currentReach
                }

                reaches.append(currentReach)
            }

            let start: Int = indexValuesOfCurrentLevel[0]
            let safeMaxReach: Int = min(maxReach, nums.count - 1)
            indexValuesOfCurrentLevel = (start+1...safeMaxReach).filter { visited[$0] == false }
            level += 1
        }

        return level
    }
    
    // NOTE: this is the optimized BFS approach without using extra arrays.
    func jumpOptimized(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return 0
        }

        var level: Int = 0
        var left: Int = 0
        var right: Int = 0

        while right < (nums.count - 1) {
            var maxReach: Int = 0
            
            for i in left...right {
                let currentReach: Int = i + nums[i]
                
                if currentReach > maxReach {
                    maxReach = currentReach
                }
            }
            
            left = right + 1
            right = maxReach
            level += 1
        }

        return level
    }
}

// MARK: - 46. Permutations
// LINK: https://leetcode.com/problems/permutations/
//
// Description: Given an array nums of distinct integers, return all the possible permutations. You can return the
// answer in any order.
//
// Strategy: DFS backtracking

extension MediumArrayProblems {
    func permute(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else {
            return [[nums[0]]]
        }

        var inProgressPermutation: [Int] = []
        let remainingNums: Set<Int> = Set(nums)
        var permutations: [[Int]] = []
        backtrack(nums: nums,
                  inProgressPermutation: &inProgressPermutation,
                  remainingNums: remainingNums,
                  permutations: &permutations)
        return permutations
    }
    
    func backtrack(nums: [Int],
                   inProgressPermutation: inout [Int],
                   remainingNums: Set<Int>,
                   permutations: inout [[Int]])
    {
        if inProgressPermutation.count == nums.count {
            permutations.append(inProgressPermutation)
            return
        }
        
        for num in remainingNums.sorted() {
            inProgressPermutation.append(num)
            
            var newRemainingNums: Set<Int> = remainingNums
            newRemainingNums.remove(num)
            
            backtrack(nums: nums,
                      inProgressPermutation: &inProgressPermutation,
                      remainingNums: newRemainingNums,
                      permutations: &permutations)
            inProgressPermutation.removeLast()
        }
        
        // backtracka backtrack(inProgressPermutation: [], remainingNums: Set(1, 2, 3), permutations: [])
        // backtrackb backtrack(inProgressPermutation: [1], remainingNums: Set(2, 3), permutations: [])
        // backtrackc backtrack(inProgressPermutation: [1, 2], remainingNums: Set(3), permutations: [])
        // backtrackd backtrack(inProgressPermutation: [1, 2, 3], remainingNums: Set(), permutations: [])
        // backtrackd returns, backtrackc returns, continue on backtrackb
        // backtracke backtrack(inProgressPermutation: [1, 3], remainingNums: Set(2), permutations: [])
    }
}

// MARK: - 48. Rotate Image
// LINK: https://leetcode.com/problems/rotate-image/
//
// Description: You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise). You
// have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate
// another 2D matrix and do the rotation.
//
// [(0, 0) (0, 1)]   =>  [(1, 0) (0, 0)]
// [(1, 0) (1, 1)]       [(1, 1) (0, 1)]
//
// [(0, 0) (0, 1)] => hReflect => [(1, 0) (1, 1)] => transpose => [(1, 0) (0, 0)]
// [(1, 0) (1, 1)]                [(0, 0) (0, 1)]                 [(1, 1) (0, 1)]
//
// Strategy: First perform horizontal reflect, and then transpose the matrix.

extension MediumArrayProblems {
    func rotate(_ matrix: inout [[Int]]) {        
        hReflect(&matrix)
        transpose(&matrix)
    }
    
    func hReflect(_ matrix: inout [[Int]]) {
        let midPoint: Int = matrix.count / 2
        
        for i in 0..<midPoint {
            (matrix[i], matrix[matrix.count - 1 - i]) = (matrix[matrix.count - 1 - i], matrix[i])
        }
    }
    
    func transpose(_ matrix: inout [[Int]]) {
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                guard j > i else {
                    continue
                }
                
                (matrix[i][j], matrix[j][i]) = (matrix[j][i], matrix[i][j])
            }
        }
    }
}

// MARK: - 55. Jump Game
// LINK: https://leetcode.com/problems/jump-game/
//
// Description: Given an array of non-negative integers nums, you are initially positioned at the first index of the
// array. Each element in the array represents your maximum jump length at that position. Determine if you are able to
// reach the last index.
//
// Strategy: BFS, use var leftIndex and rightIndex to set boundaries for each level of tree. Find the maxReach of the
// tree by going through all the nodes between leftIndex and rightIndex. Make sure the maxReach is greater than the
// current rightIndex, because that guarantees at least one of the node is capable of a non-zero positive jump. Update
// the leftIndex with rightIndex + 1 and rightIndex with maxReach to represent the next level of the tree.

extension MediumArrayProblems {
    func canJump(_ nums: [Int]) -> Bool {
        var left: Int = 0
        var right: Int =  0
        
        while right < (nums.count - 1) {
            var maxReach: Int = 0
            
            for index in left...right {
                let reach: Int = index + nums[index]
                maxReach = max(maxReach, reach)
            }
            
            guard maxReach > right else {
                return false
            }
            
            left = right + 1
            right = maxReach
        }
        
        return right >= (nums.count - 1)
    }
}

// MARK: - 56. Merge Intervals
// LINK: https://leetcode.com/problems/merge-intervals/
//
// Description: Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and
// return an array of the non-overlapping intervals that cover all the intervals in the input.
//
// Strategy: loop through the intervals to put all of them into a dict, with key = start, value = end, and update the
// value if the key already exists (merge the interval). After that, loop through that dict and insert all its keys to
// an array. Sort the array in descending order. Start by removing the last element of the array, check to see if
// dict[currentStart] >= some other remaining element in the array, if it is, remove the currentStart from the array,
// update dict[currentStart] = max(dict[currentStart]!, dict[otherStart]!), and update dict[otherStart] = nil, and
// update hasMergedInCurrentIteration = true. After checking through the check with the remaining elements in the
// array, if hasMergedInCurrentIteration == true, append currentStart back to the array, because it is a new interval
// and it might have missed merging some other intervals while doing the "dict[currentStart] >= some other remaining
// element in the array" check before dict[currentStart] is updated. We can then repeat the same process until the
// array is empty. In the final step, loop through the sorted keys of the dictionary to return the merged intervals.
//
// intervals: [[1, 3], [2, 9], [8, 10], [15, 18]]
// arrayDescSorted: [15, 8, 2, 1]
//
// 1 -> 3     => 1 -> 9     => 1 -> 10
// 2 -> 9        8 -> 10       15 -> 18
// 8 -> 10       15 -> 18
// 15 -> 18

extension MediumArrayProblems {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        var dict: [Int: Int] = [:]

        for interval in intervals {
            if let value = dict[interval[0]] {
                dict[interval[0]] = max(value, interval[1])
            } else {
                dict[interval[0]] = interval[1]
            }
        }

        var array: [Int] = Array(dict.keys)
        array.sort(by: >)

        while !array.isEmpty {
            let currentStart: Int = array.removeLast()
            var hasMergedInCurrentIteration: Bool = false

            // check to see if anything can be merged, looping the array in reverse order to make removal during
            // looping possible
            for (i, otherStart) in array.enumerated().reversed() {
                if dict[currentStart]! >= otherStart {
                    array.remove(at: i)
                    dict[currentStart] = max(dict[currentStart]!, dict[otherStart]!)
                    dict[otherStart] = nil
                    hasMergedInCurrentIteration = true
                }
            }
            
            if hasMergedInCurrentIteration {
                array.append(currentStart)
            }
        }

        var results: [[Int]] = []

        for sortedKey in dict.keys.sorted() {
            results.append([sortedKey, dict[sortedKey]!])
        }

        return results
    }
    
    // This is slightly optimized because it uses set instead of array, which has O(1) insert and remove; however,
    // since a set doesn't preserve the order of the sequence, it has more edge cases to guard against.
    func mergeSlightlyOptimized(_ intervals: [[Int]]) -> [[Int]] {
        var dict: [Int: Int] = [:]
        
        for interval in intervals {
            if let value = dict[interval[0]] {
                dict[interval[0]] = max(value, interval[1])
            } else {
                dict[interval[0]] = interval[1]
            }
        }
        
        var set: Set<Int> = Set(dict.keys)
        
        while !set.isEmpty {
            let currentStart: Int = set.removeFirst()
            var hasMergedToPossiblyExpandMax: Bool = false
            
            for otherStart in set {
                // merge to possibly expand max value
                if (dict[currentStart]! >= otherStart) && (currentStart <= otherStart) {
                    set.remove(otherStart)
                    dict[currentStart] = max(dict[currentStart]!, dict[otherStart]!)
                    dict[otherStart] = nil
                    hasMergedToPossiblyExpandMax = true
                }
            }
            
            for otherStart in set {
                // merge to possibly expand min value
                if (currentStart >= otherStart) && (currentStart <= dict[otherStart]!) {
                    dict[otherStart] = max(dict[currentStart]!, dict[otherStart]!)
                    dict[currentStart] = nil
                    break
                }
            }
            
            if hasMergedToPossiblyExpandMax {
                if let _ = dict[currentStart] {
                    set.insert(currentStart)
                }
            }
        }
        
        var results: [[Int]] = []
        
        for sortedKey in dict.keys.sorted() {
            results.append([sortedKey, dict[sortedKey]!])
        }
        
        return results
    }
}

// MARK: - 57. Insert Interval
// LINK: https://leetcode.com/problems/insert-interval/
//
// Description: Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).
// You may assume that the intervals were initially sorted according to their start times.
//
// Strategy: Loop through the intervals, find out the indices of the intervals that intersect with the newInterval,
// remove those intersecting intervals and replace them with the newInterval. If the indicesToRemove is empty, that
// means the newInterval is not intersecting with any existing interval. In that case, the new interval should be
// inserted in either the beginning, end or somewhere in the interval, we would use a var indexToInsert: Int? to track
// where it should be inserted. If the new interval should be inserted in anywhere other than the end of the intervals,
// then we would definitely observe when the first right non overlapping interval is encountered, and the indexToInsert
// should be set to that index. Otherwise, if the new interval is to be inserted to the end of the intervals, then var
// indexToInsert: Int? would never be updated and we can just append the new interval to the intervals.
//
// 1 2 3 4 5 6 7 8 9 10
//       ^ - ^
// ^ - ^       ^ - ^
extension MediumArrayProblems {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var mergedInterval: [Int] = newInterval
        var indicesToRemove: [Int] = []
        var firstRightNonOverlappingIntervalEncountered: Bool = false
        var indexToInsert: Int? = nil
        
        for (i, interval) in intervals.enumerated() {
            if interval[0] > newInterval[1] {
                // interval is far away from the newInterval to the right
                if !firstRightNonOverlappingIntervalEncountered {
                    firstRightNonOverlappingIntervalEncountered = true
                    indexToInsert = i
                }
                
                continue
            } else if interval[1] < newInterval[0] {
                // interval is far away from the newInterval to the left
                continue
            } else {
                mergedInterval = [min(interval[0], mergedInterval[0]), max(interval[1], mergedInterval[1])]
                indicesToRemove.append(i)
            }
        }
        
        if !indicesToRemove.isEmpty {
            guard let firstIndex = indicesToRemove.first, let lastIndex = indicesToRemove.last else {
                return []
            }
            
            let firstPart: [[Int]] = Array(intervals[..<firstIndex])
            let secondPart: [[Int]] = [mergedInterval]
            let thirdPart: [[Int]]
            
            if ((lastIndex + 1) < intervals.count) {
                thirdPart = Array(intervals[(lastIndex + 1)..<intervals.count])
            } else {
                thirdPart = []
            }
            
            return firstPart + secondPart + thirdPart
        } else {
            var resultIntervals: [[Int]] = intervals
            
            if let sureIndexToInsert = indexToInsert {
                resultIntervals.insert(mergedInterval, at: sureIndexToInsert)
            } else {
                resultIntervals.append(mergedInterval)
            }
            
            return resultIntervals
        }
    }
}

// MARK: - 73. Set Matrix Zeroes
// LINK: https://leetcode.com/problems/set-matrix-zeroes/
//
// Description: Given an m x n integer matrix matrix, if an element is 0, set its entire row and column to 0's, and
// return the matrix. You must do it in place.
//
// Strategy: O(m + n) space solution would be checking each row, if that row contains a zero, mark it to update the
// whole row to zeros; similarly check each column, if that column contains a zero, mark it to update the whole column
// to zeros.

extension MediumArrayProblems {
    func setZeroes(_ matrix: inout [[Int]]) {
        guard !matrix.isEmpty else {
            return
        }
        
        var rowsToBeUpdatedToZeros: [Bool] = Array(repeating: false, count: matrix.count)
        var columnsToBeUpdatedToZeros: [Bool] = Array(repeating: false, count: matrix[0].count)
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == 0 {
                    rowsToBeUpdatedToZeros[i] = true
                    columnsToBeUpdatedToZeros[j] = true
                }
            }
        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if rowsToBeUpdatedToZeros[i] == true || columnsToBeUpdatedToZeros[j] == true {
                    matrix[i][j] = 0
                }
            }
        }
    }
}

// MARK: - 75. Sort Colors
// LINK: https://leetcode.com/problems/sort-colors/
// VIDEO: https://www.youtube.com/watch?v=4xbWSRZHqac
//
// Description: Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of
// the same color are adjacent, with the colors in the order red, white, and blue. We will use the integers 0, 1, and 2
// to represent the color red, white, and blue, respectively. You must solve this problem without using the library's
// sort function.
//
// Strategy:
//
//       indexToProcess
//            V
//            2 0 2 1 1 0
//            ^         ^
//     leftMark         rightMark
//
// - any index before leftMark should have value of 0
// - any index after rightMark should have value of 2
// - use leftMark, rightMark and indexToProcess
//
// start by indexToProcess = 0, if nums[indexToProcess] == 0, swap value of nums[indexToProcess] and nums[leftMark],
// increment leftMark by 1, notice that leftMark will only stop at someIndex where nums[someIndex] = 1, because the 0s
// and 2s are filtered out by the all the swapping done by iterations of indexToProcess, hence, it is safe to increment
// indexToProcess by 1; if nums[indexToProcess] == 1, increment indexToProcess, essentially we are skipping because we
// want the 1s to stay in the middle; if nums[indexToProcess] == 2, swap value of nums[indexToProcess] and
// nums[rightMark], decrement rightMark by 1, and notice that we can't increment indexToProcess, because the swapped
// value from nums[rightMark] is not protected by the iteration of indexToProcess, so it could be anything from 0, 1,
// or 2, hence we need to examine the updated nums[indexToProcess] again. Continue the while loop as long as (leftMark
// < rightMark) and (indexToProcess <= rightMark)

extension MediumArrayProblems {
    func sortColors(_ nums: inout [Int]) {
        guard nums.count > 1 else {
            return
        }

        var indexToProcess:Int = 0
        var leftMark: Int = 0
        var rightMark: Int = nums.count - 1

        while (leftMark < rightMark) && (indexToProcess <= rightMark) {
            if nums[indexToProcess] == 0 {
                nums[indexToProcess] = nums[leftMark]
                nums[leftMark] = 0
                leftMark += 1
                indexToProcess += 1
            } else if nums[indexToProcess] == 1 {
                indexToProcess += 1
            } else if nums[indexToProcess] == 2 {
                nums[indexToProcess] = nums[rightMark]
                nums[rightMark] = 2
                rightMark -= 1
            }
        }
    }
    
    // Strategy: Since we have a finite number of elements (0, 1 and 2), we can take advantage of the bucket sort, in
    // which we count the occurences of each element and construct the returning array by pasting those elements group
    // together in ascending order.
    func sortColorsByBucketSort(_ nums: inout [Int]) {
        var dict: [Int: Int] = [:]
        
        for num in nums {
            dict[num] = (dict[num] ?? 0) + 1
        }
        
        let zeros: Int = dict[0] ?? 0
        let ones: Int = dict[1] ?? 0
        let twos: Int = dict[2] ?? 0
        
        nums = Array(repeating: 0, count: zeros) + Array(repeating: 1, count: ones) + Array(repeating: 2, count: twos)
    }
}

// MARK: - 78. Subsets
// LINK: https://leetcode.com/problems/subsets/
//
// Descriptions: Given an integer array nums of unique elements, return all possible subsets (the power set). The
// solution set must not contain duplicate subsets. Return the solution in any order.
//
// Strategy: Use DFS backtracking, use remainingNums as the mechanism to keep adding element in the recursive step.
//
//                      [1, 2, 3]
//                          |
//                         [ ]
//                        / | \
//                       /  |  \
//                      /   |   \
//                   [1]   [2]   [3]
//                  / |     |
//                 /  |     |
//                /   |   [2, 3]
//               /    |
//          [1, 2] [1, 3]
//

extension MediumArrayProblems {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var subsets: [[Int]] = []
        var current: [Int] = []
        let remainingNums: [Int] = nums.sorted()
        backtrack(subsets: &subsets, current: &current, remainingNums: remainingNums)
        return subsets
    }
    
    func backtrack(subsets: inout [[Int]], current: inout [Int], remainingNums: [Int]) {
        if remainingNums.isEmpty {
            subsets.append(current)
            return
        }
        
        let rNumsCount: Int = remainingNums.count
        for i in 0..<rNumsCount {
            current.append(remainingNums[i])
            let newRemainingNums: [Int] = (i + 1 < rNumsCount) ? Array(remainingNums[i + 1..<rNumsCount]) : []
            backtrack(subsets: &subsets, current: &current, remainingNums: newRemainingNums)
            current.removeLast()
        }
        
        subsets.append(current)
    }
    
    func backtrackOptimized(subsets: inout [[Int]], current: inout [Int], nums: [Int], startIndexOfRemainingNums: Int) {
        if startIndexOfRemainingNums == nums.count {
            subsets.append(current)
            return
        }
        
        for i in startIndexOfRemainingNums..<nums.count {
            current.append(nums[i])
            backtrackOptimized(subsets: &subsets, current: &current, nums: nums, startIndexOfRemainingNums: i + 1)
            current.removeLast()
        }
        
        subsets.append(current)
    }
}

// MARK: - 79. Word Search
// LINK: https://leetcode.com/problems/word-search/
// VIDEO: https://www.youtube.com/watch?v=vYYNp0Jrdv0
//
// Description: Given an m x n grid of characters board and a string word, return true if word exists in the grid. The
// word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or
// vertically neighboring. The same letter cell may not be used more than once.
//
// Strategy: loop through the board, whenever we find a character that matches the beginning of the word, do a DFS
// backtrack, in which we pass in the board, word as chars, rowIndex, columnIndex, and inProgressSequenceCount.
// Basically we are looking at a particular coordinate (rowIndex, columnIndex) and determine if it can lead to a path
// that matches the word. In the base case, we return true if chars.count == inProgressSequenceCount, and we return
// false if that coordinate is out of bound or doesn't match with the corresponding character from the word. As long as
// that coordinate is within the bound and matches the corresponding order of the character within the word, we can
// continue the recursive case. In the recursive case, we will recursively check the top, left, bottom, right and
// return true if any one of them is true.

extension MediumArrayProblems {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let chars: [Character] = Array(word)
        let startingChar: Character = chars[0]
        var editableBoard: [[Character]] = board
        
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == startingChar && backtrack(board: &editableBoard,
                                                            chars: chars,
                                                            rowIndex: i,
                                                            columnIndex: j,
                                                            inProgressSequenceCount: 0)
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    func backtrack(board: inout [[Character]],
                   chars: [Character],
                   rowIndex: Int,
                   columnIndex: Int,
                   inProgressSequenceCount: Int) -> Bool
    {
        if chars.count == inProgressSequenceCount {
            return true
        }
        
        if (rowIndex < 0 ||
                rowIndex == board.count ||
                columnIndex < 0 ||
                columnIndex == board[rowIndex].count ||
                board[rowIndex][columnIndex] != chars[inProgressSequenceCount])
        {
            return false
        }
        
        let temp: Character = board[rowIndex][columnIndex]
        
        board[rowIndex][columnIndex] = Character(" ")

        let existOnLeft: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex - 1,
                                          columnIndex: columnIndex,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        let existOnRight: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex + 1,
                                          columnIndex: columnIndex,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        let existOnTop: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex,
                                          columnIndex: columnIndex - 1,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        let existOnBottom: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex,
                                          columnIndex: columnIndex + 1,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        board[rowIndex][columnIndex] = temp
        
        let hasFound: Bool = existOnLeft || existOnRight || existOnTop || existOnBottom
        return hasFound
    }
}

// MARK: - 128. Longest Consecutive Sequence
// LINK: https://leetcode.com/problems/longest-consecutive-sequence/
//
// Description: Given an unsorted array of integers nums, return the length of the longest consecutive elements
// sequence. You must write an algorithm that runs in O(n) time.
//
// Strategy: Init the nums with a Set to get rid of all the duplicated elements and make checking whether an element
// exists to have O(1) complexity. After that, only start counting streak from local minimums and return the longest
// streak in the end.

extension MediumArrayProblems {
    func longestConsecutive(_ nums: [Int]) -> Int {
        var longestStreak: Int = 0
        let numSet: Set<Int> = Set(nums)
        
        for num in numSet {
            // NOTE: only start counting streak from local minimums
            if !numSet.contains(num - 1) {
                var streak: Int = 0
                var current: Int = num
                
                while numSet.contains(current) {
                    streak += 1
                    current += 1
                }
            
                longestStreak = max(streak, longestStreak)
            }
        }
        
        return longestStreak
    }
}

// MARK: - 152. Maximum Product Subarray
// LINK: https://leetcode.com/problems/maximum-product-subarray/
// VIDEO: https://www.youtube.com/watch?v=lXVy6YWFcRM
//
// Description: Given an integer array nums, find a contiguous non-empty subarray within the array that has the largest
// product, and return the product.
//
// Strategy: Keep track of both maxProductIncludingCurrentNum and minProductIncludingCurrentNum. The
// maxProductIncludingCurrentNum would be calculated by max(current * maxProductIncludingPreviousNum, current *
// minProductIncludingPreviousNum, current). The minProductIncludingCurrentNum would be calculated by min(current *
// maxProductIncludingPreviousNum, current * minProductIncludingPreviousNum, current). One edge case is that if
// previous num is zero, we need to update the maxProductIncludingPreviousNum and minProductIncludingPreviousNum to 1
// since 0 would break them.
//
// nums = [-4, -2, -2, -2, -3]
// maxProductIncludingCurrentNum = [-4, 8, 4, 32, 24]
// minProductIncludingCurrentNum = [-4, -2, -16, -8, -96]
//
// nums = [-2, 0, -1]
// maxProductIncludingCurrentNum = [-2, 1, -1]
// minProductIncludingCurrentNum = [-2, 1, -1]

extension MediumArrayProblems {
    func maxProduct(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums[0]
        }
        
        var result: Int = nums[0]
        var minProductIncludingCurrentNum: Int = nums[0]
        var maxProductIncludingCurrentNum : Int = nums[0]
        
        for i in 1..<nums.count {
            if nums[i - 1] == 0 {
                maxProductIncludingCurrentNum  = 1
                minProductIncludingCurrentNum = 1
            }
            
            let temp: Int = maxProductIncludingCurrentNum  * nums[i]
            
            maxProductIncludingCurrentNum  = max(nums[i] * maxProductIncludingCurrentNum,
                                                 nums[i] * minProductIncludingCurrentNum,
                                                 nums[i])
            minProductIncludingCurrentNum = min(temp, nums[i] * minProductIncludingCurrentNum, nums[i])
            
            result = max(result, maxProductIncludingCurrentNum )
        }
        
        return result
    }
}

// MARK: - 153. Find Minimum in Rotated Sorted Array
// LINK: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
//
// Description: Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example,
// the array nums = [0,1,2,4,5,6,7] might become: [4,5,6,7,0,1,2] if it was rotated 4 times; [0,1,2,4,5,6,7] if it was
// rotated 7 times. Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1],
// a[0], a[1], a[2], ..., a[n-2]]. Given the sorted rotated array nums of unique elements, return the minimum element
// of this array. You must write an algorithm that runs in O(log n) time.
//
// Strategy:
// rotate 0 time: [1,2,3,4,5] => midP = 3, leftArr = [1,2], rightArr = [4,5]
// rotate 1 time: [5,1,2,3,4] => midP = 2, leftArr = [5,1], rightArr = [3,4]
// rotate 2 time: [4,5,1,2,3] => midP = 1, leftArr = [4,5], rightArr = [2,3]
// rotate 3 time: [3,4,5,1,2] => midP = 5, leftArr = [3,4], rightArr = [1,2]
// rotate 4 time: [2,3,4,5,1] => midP = 4, leftArr = [2,3], rightArr = [5,1]
//
// do binary search, check to see whether leftArr or rightArr has its first element greater than its last element. Get
// the leftArr/rightArr in which the first element is greater than last element and do the same binary search on it. If
// both of them has their first element less than last element, then returns the min of nums[midPoint], leftArr[0] and
// rightArr[0].

extension MediumArrayProblems {
    func findMin(_ nums: [Int]) -> Int {
        var prunedNums: [Int] = nums
        
        while !prunedNums.isEmpty {
            if prunedNums.count == 1 {
                return prunedNums[0]
            } else if prunedNums.count == 2 {
                return (prunedNums[1] > prunedNums[0]) ? prunedNums[0] : prunedNums[1]
            }
            
            let midPoint: Int =  (0 + prunedNums.count - 1) / 2
            let leftArr: [Int] = Array(prunedNums[0..<midPoint])
            let rightArr: [Int] = Array(prunedNums[(midPoint + 1)..<prunedNums.count])
            
            if leftArr[0] > leftArr[leftArr.count - 1] {
                prunedNums = leftArr
            } else if rightArr[0] > rightArr[rightArr.count - 1] {
                prunedNums = rightArr
            } else {
                return min(leftArr[0], prunedNums[midPoint], rightArr[0])
            }
        }
        
        return -1
    }
}

// MARK: - 238. Product of Array Except Self
// LINK: https://leetcode.com/problems/product-of-array-except-self/
// VIDEO: https://www.youtube.com/watch?v=gREVHiZjXeQ
//
// Description: Given an integer array nums, return an array answer such that answer[i] is equal to the product of all
// the elements of nums except nums[i]. The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit
// integer. You must write an algorithm that runs in O(n) time and without using the division operation.
//
// Strategy: Recognize that for each element, the productExceptSelf is really just (left partial product) * (right
// partial product). We would need to create leftProductUpToElement: [Int] and rightProductUpToElement: [Int] and use
// them to create finalProductExceptSelf: [Int]
//
// input: [1, 2, 3, 4]
// leftProduct: [1, 2, 6, 24]
// rightProduct: [24, 24, 12, 4]
// finalProduct: [RP[1], LP[0] * RP[2], LP[1] * RP[3], LP[2]]
// finalProduct: [24, 1*12, 2*4, 6]

extension MediumArrayProblems {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var LP: [Int] = Array(repeating: 0, count: nums.count)
        LP[0] = nums[0]
        
        var RP: [Int] = Array(repeating: 0, count: nums.count)
        RP[nums.count - 1] = nums[nums.count - 1]
        
        for i in 1..<nums.count {
            LP[i] = LP[i - 1] * nums[i]
            RP[nums.count - 1 - i] = RP[nums.count - i] * nums[nums.count - 1 - i]
        }
        
        var FP: [Int] = Array(repeating: 0, count: nums.count)
        FP[0] = RP[1]
        FP[nums.count - 1] = LP[nums.count - 2]
        for i in 1..<(nums.count - 1) {
            FP[i] = LP[i - 1] * RP[i + 1]
        }
        
        return FP
    }
    
    func productExceptSelfOptimized(_ nums: [Int]) -> [Int] {
        // Optimized Strategy: Create the LP array and store it in FP array. Update the last element of the FP array as
        // the second to last element of the LP array (which in this case is the FP array itself). Calculate RP1 for
        // now because we would need to set it to FP[0] at the end. Use the last element of nums as the starting RP
        // value, loop backward to finish constructing the FP array while updating RP in each iteration. In the end,
        // update FP[0] = RP1 because the first element of the FP array is the special case in which only right product
        // exists, similar to the last element of the FP array in which only the left product exists.
        
        var RP1: Int = 1
        var FP: [Int] = Array(repeating: 0, count: nums.count)
        FP[0] = nums[0]
        
        for i in 1..<nums.count {
            RP1 *= nums[i]
            FP[i] = FP[i - 1] * nums[i]
        }
        
        FP[nums.count - 1] = FP[nums.count - 2]
        
        var RP: Int = nums[nums.count - 1]
        
        for i in 1..<(nums.count - 1) {
            // FP[2] = LP[1] * RP[3]
            // FP[1] = LP[0] * RP[2]
            FP[nums.count - 1 - i] = FP[nums.count - 2 - i] * RP
            RP = RP * nums[nums.count - 1 - i]
        }
        
        FP[0] = RP1
        return FP
    }
}
