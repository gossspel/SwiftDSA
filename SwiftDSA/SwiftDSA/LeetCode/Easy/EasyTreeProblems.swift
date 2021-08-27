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

// MARK: - 226. Invert Binary Tree
// LINK: https://leetcode.com/problems/invert-binary-tree/
//
// Description: Given the root of a binary tree, invert the tree, and return its root.
//
// Strategy: Use BFS or DFS to traverse the whole tree. Swap left and right on every node.

extension EasyTreeProblems {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let sureRoot = root else {
            return nil
        }
        
        var currentLevelNodes: [TreeNode] = [sureRoot]
        
        while !currentLevelNodes.isEmpty {
            var nextLevelNodes: [TreeNode] = []
            
            for currentLevelNode in currentLevelNodes {
                if let currentLeft = currentLevelNode.left {
                    nextLevelNodes.append(currentLeft)
                }
                
                if let currentRight = currentLevelNode.right {
                    nextLevelNodes.append(currentRight)
                }
                
                let temp = currentLevelNode.left
                currentLevelNode.left = currentLevelNode.right
                currentLevelNode.right = temp
            }
            
            currentLevelNodes = nextLevelNodes
        }
        
        return root
    }
}

// MARK: - 235. Lowest Common Ancestor of a Binary Search Tree
// LINK: https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/
//
// Description: Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.
// According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as
// the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
//
// Strategy: Basically we are trying to see if both p and q are in one side of the subtree (either left subtree or
// right subtree), if they are, then we will update the root to be root.left/root.right depending on where the p and q
// reside in. Otherwise, p and q are in different subtree and the root must be the lowest common ancestor, so we would
// return that.

extension EasyTreeProblems {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let rootVal = root?.val, let pVal = p?.val, let qVal = q?.val else {
            return nil
        }
        
        if pVal > rootVal && qVal > rootVal {
            return lowestCommonAncestor(root?.right, p, q)
        } else if pVal < rootVal && qVal < rootVal {
            return lowestCommonAncestor(root?.left, p, q)
        } else {
            return root
        }
    }
}

// MARK: - 572. Subtree of Another Tree
// LINK: https://leetcode.com/problems/subtree-of-another-tree/
// VIDEO: https://www.youtube.com/watch?v=HdMs2Fl_I-Q
//
// Description: Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with
// the same structure and node values of subRoot and false otherwise. A subtree of a binary tree tree is a tree that
// consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree
// of itself.
//
// Strategy: compare the root and subRoot, if root is nil, return false, because the non nil subRoot can't not be a \
// subtree of a nil pointer. If the root is the same as the subRoot, return true, else call isSubtree on (root.left,
// subRoot) and (root.right, subRoot) and return true if one of them is true

extension EasyTreeProblems {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if root == nil {
            return false
        } else if isSameTreeAgain(p: root, q: subRoot) {
            return true
        } else {
            let isLeftSubTree: Bool = isSubtree(root?.left, subRoot)
            let isRightSubTree: Bool = isSubtree(root?.right, subRoot)
            return isLeftSubTree || isRightSubTree
        }
    }
    
    func isSameTreeAgain(p: TreeNode?, q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        
        guard let sureRoot1 = p, let sureRoot2 = q else {
            return false
        }
        
        guard sureRoot1.val == sureRoot2.val else {
            return false
        }
        
        let identicalLeft: Bool = isSameTreeAgain(p: sureRoot1.left, q: sureRoot2.left)
        let identicalRight: Bool = isSameTreeAgain(p: sureRoot1.right, q: sureRoot2.right)
        
        return identicalLeft && identicalRight
    }
    
    // Strategy: Traverse the root until we found nodes with the same value as the subRoot. If that doesn't happen,
    // return false; if that happens, compare those nodes and the subRoot to see if if we can find a same tree pair.
    
    func isSubtreeBruteForce(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        guard let sureSubRoot = subRoot else {
            return false
        }

        let nodes = nodesWithValueInTree(root, value: sureSubRoot.val)
        for node in nodes {
            if isSameTreeAgain(p: sureSubRoot, q: node) {
                return true
            }
        }

        return false
    }

    func nodesWithValueInTree(_ root: TreeNode?, value: Int) -> [TreeNode] {
        guard let sureRoot = root else {
            return []
        }

        var nodes: [TreeNode] = []

        if sureRoot.val == value {
            nodes.append(sureRoot)
        }

        nodes += nodesWithValueInTree(sureRoot.left, value: value)
        nodes += nodesWithValueInTree(sureRoot.right, value: value)
        return nodes
    }
}
