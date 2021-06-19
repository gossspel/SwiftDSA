//
//  MediumTreeProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumTreeProblems {}

// MARK: - 102. Binary Tree Level Order Traversal
// LINK: https://leetcode.com/problems/binary-tree-level-order-traversal/
//
// Description: Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from
// left to right, level by level).
//
// Strategy: This is basically breadth first search. Use an array variable called nextLevelToProcess and a while loop.
// The idea is to keep clearing each level before moving onto the the next one. 

extension MediumTreeProblems {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let sureRoot = root else {
            return []
        }
        
        var currentLevelToProcess: [TreeNode] = [sureRoot]
        var currrentLevelValues: [Int] = []
        var nextLevelToProcess: [TreeNode] = []
        var results: [[Int]] = []
        
        while !currentLevelToProcess.isEmpty {
            currrentLevelValues = []
            nextLevelToProcess = []
            
            for node in currentLevelToProcess {
                currrentLevelValues.append(node.val)
                
                if let left = node.left {
                    nextLevelToProcess.append(left)
                }
                
                if let right = node.right {
                    nextLevelToProcess.append(right)
                }
            }
            
            results.append(currrentLevelValues)
            currentLevelToProcess = nextLevelToProcess
        }
        
        return results
    }
}
