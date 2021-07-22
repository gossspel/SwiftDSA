//
//  MediumGraphProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 7/21/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

public class Node {
    public var val: Int
    public var neighbors: [Node?]
    public init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}

class MediumGraphProblems {}

// MARK: - 133. Clone Graph
// LINK: https://leetcode.com/problems/clone-graph/
//
// Description: Given a reference of a node in a connected undirected graph. Return a deep copy (clone) of the graph.
// Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.
//
// Strategy: Use BFS, use a nodeByValue: [Int: Node] to store the copied node. Use BFS to copy the nodes and query the
// nodeByValue to update the neighbors on each node. return nodeByValue[firstNodeValue] in the end. Alternatively, we
// can also use DFS.

extension MediumGraphProblems {
    func cloneGraph(_ node: Node?) -> Node? {
        guard let sureNode = node else {
            return nil
        }
        
        var nodeByValue: [Int: Node] = [sureNode.val: Node(sureNode.val)]
        var currentNodes: [Node] = [sureNode]
        
        while !currentNodes.isEmpty {
            var nextNodes: [Node] = []
            
            for currentNode in currentNodes {
                if let cachedNode = nodeByValue[currentNode.val], !cachedNode.neighbors.isEmpty {
                    // The node has already been copied, skip the copy process
                    continue
                } else {
                    for neighbor in currentNode.neighbors {
                        guard let neighborToCopy = neighbor else {
                            continue
                        }
                        
                        // copy the neighbor, and save the neighbor into the dictionary if we haven't done so
                        if let cachedNeighbor = nodeByValue[neighborToCopy.val] {
                            nodeByValue[currentNode.val]?.neighbors.append(cachedNeighbor)
                        } else {
                            let copiedNeighbor = Node(neighborToCopy.val)
                            nodeByValue[currentNode.val]?.neighbors.append(copiedNeighbor)
                            nodeByValue[neighborToCopy.val] = copiedNeighbor
                            nextNodes.append(neighborToCopy)
                        }
                    }
                }
            }
            
            currentNodes = nextNodes
        }
        
        return nodeByValue[sureNode.val]
    }
    
    func cloneGraphDFS(_ node: Node?) -> Node? {
        guard let sureNode = node else {
            return nil
        }
        
        var nodeByValue: [Int: Node] = [sureNode.val: Node(sureNode.val)]
        var currentNodes: [Node] = [sureNode]
        
        while !currentNodes.isEmpty {
            let currentNode = currentNodes.removeLast()
            
            if let cachedNode = nodeByValue[currentNode.val], !cachedNode.neighbors.isEmpty {
                // The node has already been copied, skip the copy process
                continue
            } else {
                for neighbor in currentNode.neighbors {
                    guard let neighborToCopy = neighbor else {
                        continue
                    }
                    
                    // copy the neighbor, and save the neighbor into the dictionary if we haven't done so
                    if let cachedNeighbor = nodeByValue[neighborToCopy.val] {
                        nodeByValue[currentNode.val]?.neighbors.append(cachedNeighbor)
                    } else {
                        let copiedNeighbor = Node(neighborToCopy.val)
                        nodeByValue[currentNode.val]?.neighbors.append(copiedNeighbor)
                        nodeByValue[neighborToCopy.val] = copiedNeighbor
                        currentNodes.append(neighborToCopy)
                    }
                }
            }
        }
        
        return nodeByValue[sureNode.val]
    }
}
