//
//  MediumDynamicProgrammingProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 7/4/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumDynamicProgrammingProblems {
    var uniquePathsXY: [String: Int] = [:]
}

// MARK: - 62. Unique Paths
// LINK: https://leetcode.com/problems/unique-paths/
//
// Description: A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below). The
// robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner
// of the grid (marked 'Finish' in the diagram below). How many possible unique paths are there?
//
// Strategy: This type of problem obviously looks like some recursion or DP problem. First consider some small non
// trivial case, such as uniquePaths(3, 2). For more readability, we will make a uniquePathDestinationCoordinates
// method that takes the destination of rowIndex, columnIndex and returns the number of unique paths from (0, 0) to
// (rowIndex, columnIndex). Since the coordintate system runs from 0 to (m - 1) on the rowIndex asis and 0 to (n - 1)
// on columnIndex axis, uniquePaths(3, 2) = uniquePathDestinationCoordinates(rowIndex: 2, columnIndex: 1). Notice that
// the only way we can travel to (2, 1) is from the top previous coordinate (1, 1) or left previous coordinate (2, 0).
// So the general case is really just uniquePathDestinationCoordinates(rowIndex, columnIndex) =
// uniquePathDestinationCoordinates(rowIndex - 1, columnIndex) + uniquePathDestinationCoordinates(rowIndex, columnIndex
// - 1). The base is uniquePathDestinationCoordinates(0, 0) = 1, and uniquePathDestinationCoordinates(rowIndex,
// columnIndex) = 0 for (rowIndex < 0) or (columnIndex < 0). We can code out this recursive algorithm easily and use a
// dict or 2D array as the DP cache.
//
// There is some problem with this recursive DP approach, firstly, if the tail-call optimization is not enabled, our
// inputs would be limited by the maximum call stack size; secondly, even though invoking each method call is a very
// small amount of work, when you have to do a lot of them, they add up, so they are not as efficient as doing
// everything iteratively in just one method call. So We will try to code out this iterative DP solution. There is some
// trick to set up this iterative DP solution. Let's start by creating a 2D DP array in which the array represent the
// uniquePathCount at that particular coordinate. We can begin by filling the whole DP array with zeros. And then since
// the robot can only move right or down, we can observe that the top row of the DP array are all going to be 1s,
// because there is only one unique path to go to each of those coordinates in the top row, which is by moving right.
// We can also observe the leftmost column of the DP array are all going to be 1s for the same reason by moving down.
// For the reset of the DP array, they will be calculated as DP[rowIndex][columnIndex] = DP[rowIndex - 1][columnIndex]
// + DP[rowIndex][columnIndex - 1]. Looke at the 5 x 3 grid below for example
//
// [1 1 1 1 1]
// [1 ? ? ? ?]
// [1 ? ? ? ?]
//
// We only have to loop through all ?s with DP[rowIndex][columnIndex] = DP[rowIndex - 1][columnIndex] +
// DP[rowIndex][columnIndex - 1]
//
// In the end, we will return DP[rowIndex][columnIndex] as the answer.

extension MediumDynamicProgrammingProblems {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        return uniquePathDestinationCoordinates(rowIndex: m - 1, columnIndex: n - 1)
    }
    
    func uniquePathDestinationCoordinates(rowIndex: Int, columnIndex: Int) -> Int {
        if rowIndex == 0 || columnIndex == 0 {
            return 1
        }
        
        let columnArray: [Int] = Array(repeating: 0, count: columnIndex + 1)
        var dpArray: [[Int]] = Array(repeating: columnArray, count: rowIndex + 1)
        
        // Mark top row as 1s
        dpArray[0] = Array(repeating: 1, count: columnIndex + 1)
        
        // Mark left most column as 1s
        for (i, _) in dpArray.enumerated() {
            dpArray[i][0] = 1
        }
        
        for i in 1...rowIndex {
            for j in 1...columnIndex {
                dpArray[i][j] = dpArray[i - 1][j] + dpArray[i][j - 1]
            }
        }
        
        return dpArray[rowIndex][columnIndex]
    }
    
    func uniquePathsRecursiveDP(_ m: Int, _ n: Int) -> Int {
        return recursiveUniquePathDestinationCoordinates(rowIndex: m - 1, columnIndex: n - 1)
    }
    
    func recursiveUniquePathDestinationCoordinates(rowIndex: Int, columnIndex: Int) -> Int {
        if rowIndex == 0 && columnIndex == 0 {
            return 1
        }
        
        if (rowIndex < 0) || (columnIndex < 0) {
            return 0
        }
        
        if let value = uniquePathsXY["\(rowIndex),\(columnIndex)"] {
            return value
        }
        
        let leftPreviousUPs: Int = recursiveUniquePathDestinationCoordinates(rowIndex: rowIndex - 1,
                                                                             columnIndex: columnIndex)
        let topPreviousUPs: Int = recursiveUniquePathDestinationCoordinates(rowIndex: rowIndex,
                                                                            columnIndex: columnIndex - 1)
        let result = leftPreviousUPs + topPreviousUPs
        uniquePathsXY["\(rowIndex),\(columnIndex)"] = result
        return result
    }
}

// MARK: - 64. Minimum Path Sum
// LINK: https://leetcode.com/problems/minimum-path-sum/
//
// Description: Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right, which
// minimizes the sum of all numbers along its path. Note: You can only move either down or right at any point in time.
//
// Strategy: This is another DP problem. Make an observation that in any (rowIndex, columnIndex) coordinate,
// DP[rowIndex][columnIndex] = grid[rowIndex][columnIndex] + min(DP[rowIndex - 1][columnIndex],
// DP[rowIndex][columnIndex - 1]). In order to make this general case logic to work, we need to fill the top row and
// left most column of the DP array. this time, for these special cases, the minimum path sum is the sum of all
// previous elements up to the current element in the top row or left most column. Return
// DP[maxRowIndex][maxColumnIndex]
//
// Grid
// [1 1 1 1 1]
// [2 2 2 2 2]
// [3 3 3 3 3]
//
// DP Array
// [1 2 3 4 5]
// [3 ? ? ? ?]
// [6 ? ? ? ?]
//
// We only have to loop through all ?s with DP[rowIndex][columnIndex] = min(DP[rowIndex - 1][columnIndex],
// DP[rowIndex][columnIndex - 1]) + Grid[i][j]
//

extension MediumDynamicProgrammingProblems {
    func minPathSum(_ grid: [[Int]]) -> Int {
        let maxRowIndex: Int = grid.count - 1
        let maxColumnIndex: Int = grid[0].count - 1
        
        if (maxRowIndex == 0) && (maxColumnIndex == 0) {
            return grid[0][0]
        } else if maxRowIndex == 0 {
            return grid[0].reduce(0, +)
        } else if maxColumnIndex == 0 {
            var sum: Int = 0
            
            for row in grid {
                sum += row[0]
            }
            
            return sum
        }
        
        var dpArray: [[Int]] = grid
        
        // Fill the top row of the DP array
        var growingRowSum: Int = 0
        for (columnIndex, columnValue) in dpArray[0].enumerated() {
            growingRowSum += columnValue
            dpArray[0][columnIndex] = growingRowSum
        }
        
        // Fill the left most column of the DP array
        var growingColumnSum: Int = 0
        for (rowIndex, rowValue) in dpArray.enumerated() {
            growingColumnSum += rowValue[0]
            dpArray[rowIndex][0] = growingColumnSum
        }
        
        for i in 1...maxRowIndex {
            for j in 1...maxColumnIndex {
                dpArray[i][j] = grid[i][j] + min(dpArray[i - 1][j], dpArray[i][j - 1])
            }
        }
        
        return dpArray[maxRowIndex][maxColumnIndex]
    }
}

// MARK: - 139. Word Break
// LINK: https://leetcode.com/problems/word-break/
// VIDEO: https://www.youtube.com/watch?v=Sx9NNgInc3A
//
// Description: Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a
// space-separated sequence of one or more dictionary words. Note that the same word in the dictionary may be reused
// multiple times in the segmentation.
//
// Strategy: We basically want to create a DP array called isEntireStrBreakableStartingAtIndex.
// isEntireStrBreakableStartingAtIndex[0] will tell us whether or not the string s is breakable using the words in the
// wordDict. The base case is always isEntireStrBreakableStartingAtIndex[s.count] = true, that is because the non
// existing empty str right next to the end of str s is breakable using none of the words in the wordDict by default.
// And then we work our way back up to check isEntireStrBreakableStartingAtIndex[s.count - 1] till
// isEntireStrBreakableStartingAtIndex[0]. If a word from the wordDict can be matched a subString that starts with
// index i, then isEntireStrBreakableStartingAtIndex[i] = isEntireStrBreakableStartingAtIndex[i + word.count], because
// once the subStr is matched with the word, we just need to update the ending pointer to the new location (i +
// word.count) and see if the remaining str is also breakable. Once we found a combination that satisfies
// isEntireStrBreakableStartingAtIndex[i] = true, we want to stop trying any other word in the dictionary because we
// don't want to overwrite that result with false. For example, let s = "leetcode", wordDict = ["leet", "code", "co"],
// when i = 4, and we found the matching word "code" such that isEntireStrBreakableStartingAtIndex[4] =
// isEntireStrBreakableStartingAtIndex[4 + 4] = true, we want to stop there because if we don't, we will find the
// matching word "co" such that isEntireStrBreakableStartingAtIndex[4] = isEntireStrBreakableStartingAtIndex[4 + 2] =
// false, which overrode the previous true. Once we finish processing the whole isEntireStrBreakableStartingAtIndex
// array, we can return isEntireStrBreakableStartingAtIndex[0] as the answer.

extension MediumDynamicProgrammingProblems {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let chars: [Character] = Array(s)
        
        var isEntireStrBreakableStartingAtIndex: [Bool] = Array(repeating: false, count: s.count + 1)
        isEntireStrBreakableStartingAtIndex[s.count] = true
        
        for i in (0..<s.count).reversed() {
            let subStr: [Character] = Array(chars[i...])
            
            for word in wordDict {
                guard word.count <= subStr.count else {
                    continue
                }
                
                let possibleMatchedWord = String(subStr[0..<word.count])
                
                if possibleMatchedWord == word {
                    isEntireStrBreakableStartingAtIndex[i] = isEntireStrBreakableStartingAtIndex[i + word.count]
                }
                
                if isEntireStrBreakableStartingAtIndex[i] {
                    break
                }
            }
        }
        
        return isEntireStrBreakableStartingAtIndex[0]
    }
}

// MARK: - 198. House Robber
// LINK: https://leetcode.com/problems/house-robber/
//
// Description: You are a professional robber planning to rob houses along a street. Each house has a certain amount of
// money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security
// systems connected and it will automatically contact the police if two adjacent houses were broken into on the same
// night. Given an integer array nums representing the amount of money of each house, return the maximum amount of
// money you can rob tonight without alerting the police.
//
// 1               evenIndexSum = 1, oddIndexSum = 0, maxSum = max(evenIndexSum, oddSum) = 1
// 1 2             evenIndexSum = 1, oddIndexSum = 2, maxSum = max(evenIndexSum, oddSum) = 2
// 1 2 1           evenIndexSum = 2, oddIndexSum = 2, maxSum = max(evenIndexSum, oddSum) = 2
// 1 2 1 2         evenIndexSum = 2, oddIndexSum = 4,
// 1 2 1 2 1       evenIndexSum = 3, oddIndexSum = 4
// 1 2 1 2 1 0     evenIndexSum = 3, oddIndexSum = 4
// 1 2 1 2 1 0 3   evenIndexSum = 6, oddIndexSum = 4, maxSum = 7
//
// Strategy:
// base case should be 3 houses or less, because the max amount we can rob is max(sumOfOddValues, sumOfEvenValues).
// recursive case should be 4 houses or more, because the max amount we can rob is max(sumOfMaxAtIndexMinus1,
// sumOfMaxAtIndexMinus2 + currentValue, sumOfMaxAtIndexMinus3 + currentValue)

extension MediumDynamicProgrammingProblems {
    func rob(_ nums: [Int]) -> Int {
        var maxAtIndex: [Int] = []
        var evenIndexSum: Int = 0
        var oddIndexSum: Int = 0
        var currentMax: Int = 0
        
        for i in 0..<nums.count {
            if i % 2 == 0 {
                evenIndexSum += nums[i]
            } else {
                oddIndexSum += nums[i]
            }
            
            if i >= 3 {
                currentMax = max(maxAtIndex[i - 1], maxAtIndex[i - 2] + nums[i], maxAtIndex[i - 3] + nums[i])
            } else {
                currentMax = max(evenIndexSum, oddIndexSum)
            }
            
            maxAtIndex.append(currentMax)
        }
        
        return maxAtIndex[nums.count - 1]
    }
}

// MARK: - 322. Coin Change
// LINK: https://leetcode.com/problems/coin-change/
// VIDEO: https://www.youtube.com/watch?v=1R0_7HqNaW0
//
// Description: You are given an integer array coins representing coins of different denominations and an integer
// amount representing a total amount of money. Return the fewest number of coins that you need to make up that amount.
// If that amount of money cannot be made up by any combination of the coins, return -1. You may assume that you have
// an infinite number of each kind of coin.
//
// Strategy: Create a DP array minCoinForAmount to record the # of minCoin needed to return the specific amount.
// Initialize said DP array with some arbitrary big value (amount + 1), as that will be guaranteed to invalid because
// the coin of smallest possible value is 1. We can set minCoinForAmount[0] = 0 because it takes zero coin to come up
// with the 0 amount. For any amount > 0, we want to go through our available coin and try to use them if they are
// smaller than the current amount. We will update the DP array minCoinForAmount[amount] =
// min(minCoinForAmount[amount], 1 + minCoinForAmount[amount - coinValue]). After the process if finished, if
// minCoinForAmount[amount] != (amount + 1), we know the initialized minCoinForAmount[amount] value has been updated
// and we can return it, otherwise we can return -1

extension MediumDynamicProgrammingProblems {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard amount > 0 else {
            return 0
        }
        
        var minCoinForAmount: [Int] = Array(repeating: amount + 1, count: amount + 1)
        
        minCoinForAmount[0] = 0
        
        for someAmount in 0...amount {
            for coin in coins {
                if coin <= someAmount {
                    minCoinForAmount[someAmount] = min(minCoinForAmount[someAmount],
                                                       1 + minCoinForAmount[someAmount - coin])
                }
            }
        }
        
        return (minCoinForAmount[amount] != (amount + 1)) ? minCoinForAmount[amount] : -1
    }
}

// MARK: - 300. Longest Increasing Subsequence
// LINK: https://leetcode.com/problems/longest-increasing-subsequence/
//
// Description: Given an integer array nums, return the length of the longest strictly increasing subsequence.
// A subsequence is a sequence that can be derived from an array by deleting some or no elements without changing the
// order of the remaining elements. For example, [3,6,2,7] is a subsequence of the array [0,3,1,6,2,2,7].
//
// Strategy: Construct an array called LIS, it stores the count longest increasing subsequence that can be achieved by
// starting at index i. We will first create a LIS that has the same count as nums and fill it with 1s because at any
// giving index, the minimum LIS can be the element at said index. After that we work backward, we know that the
// LIS[nums.count - 1] can be at max 1 because there are no more elements available to be put into the LIS, but LIS[x]
// = max(1, 1 + LIS[x + 1](if nums[x] < nums[x + 1]), ..., 1 + LIS[x + n](if nums[x] < nums[x + n]), where (x + n) <
// nums.count. This is valid because LIS[i] denotes the count of longest increasing subsequence that can be achieved by
// starting at index i.

// 0 1 0 3 2 3
// LIS[3] = max(1, 1 + LIS[4](if nums[3] < nums[4]), 1 + LIS[5]if nums[3] < nums[5])
// LIS[4] = max(1, 1 + LIS[5](if nums[4] < nums[5]))
// LIS[5] = 1

extension MediumDynamicProgrammingProblems {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        } else if nums.count == 1 {
            return 1
        } else {
            var LIS: [Int] = Array(repeating: 1, count: nums.count)
            
            for i in (0..<(nums.count - 1)).reversed() {
                for j in 1..<(nums.count - i) {
                    if nums[i] < nums[i + j] {
                        LIS[i] = max(LIS[i], 1 + LIS[i + j])
                    }
                }
            }
            
            let LISMaxLength = LIS.max() ?? -1
            return LISMaxLength
        }
    }
}

// MARK: - 1143. Longest Common Subsequence
// LINK: https://leetcode.com/problems/longest-common-subsequence/
// VIDEO: https://www.youtube.com/watch?v=LAKWWDX3sGw
//
// Description: Given two strings text1 and text2, return the length of their longest common subsequence. If there is
// no common subsequence, return 0. A subsequence of a string is a new string generated from the original string with
// some characters (can be none) deleted without changing the relative order of the remaining characters. For example,
// "ace" is a subsequence of "abcde". A common subsequence of two strings is a subsequence that is common to both
// strings.
//
//     A E B
//   0 0 0 0
// A 0 1 1 1
// B 0 1 1 2
// C 0 1 1 2
//
//     E A
//   0 0 0
// C 0 0 0
// A 0 0 1
//
//     E A
//   0 0 0
// C 0 0 0
// E 0 1 1
//
// Strategy: Create a 2D grid, with row being (empty str + text1) and column being (empty str + text2). Iterate through
// the whole grid, we will primarily need to handle two cases: 1.) the last char of both strs match each other. 2.) the
// last char or both strs don't match each other.
//
// if the last char of both strs match each other, then its LCS is equal to 1 + previous diagonal value. In order to
// explain this look at the following example. text1 = "EA" and text2 = "CA", since both "A" match with each other, we
// can increment LCS by 1 and remove the "A" in both texts, so text1 = "E" and text2 = "C", and once we have the LCS of
// text1 = "E" and text2 = "C", we would have our answer. Essentially this boils down to the following:
// LCS("EA", "CA") = 1 + LCS("E", "C").
//
// On the other hand, if the last char of both strs don't match each other, then its LCS is equal the max of
// (LCS(text1WithLastCharRemoved, text2), LCS(text1, text2WithLastCharRemoved)). Consider the following example. text1
// = "EA" and text2 = "CE". At grid coordinate (2,2), we have "EA" comparing with "CE", since the last characters don't
// match each other, we can skip either one of them and try to maintain the higher LCS. If we skip "E", text1 stays at
// "EA" and text2 becomes "C" and the LCS of that is 0. If we skip "A", text1 becomes "E" and text2 stays as "CE" and
// the LCS of that is 1. So by definition of getting the LCS, we need to skip "A" since by doing that, we can have a
// longer LCS. Hence LCS("EA", "CE") = 1.

extension MediumDynamicProgrammingProblems {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let chars1: [Character] = Array(text1)
        let chars2: [Character] = Array(text2)
        
        var intersections: [[Int]] = Array(repeating: Array(repeating: 0, count: chars1.count + 1),
                                           count: chars2.count + 1)
        
        for row in 1..<intersections.count {
            for column in 1..<intersections[row].count {
                if chars1[column - 1] == chars2[row - 1] {
                    intersections[row][column] = 1 + intersections[row - 1][column - 1]
                } else {
                    intersections[row][column] = max(intersections[row - 1][column], intersections[row][column - 1])
                }
            }
        }
        
        return intersections[chars2.count][chars1.count]
    }
}
