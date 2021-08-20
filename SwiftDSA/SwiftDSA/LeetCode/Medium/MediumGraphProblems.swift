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

// MARK: - 200. Number of Islands
// LINK: https://leetcode.com/problems/number-of-islands/
// VIDEO: https://www.youtube.com/watch?v=o8S2bO3pmO4
//
// Description: Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the
// number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or
// vertically. You may assume all four edges of the grid are all surrounded by water.
//
// Strategy: We want to loop through the 2D array, identify each island, and remove the island from the array and
// repeat until we reach the end of the 2D array.

extension MediumGraphProblems {
    func numIslands(_ grid: [[Character]]) -> Int {
        var copiedGrid: [[Character]] = grid
        var islandCount: Int = 0
        
        for row in 0..<copiedGrid.count {
            for column in 0..<copiedGrid[row].count {
                guard copiedGrid[row][column] == "1" else {
                    continue
                }
                
                if identifyPotentialIslandAndRemoveItFromTheMap(grid: &copiedGrid, row: row, column: column) {
                    islandCount += 1
                }
            }
        }
        
        return islandCount
    }
    
    func identifyPotentialIslandAndRemoveItFromTheMap(grid: inout [[Character]], row: Int, column: Int) -> Bool {
        guard row < grid.count, row > -1, column < grid[row].count, column > -1, grid[row][column] == "1" else {
            return false
        }
        
        // remove the marked land from the map
        grid[row][column] = "0"
        
        // process the cell above
        _ = identifyPotentialIslandAndRemoveItFromTheMap(grid: &grid, row: row - 1, column: column)
        
        // process the cell below
        _ = identifyPotentialIslandAndRemoveItFromTheMap(grid: &grid, row: row + 1, column: column)
        
        // process the cell on left
        _ = identifyPotentialIslandAndRemoveItFromTheMap(grid: &grid, row: row, column: column - 1)
        
        // process the cell on right
        _ = identifyPotentialIslandAndRemoveItFromTheMap(grid: &grid, row: row, column: column + 1)
        
        return true
    }
}



// MARK: - 207. Course Schedule
// LINK: https://leetcode.com/problems/course-schedule/
// VIDEO: https://www.youtube.com/watch?v=EgI5nU9etnU
//
// Description: There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are
// given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you
// want to take course ai. For example, the pair [0, 1], indicates that to take course 0 you have to first take course
// 1. Return true if you can finish all courses. Otherwise, return false.
//
// Strategy: In order to check whether we can finish a particular course, we would create a graph in which a course is
// a node, and it will point to each of its prereqs individually, if there is a cycle in the graph, then we know we
// can't finish all courses for sure. In order to detect the cycle in the graph, we would rely on using a set to check
// if we are visiting the same node twice

extension MediumGraphProblems {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var prereqsByCourse: [Int: [Int]] = [:]

        for i in 0..<prerequisites.count {
            prereqsByCourse[prerequisites[i][0]] =  prereqsByCourse[prerequisites[i][0]] ?? []
            prereqsByCourse[prerequisites[i][0]]?.append(prerequisites[i][1])
        }

        guard prereqsByCourse.keys.count < numCourses else {
            return false
        }

        var visitedSet: Set<Int> = Set()

        for course in prereqsByCourse.keys {
            if !canFinishParticular(course: course, prereqsByCourse: &prereqsByCourse, visitedSet: &visitedSet) {
                return false
            }
        }

        return true
    }

    func canFinishParticular(course: Int, prereqsByCourse: inout [Int: [Int]], visitedSet: inout Set<Int>) -> Bool {
        if visitedSet.contains(course) {
            return false
        }

        guard let prereqs = prereqsByCourse[course], !prereqs.isEmpty else {
            return true
        }

        visitedSet.insert(course)

        for prereq in prereqs {
            if !canFinishParticular(course: prereq, prereqsByCourse: &prereqsByCourse, visitedSet: &visitedSet) {
                return false
            }
        }

        prereqsByCourse[course] = []
        visitedSet.remove(course)
        return true
    }
}
