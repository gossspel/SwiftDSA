//
//  HardStringProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/26/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class HardStringProblems {}

// MARK: - 32. Longest Valid Parentheses
// LINK: https://leetcode.com/problems/longest-valid-parentheses/
//
// Description: Given a string containing just the characters '(' and ')', find the length of the longest valid
// (well-formed) parentheses substring.
//
// Strategy: Use three vars openCount, closeCount, and longestStreak, loop through the string, if the char is '(',
// increment the openCount, else if char is ')', increment the closeCount. When we increment the closeCount, if
// closeCount == openCount, we would have balanced parentheses, so we should update the longestStreak if openCount +
// closeCount > longestStreak. If closeCount > openCount, we would have a lone close paranthesis that happens before
// any lone open parathesis, so we would have to reset openCount and closeCount to zero to try to fish for the next
// longestStreak if there is any. This left scanning approach is good for most cases beside "()((())", in which the
// longestStreak would be 2, which is in correct. Luckily, we can perform a similar right scanning approach to make
// this algorithm complete. Return longestStreak after the left and right scanning.

extension HardStringProblems {
    func longestValidParentheses(_ s: String) -> Int {
        var openCount: Int = 0
        var closeCount: Int = 0
        var longestStreak: Int = 0

        // NOTE: Left Scan
        for char in s {
            if char == "(" {
                openCount += 1
            } else {
                closeCount += 1
            }
            if openCount == closeCount {
                longestStreak = max(longestStreak, openCount + closeCount)
            } else if closeCount > openCount {
                // NOTE: reset continuous count at edge cases like "()()" + ")" "((()))"
                openCount = 0
                closeCount = 0
            }
        }

        openCount = 0
        closeCount = 0

        // NOTE: Right Scan
        for char in s.reversed() {
            if char == ")" {
                closeCount += 1
            } else {
                openCount += 1
            }
            if openCount == closeCount {
                longestStreak = max(longestStreak, openCount + closeCount)
            } else if openCount > closeCount {
                // NOTE: reset continuous count at edge cases like "((()))" + "(" + "()()"
                openCount = 0
                closeCount = 0
            }
        }

        return longestStreak
    }
}
