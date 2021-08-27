//
//  MediumTreeProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/19/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumTreeProblems {}

// MARK: - 98. Validate Binary Search Tree
// LINK: https://leetcode.com/problems/validate-binary-search-tree/
//
// Description: Given the root of a binary tree, determine if it is a valid binary search tree (BST). A valid BST is
// defined as follows: The left subtree of a node contains only nodes with keys less than the node's key. The right
// subtree of a node contains only nodes with keys greater than the node's key. Both the left and right subtrees must
// also be binary search trees.
//
// Strategy: The trickiest part of this problem is that we have to make sure the nodes of the right subtree are
// strictly greater than root, and the nodes of left subtree are strictly less than root. In order to achieve that, we
// need to pass in the min and max to a recursive method call.

extension MediumTreeProblems {
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let sureRoot = root else {
            return false
        }

        let isLeftSubtreeValid: Bool = isValidBST(root: root?.left, min: nil, max: sureRoot.val)
        let isRightSubtreeValid: Bool = isValidBST(root: root?.right, min: sureRoot.val, max: nil)
        return isLeftSubtreeValid && isRightSubtreeValid
    }

    func isValidBST(root: TreeNode?, min: Int?, max: Int?) -> Bool {
        guard let sureRoot = root else {
            return true
        }

        if let sureMax = max, sureRoot.val >= sureMax {
            return false
        }

        if let sureMin = min, sureRoot.val <= sureMin {
            return false
        }

        let isLeftSubtreeValid: Bool = isValidBST(root: root?.left, min: min, max: root?.val)
        let isRightSubtreeValid: Bool = isValidBST(root: root?.right, min: root?.val, max: max)
        return isLeftSubtreeValid && isRightSubtreeValid
    }
}

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

// MARK: - 208. Implement Trie (Prefix Tree)
// LINK: https://leetcode.com/problems/implement-trie-prefix-tree/
// VIDEO: https://www.youtube.com/watch?v=oobqoCJlHA0
//
// Description: A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and
// retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete
// and spellchecker. Implement the Trie class:
// - Trie() Initializes the trie object.
// - void insert(String word) Inserts the string word into the trie.
// - boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false
// otherwise.
// - boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix
// prefix, and false otherwise.
//
// Strategy: Create the TrieNode with var isEndOfWord: Bool and var trieDict: [Character: TrieNode]. Notice that the
// node doesn't hold any value, as the values would be held via the key of trieDict. With this TrieNode data structure,
// we can easily implement the Trie class.

class Trie {
    
    class TrieNode {
        var isEndOfWord: Bool
        var trieDict: [Character: TrieNode]
        
        init() {
            self.isEndOfWord = false
            self.trieDict = [:]
        }
    }
    
    var root: TrieNode

    /** Initialize your data structure here. */
    init() {
        self.root = TrieNode()
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        var currentNode: TrieNode? = self.root
        
        for char in word {
            if currentNode?.trieDict[char] == nil {
                currentNode?.trieDict[char] = TrieNode()
            }
            
            currentNode = currentNode?.trieDict[char]
        }
        
        currentNode?.isEndOfWord = true
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        var currentNode: TrieNode? = self.root
        
        for char in word {
            if let nextNode = currentNode?.trieDict[char] {
                currentNode = nextNode
            } else {
                return false
            }
        }
        
        return currentNode?.isEndOfWord ?? false
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        var currentNode: TrieNode? = self.root
        
        for char in prefix {
            if let nextNode = currentNode?.trieDict[char] {
                currentNode = nextNode
            } else {
                return false
            }
        }
        
        return true
    }
}

// MARK: - 230. Kth Smallest Element in a BST
// LINK: https://leetcode.com/problems/kth-smallest-element-in-a-bst/
//
// Description: Given the root of a binary search tree, and an integer k, return the kth (1-indexed) smallest element
// in the tree.
//
// Strategy: Recognize that an inorder traversal can visit a BST in ascending order. We will construct the ascending
// list of nodes using inorder traversal, and then return the kth = nth + 1 node.

extension MediumTreeProblems {
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        let nodeValues: [Int] = inOrderTraversal(root: root)
        let index: Int = k - 1
        return nodeValues[index]
    }
    
    func inOrderTraversal(root: TreeNode?) -> [Int] {
        guard let sureRoot = root else {
            return []
        }
        
        let leftSubtreeNodeValues: [Int] = inOrderTraversal(root: sureRoot.left)
        let rightSubtreeNodeValues: [Int] = inOrderTraversal(root: sureRoot.right)
        let nodeValues: [Int] = leftSubtreeNodeValues + [sureRoot.val] + rightSubtreeNodeValues
        return nodeValues
    }
    
    // Strategy: Recognize that you can save some space complexity by recursively updating the ascending index and
    // value, use var indexValue: [Int] which has 2 elements, the first element denotes the current ascending index and
    // the second element denotes the value of that node. When indexValue[0] == k, we can update indexValue[1] and
    // return it.
    
    func kthSmallestFaster(_ root: TreeNode?, _ k: Int) -> Int {
        var indexValue: [Int] = [0, 0]
        inOrderTraversal(root: root, indexValue: &indexValue, k: k)
        return indexValue[1]
    }
    
    func inOrderTraversal(root: TreeNode?, indexValue: inout [Int], k: Int) {
        guard let sureRoot = root else {
            return
        }
        
        inOrderTraversal(root: sureRoot.left, indexValue: &indexValue, k: k)
        
        indexValue[0] += 1
        
        if indexValue[0] == k {
            indexValue[1] = sureRoot.val
            return
        }
        
        inOrderTraversal(root: sureRoot.right, indexValue: &indexValue, k: k)
    }
}
