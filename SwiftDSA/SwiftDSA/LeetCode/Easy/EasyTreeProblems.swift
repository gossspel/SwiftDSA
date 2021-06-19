//
//  EasyTreeProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyTreeProblems {}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init() {
        self.val = 0
        self.left = nil
        self.right = nil
    }
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public init(_ val: Int,
                _ left: TreeNode?,
                _ right: TreeNode?)
    {
        self.val = val
        self.left = left
        self.right = right
    }
}
 

// MARK: - 94. Binary Tree Inorder Traversal
// LINK: https://leetcode.com/problems/binary-tree-inorder-traversal/
//
// Description: Given the root of a binary tree, return the inorder traversal of its nodes' values.
//
// Strategy: inorder (LNR), need to use recursion. If the node has neither left or right, return [node.val]. If the
// node has left, we need to use recursion to get the traversal sequence on the left tree first, and if the node has
// right, we need to use recursion to get the traversal sequence on the right tree. The end result will look like:
// results = leftTreeTraversalSequence + [node.val] + rightTreeTraversalSequence

extension EasyTreeProblems {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let sureRoot = root else {
            return []
        }
        
        if sureRoot.left == nil && sureRoot.right == nil {
            return [sureRoot.val]
        }
        
        let leftTreeTraversalSequence: [Int] = (sureRoot.left != nil) ? inorderTraversal(sureRoot.left) : []
        let rightTreeTraversalSequence: [Int] = (sureRoot.right != nil) ? inorderTraversal(sureRoot.right) : []
        let results: [Int] = leftTreeTraversalSequence + [sureRoot.val] + rightTreeTraversalSequence
        return results
    }
}
