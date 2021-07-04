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
        
        let leftPreviousUPs: Int = recursiveUniquePathDestinationCoordinates(rowIndex: rowIndex - 1, columnIndex: columnIndex)
        let topPreviousUPs: Int = recursiveUniquePathDestinationCoordinates(rowIndex: rowIndex, columnIndex: columnIndex - 1)
        let result = leftPreviousUPs + topPreviousUPs
        uniquePathsXY["\(rowIndex),\(columnIndex)"] = result
        return result
    }
}
