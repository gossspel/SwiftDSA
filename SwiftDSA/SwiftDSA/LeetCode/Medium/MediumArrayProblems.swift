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
