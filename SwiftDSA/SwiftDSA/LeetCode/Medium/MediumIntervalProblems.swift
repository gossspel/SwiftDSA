//
//  MediumIntervalProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 9/13/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumIntervalProblems {}

// MARK: - 435. Non-overlapping Intervals
// LINK: https://leetcode.com/problems/non-overlapping-intervals/
// VIDEO: https://www.youtube.com/watch?v=BTObFnHbD4U
//
// Description: Given an array of intervals intervals where intervals[i] = [starti, endi], return the minimum number of
// intervals you need to remove to make the rest of the intervals non-overlapping.
//
// Strategy: We are going to use a greedy algorithm approach that involves left and right pointer. First we want to
// sort the list of intervals by the start of the interval. By doing so, we can make sure each interval start at equal
// or less than the next interval. This is crucial because it makes sure no other interval are overlapping on the left
// side of any particular interval, and we only have to worry about intervals to the right of the current interval. We
// would have two index pointer, one called leftIndex and other called rightIndex. leftIndex starts at 0 and rightIndex
// starts at 1, and we would use a variable called erasedNIntervals to keep track of the count of the erased intervals.
// We will compare the intervals from sortedIntervals[leftIndex] and ortedIntervals[rightIndex]. If they don't overlap,
// we won't erase any interval, if leftInterval completely overlaps rightInterval, we will erase leftInterval and
// increment erasedNIntervals, and if leftInterval doesn't completely overlap rightInterval, we will erase right
// Interval and increment erasedNIntervals. After rightIndex reaches the number of intervals, we will stop the loop and
// return the erasedNIntervals.

extension MediumIntervalProblems {
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        guard intervals.count > 1 else {
            return 0
        }
        
        let sortedIntervals: [[Int]] = intervals.sorted { $0[0] < $1[0] }
        let numberOfIntervals: Int = sortedIntervals.count
        var leftIndex: Int = 0
        var rightIndex: Int = 1
        
        var erasedNIntervals: Int = 0
        
        while rightIndex < numberOfIntervals {
            if sortedIntervals[leftIndex][1] <= sortedIntervals[rightIndex][0] {
                // do nothing since they are no overlapping
                leftIndex = rightIndex
                rightIndex += 1
            } else {
                if sortedIntervals[leftIndex][1] >= sortedIntervals[rightIndex][1] {
                    // erase leftInterval because leftInterval completely overlaps rightInterval
                    leftIndex = rightIndex
                    rightIndex += 1
                    erasedNIntervals += 1
                } else {
                    // erase rightInterval because leftInterval is guaranteed to overlap with no other intervals but it
                    // is possible for the rightInterval to be overlapped with other intervals further to the right.
                    rightIndex += 1
                    erasedNIntervals += 1
                }
            }
        }
        
        return erasedNIntervals
    }
}
