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

// MARK: - 55 Jump Game
// LINK: https://leetcode.com/problems/jump-game/
//
// Description: You are given an integer array nums. You are initially positioned at the array's first index, and each
// element in the array represents your maximum jump length at that position. Return true if you can reach the last
// index, or false otherwise.
//
// Strategy: Create a DP array that denotes "is the last index reachable with an array of size n". dp[0] = true because
// if the array is of size 0, then by definition its non existent last index is already reached. dp[1] = true because
// the constraints nums[i] >= 0 exists, dp[1] is always true. For dp[2]....dp[n], as long as there is an element in
// nums that can reach nums[nums.count - 1], we can return true. Since we need to check every element before dp[n], the
// time complexity for this DP array approach would be O(n^2). However, there is a ways for us to optimize this to be
// O(n). We don't need to check every element before dp[n], we can keep track of the maxReach from nums and only check
// the last x = maxReach elements before dp[n], because any element earlier than that is guaranteed to not reach the
// index of nums[n - 1]. As a result the time complexity would be improved to O(n * maxReach) = O(n).

extension MediumDynamicProgrammingProblems {
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count > 1 else {
            return true
        }
        
        // NOTE: dp denotes the isTheLastIndexReachableWithArrayOfSizeN
        var dp: [Bool] = Array(repeating: false, count: nums.count + 1)
        
        // NOTE: if the array is of size 0, then by definition its non existent last index is already reached.
        dp[0] = true
        
        // NOTE: Because the constraints nums[i] >= 0 exists, dp[1] is always true
        dp[1] = true
        
        var maxReach: Int = 0
        var lowerBound: Int = 1
        
        for n in 2..<dp.count {
            for m in lowerBound..<n {
                maxReach = max(maxReach, nums[m - 1])
                
                if dp[m] && (nums[m - 1] + (m - 1) >= (n - 1)) {
                    dp[n] = true
                    break
                }
            }
            
            lowerBound = ((n - maxReach) > 1) ? (n - maxReach) : 1
        }
        
        return dp[nums.count]
    }
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

// MARK: - 91. Decode Ways
// LINK: https://leetcode.com/problems/decode-ways/
//
// Description: A message containing letters from A-Z can be encoded into numbers using the following mapping:
// 'A' -> "1"
// 'B' -> "2"
// ...
// 'Z' -> "26"
// To decode an encoded message, all the digits must be grouped then mapped back into letters using the reverse of the
// mapping above (there may be multiple ways). For example, "11106" can be mapped into:
// "AAJF" with the grouping (1 1 10 6)
// "KJF" with the grouping (11 10 6)
// Note that the grouping (1 11 06) is invalid because "06" cannot be mapped into 'F' since "6" is different from "06".
// Given a string s containing only digits, return the number of ways to decode it. The answer is guaranteed to fit in
// a 32-bit integer.
//
// Strategy: Create a dp array that denotes the number of ways to decode first n characters. dp[0] = 1 because there is
// only 1 way to decode empty str, because empty str yields nothing. dp[1] = 0 if the first char of s is 0, otherwise
// dp[1] = 1 because if the first char of s is within (1,9), it will always be decoded to a specific alphabet. For the
// case of dp[n], we need to consider if the last character can be decoded properly, if it can, then it would have at
// least dp[n - 1] ways of decoding. Now we need to consider if the last 2 characters can be decoded properly, if they
// can, then it would have at least another dp[n - 2] ways of decoding.
//
// Concise Strategy:
// - Create a dp array that denotes the number of ways to decode first n characters
// - dp[0] = 1 because there is only 1 way to decode empty str, because empty str yields nothing.
// - dp[1] = 0 if the first char of s is 0, otherwise  dp[1] = 1 because if the first char of s is within (1,9), it
// will always be decoded to a specific alphabet
// - dp[n] = ((lastDigitValue is valid) ? dp[n - 1] : 0)  + ((lastTwoDigitValues is valid) ? dp[n - 2] : 0)
//
// Example: "1226"
// "6" is decodable:
// - (1)(2)(2)(6)
// - (1)(22)(6)
// - (12)(2)(6)
// Notice it is really just adding 6 to all decodable ways of "122"
// "26" is decodable:
// - (1)(2)(26)
// - (12)(26)
// Notice it is really just adding 26 to all decodable ways of "12"

extension MediumDynamicProgrammingProblems {
    func numDecodings(_ s: String) -> Int {
        var dp: [Int] = Array(repeating: 0, count: s.count + 1)
        let intValues: [Int] = s.compactMap { $0.wholeNumberValue }
        
        dp[0] = 1
        dp[1] = (intValues[0] == 0) ? 0 : 1
        
        for n in 2..<dp.count {
            if intValues[n - 1] > 0 {
                dp[n] += dp[n - 1]
            }
            
            let lastTwoDigitValues: Int = (intValues[n - 2] * 10) + intValues[n - 1]
            if lastTwoDigitValues >= 10 && lastTwoDigitValues <= 26 {
                dp[n] += dp[n - 2]
            }
        }
        
        return dp[s.count]
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
//
// Concise Strategy:
// - Create a DP array in which dp[n] = is the first n chars of a word breakable.
// - dp[0] = true by default
// - loop through all substring from beginning char to end char from size 1 to size n
// - for each substr, break them further apart into substr0 and substr1 in which substr0 = substr[0..<j+1] and substr1
// = substr[j+1..<i]. Notice that we know whether substr[0..<j+1] is breakable by looking at dp[j+1] and we just need
// to check whether wordDict contains substr[j+1..<i] in order to update dp[i].
// - return dp[s.count] at the end

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
// 1               dp[0] = 0; dp[1] = 1
// 1 2             dp[2] = max(dp[1], dp[0] + nums[1]) = 2
// 1 2 1           dp[3] = max(dp[2], dp[1] + nums[2]) = 2
// 1 2 1 2         dp[4] = max(dp[3], dp[2] + nums[3]) = 4
// 1 2 1 2 1       dp[5] = max(dp[4], dp[3] + nums[4]) = 4
// 1 2 1 2 1 0     dp[6] = max(dp[5], dp[4] + nums[5]) = 4
// 1 2 1 2 1 0 3   dp[7] = max(dp[6], dp[5] + nums[6]) = 7
//
// Strategy: Create a dp array in which dp[n] is the max amount that can be robbed by n houses. dp[0] = 0 because you
// can only rob $0 from 0 house. dp[1] = nums[0] because if there is only one house, the max amount you can rob is the
// money stashed in that only house. dp[n] = max(dp[n - 1], dp[n - 2] + nums[n - 1]) because you can either steal from
// the last house or second to last house without triggering the alarm.
//
// Concise Strategy:
// - Create a dp array in which dp[n] is the max amount that can be robbed by n houses.
// - dp[0] = 0 because you can only rob $0 if there is no house for you to rob
// - dp[1] = nums[0] because you can only the first house if there is only one house for you to rob
// - dp[n] = max(dp[n - 1], dp[n - 2] + nums[n - 1]) because you can only steal from thes last or second to last house
// without triggering the alarm.
// - return dp[nums.count]

extension MediumDynamicProgrammingProblems {
    func rob(_ nums: [Int]) -> Int {
        var dp: [Int] = Array(repeating: 0, count: nums.count + 1)
        dp[1] = nums[0]
        
        for house in 2..<dp.count {
            let sumFromFirstPath: Int = dp[house - 1]
            let sumFromSecondPath: Int = dp[house - 2] + nums[house - 1]
            dp[house] = max(sumFromFirstPath, sumFromSecondPath)
        }
        
        return dp[dp.count - 1]
    }
}

// MARK: - 213. House Robber II
// LINK: https://leetcode.com/problems/house-robber-ii/
//
// Description: You are a professional robber planning to rob houses along a street. Each house has a certain amount of
// money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the
// last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police
// if two adjacent houses were broken into on the same night. Given an integer array nums representing the amount of
// money of each house, return the maximum amount of money you can rob tonight without alerting the police.
//
// Strategy: Notice that since the houses are lined up in a circle, it really means that we can either rob the first or
// last house but not both. As a result, we can easily reuse the house robber I solution on both the
// numsWithoutFirstHouse and numsWithoutLastHouse and return the max from them if nums >= 2.
//
// Concise Strategy:
// - Create a dp array in which dp[n] is the max amount that can be robbed by n houses.
// - dp[0] = 0 because you can only rob $0 if there is no house for you to rob
// - dp[1] = nums[0] because you can only the first house if there is only one house for you to rob
// - dp[n] = max(dp[n - 1], dp[n - 2] + nums[n - 1]) because you can only steal from thes last or second to last house
// without triggering the alarm.
// - Notice that the houses are line up in a circle, what it means is that we can either rob the first or last house
// but not both. So we can put this dp array into a util method, and create numsA = Array(nums[1...]), numsB =
// Array(nums[0..<(nums.count - 1)]) and return the max amount by comparing both of them in the util method.

extension MediumDynamicProgrammingProblems {
    func rob2(_ nums: [Int]) -> Int {
        guard nums.count > 1 else {
            return nums[0]
        }
        
        let maxAmountRobbedwithoutFirstHouse: Int = rob(Array(nums[1...]))
        let maxAmountRobbedwithoutLastHouse: Int = rob(Array(nums[0..<(nums.count - 1)]))
        return max(maxAmountRobbedwithoutFirstHouse, maxAmountRobbedwithoutLastHouse)
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
//
// Concise Strategy:
// - create a dp array in which dp[n] = min number of coin to return amount of n.
// - set dp[0] = 0 because 0 is min number of coin to return amount of 0.
// - fill the dp array with arbitrary large number in every element, such as (amount + 1)
// - in iteration n of constructing the dp array, loop through the coins, compare dp[n] with (1 + dp[n - coin]), update
// dp[n] with the minimum value of the comparison.
// - if dp[n] != amount + 1 return dp[n] else return -1

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
//
// Concise Strategy:
// - Create a dp array in which dp[i] = length of LIS that ends on ith element.
// - populate the dp array with value = 1
// - Loop through the indices of nums array, for all indices j before the current index, dp[i] = max(dp[j] + 1) for all
// j where nums[j] < nums[i] and j < i
// - After finishing the dp array computation, we can loop through the dp array to get the length of the LIS.

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

// MARK: - 377. Combination Sum IV
// LINK: https://leetcode.com/problems/combination-sum-iv/
//
// Description: Given an array of distinct integers nums and a target integer target, return the number of possible
// combinations that add up to target. The answer is guaranteed to fit in a 32-bit integer.
//
// Strategy: We want to create a DP array to denote the number of unique pathways to sum up to specific target. DP[0] =
// 1 because there is only 1 way to sum up to 0, which is not visiting any number in the nums array. For computation of
// DP[n], consider any number in nums, as long as it is less than or equal to n, it can potentially be a node that can
// get us to n. So DP[n] = DP[smallestNumInNums <= n] + DP[secondSmallestNumInNums <= n] + ... + DP[biggestNumInNums <=
// n]. Let's try to understand better with an example: nums = [1, 2, 3], target = 4. DP[0] = 1; DP[1] = DP[1 - 1] = 1;
// DP[2] = DP[2 - 2] + DP[2 - 1] = 2; DP[3] = DP[3 - 1] + DP[3 - 2] + DP[3 - 3] = 4; DP[4] = DP[4 - 1] + DP[4 - 2] +
// DP[4 - 3] = 7
//
// Concise Stategy:
// - Create a dp array in which dp[n] = number of unique combos that sums up to n.
// dp[0] = 0 because the number of unique combos that sums up to 0 is 0.
// dp[n] = dp[n - nums0] + dp[n - nums1] + dp[n - nums2] + ... + dp[n - numsN] for (nums0, ..., numsN) in nums
// return dp[target] in the end.

extension MediumDynamicProgrammingProblems {
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var dp: [Int] = Array(repeating: 0, count: target + 1)
        dp[0] = 1
        
        for i in 1..<dp.count {
            for num in nums {
                guard i - num >= 0 else {
                    continue
                }
                
                dp[i] &+= dp[i - num]
            }
        }
        
        return dp[target]
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
// longer LCS. Hence LCS("EA", "CE") = max(LCS("E", "CE"), LCS("EA", "C")) = 1.

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
