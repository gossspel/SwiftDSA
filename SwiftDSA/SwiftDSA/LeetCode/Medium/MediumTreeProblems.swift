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

// MARK: - 105. Construct Binary Tree from Preorder and Inorder Traversal
// LINK: https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/
//
// Description: Given two integer arrays preorder and inorder where preorder is the preorder traversal of a binary tree
// and inorder is the inorder traversal of the same tree, construct and return the binary tree.
//
// Strategy: Notice that the first node of preOrder array is always the root node. Also notice that the nodes that come
// before the root node in inOrder array are nodes of the left subtree, and the nodes that come after the root node are
// nodes of the right subtree. With these information, we can recursively recreate the whole tree.

extension MediumTreeProblems {
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {        
        guard let rootValue = preorder.first, let rootIOIndex = inorder.firstIndex(of: rootValue) else {
            return nil
        }
        
        let root = TreeNode(rootValue)
        root.left = buildTree(Array(preorder[1..<(1 + rootIOIndex)]), Array(inorder[0..<rootIOIndex]))
        root.right = buildTree(Array(preorder[(1 + rootIOIndex)...]), Array(inorder[(rootIOIndex + 1)...]))
        return root
    }
}
