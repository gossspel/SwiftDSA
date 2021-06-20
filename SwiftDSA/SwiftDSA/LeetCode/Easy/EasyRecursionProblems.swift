//
//  EasyRecursionProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyRecursionProblems {
    var climbStairsCache: [Int: Int] = [:]
}

// MARK: - 70. Climbing Stairs
// LINK: https://leetcode.com/problems/climbing-stairs/
//
// Description: You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2
// steps. In how many distinct ways can you climb to the top?
//
// Strategy: If you can only climb exactly 1 more step, you will have x = climbStairs(n - 1) ways to climb the stair
// case with n step. If you can only climb exactly 2 more steps, you will have x = climbStairs(n - 2) ways to climb the
// stair case with n steps. Since you can climb either 1 or 2 steps,
//
// n = 3
// 1 1 (1)
// 2 (1)
// 1 (2)
//
// n = 4
// 1 1 1 (1)
// 2 1 (1)
// 1 2 (1)
// 2 (2)
// 1 1 (2)

extension EasyRecursionProblems {
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 2
        } else {
            if let cachedValue = climbStairsCache[n] {
                return cachedValue
            } else {
                let value = climbStairs(n - 2) + climbStairs(n - 1)
                climbStairsCache[n] = value
                return value
            }
        }
    }
}
