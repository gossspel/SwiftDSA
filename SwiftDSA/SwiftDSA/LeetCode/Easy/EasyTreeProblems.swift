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

// MARK: - 100. Same Tree
// LINK: https://leetcode.com/problems/same-tree/
//
// Description: Given the roots of two binary trees p and q, write a function to check if they are the same or not. Two
// binary trees are considered the same if they are structurally identical, and the nodes have the same value.
//
// Strategy: If p and q have the same value and are both leave nodes, return true. Otherwise we want to make sure
// isSameTree(p.left, q.left) == true and isSameTree(p.right, q.right) == true.

extension EasyTreeProblems {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        } else if let sureP = p, let sureQ = q {
            guard sureP.val == sureQ.val else {
                return false
            }
            
            if sureP.left == nil && sureP.right == nil && sureQ.left == nil && sureQ.right == nil {
                return true
            } else {
                return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
            }
        } else {
            // Either p or q is nil, so they are not the same
            return false
        }
    }
}

// MARK: - 101. Symmetric Tree
// LINK: https://leetcode.com/problems/symmetric-tree/
//
// Description: Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its
// center).
//
// Strategy: For the iterative solution, do a left to right BFS, in each tree levels, append the values from the node
// to an array, and check to make sure the array is symmetric. For the recursive solution, create a method to
// recursively compare left and right tree. Return true if both leftRoot and RightRoot are nil because nil trees are by
// definition symmetrical and we need that as a stopping base case. If leftRoot.val != rightRoot.val, return false,
// else we will do the recursive case of comparing leftRoot.left with rightRight.right and rightRoot.left with
// leftRoot.right.

extension EasyTreeProblems {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let sureRoot = root else {
            return true
        }
        
        return isSymmetric(leftRoot: sureRoot.left, rightRoot: sureRoot.right)
    }
    
    func isSymmetric(leftRoot: TreeNode?, rightRoot: TreeNode?) -> Bool {
        guard leftRoot?.val == rightRoot?.val else {
            return false
        }
        
        if leftRoot?.val == nil && rightRoot?.val == nil {
            return true
        }
        
        let isLeftTreeSymmetric: Bool = isSymmetric(leftRoot: leftRoot?.left, rightRoot: rightRoot?.right)
        let isRightTreeSymmetric: Bool = isSymmetric(leftRoot: leftRoot?.right, rightRoot: rightRoot?.left)
        return isLeftTreeSymmetric && isRightTreeSymmetric
    }
    
    func isSymmetricIterative(_ root: TreeNode?) -> Bool {
        guard root != nil else {
            return true
        }
        
        var currentLevelNodes: [TreeNode?] = [root]
        
        while !currentLevelNodes.isEmpty {
            var nextLevelNodes: [TreeNode?] = []
            
            for currentLevelNode in currentLevelNodes {
                nextLevelNodes.append(currentLevelNode?.left)
                nextLevelNodes.append(currentLevelNode?.right)
            }
            
            // [0 1 2 3 4] => midPointIndex = 2, [0 1 2 3] => midPointIndex = 2
            let currentLevelMidPointIndex: Int = currentLevelNodes.count / 2
            
            for i in 0..<currentLevelMidPointIndex {
                if currentLevelNodes[i]?.val != currentLevelNodes[currentLevelNodes.count - 1 - i]?.val {
                    return false
                }
            }
            
            if (currentLevelNodes.filter { $0 != nil }).isEmpty {
                currentLevelNodes = []
            } else {
                currentLevelNodes = nextLevelNodes
            }
        }
        
        return true
    }
}

// MARK: - 104. Maximum Depth of Binary Tree
// LINK: https://leetcode.com/problems/maximum-depth-of-binary-tree/
//
// Description: Given the root of a binary tree, return its maximum depth. A binary tree's maximum depth is the number
// of nodes along the longest path from the root node down to the farthest leaf node.
//
// Strategy: Do breath first search to traverse the tree and return the maximum tree level.

extension EasyTreeProblems {
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let sureRoot = root else {
            return 0
        }
        
        var currentLevel: Int = 0
        var currentLevelNodes: [TreeNode] = [sureRoot]
        
        while !currentLevelNodes.isEmpty {
            var nextLevelNodes: [TreeNode] = []
            
            for currentLevelNode in currentLevelNodes {
                if let left = currentLevelNode.left {
                    nextLevelNodes.append(left)
                }
                
                if let right = currentLevelNode.right {
                    nextLevelNodes.append(right)
                }
            }
            
            currentLevelNodes = nextLevelNodes
            currentLevel += 1
        }
        
        return currentLevel
    }
}

