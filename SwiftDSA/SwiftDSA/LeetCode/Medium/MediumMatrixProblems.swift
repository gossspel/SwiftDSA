//
//  MediumMatrixProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 9/15/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumMatrixProblems {}

// MARK: - 54. Spiral Matrix
// LINK: https://leetcode.com/problems/spiral-matrix/
// VIDEO: https://www.youtube.com/watch?v=BdQ2AkaTgOA
//
// Description: Given an m x n matrix, return all elements of the matrix in spiral order.
//
// Strategy: In a spiral order traversal, we are basically traversing in the order of right, down, left, and up and
// append the traversed element in a results array. Notice that each traversal would require us to shrink the bound.
// Initially the topRowBoundIndex = 0, bottomRowBoundIndex = rowCount - 1, leftColumnBoundIndex = 0,
// rightColumnBoundIndex = columnCount - 1. After traversing right for the first time, topRowBoundIndex would be
// updated to 1, because we have finished traversing the top row and would not need to revisit it again. Similarly,
// after traversing down for the first time, rightColumnBoundIndex would be updated to rowCount - 2, because we have
// finished traversing the right most row and would not need to revisit again. We will apply the same technique on
// subsequent traversals until the results.count == matrixRowCount * matrixColumnCount and then we could return the
// results as the answer.

extension MediumMatrixProblems {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var topRowBoundIndex: Int = 0
        var bottomRowBoundIndex: Int = matrix.count - 1
        var leftColumnBoundIndex: Int = 0
        var rightColumnBoundIndex: Int = matrix[0].count - 1
        var results: [Int] = []
        let total: Int = matrix.count * matrix[0].count
        
        while results.count < total {
            // Traverse right
            guard leftColumnBoundIndex <= rightColumnBoundIndex else { break }
            for columnIndex in leftColumnBoundIndex...rightColumnBoundIndex where results.count < total {
                results.append(matrix[topRowBoundIndex][columnIndex])
            }
            topRowBoundIndex += 1
            
            // Traverse down
            guard topRowBoundIndex <= bottomRowBoundIndex else { break }
            for rowIndex in topRowBoundIndex...bottomRowBoundIndex where results.count < total {
                results.append(matrix[rowIndex][rightColumnBoundIndex])
            }
            rightColumnBoundIndex -= 1
            
            // Traverse left
            guard leftColumnBoundIndex <= rightColumnBoundIndex else { break }
            for columnIndex in (leftColumnBoundIndex...rightColumnBoundIndex).reversed() where results.count < total {
                results.append(matrix[bottomRowBoundIndex][columnIndex])
            }
            bottomRowBoundIndex -= 1
            
            // Traverse up
            guard topRowBoundIndex <= bottomRowBoundIndex else { break }
            for rowIndex in (topRowBoundIndex...bottomRowBoundIndex).reversed() where results.count < total {
                results.append(matrix[rowIndex][leftColumnBoundIndex])
            }
            leftColumnBoundIndex += 1
        }
        
        return results
    }
}
