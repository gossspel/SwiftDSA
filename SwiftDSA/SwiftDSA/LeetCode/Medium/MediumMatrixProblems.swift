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

// MARK: - 79. Word Search
// LINK: https://leetcode.com/problems/word-search/
// VIDEO: https://www.youtube.com/watch?v=vYYNp0Jrdv0
//
// Description: Given an m x n grid of characters board and a string word, return true if word exists in the grid. The
// word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or
// vertically neighboring. The same letter cell may not be used more than once.
//
// Strategy: loop through the board, whenever we find a character that matches the beginning of the word, do a DFS
// backtrack, in which we pass in the board, word as chars, rowIndex, columnIndex, and inProgressSequenceCount.
// Basically we are looking at a particular coordinate (rowIndex, columnIndex) and determine if it can lead to a path
// that matches the word. In the base case, we return true if chars.count == inProgressSequenceCount, and we return
// false if that coordinate is out of bound or doesn't match with the corresponding character from the word. As long as
// that coordinate is within the bound and matches the corresponding order of the character within the word, we can
// continue the recursive case. In the recursive case, we will recursively check the top, left, bottom, right and
// return true if any one of them is true.

extension MediumMatrixProblems {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let chars: [Character] = Array(word)
        let startingChar: Character = chars[0]
        var editableBoard: [[Character]] = board
        
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == startingChar && backtrack(board: &editableBoard,
                                                            chars: chars,
                                                            rowIndex: i,
                                                            columnIndex: j,
                                                            inProgressSequenceCount: 0)
                {
                    return true
                }
            }
        }
        
        return false
    }
    
    func backtrack(board: inout [[Character]],
                   chars: [Character],
                   rowIndex: Int,
                   columnIndex: Int,
                   inProgressSequenceCount: Int) -> Bool
    {
        if chars.count == inProgressSequenceCount {
            return true
        }
        
        if (rowIndex < 0 ||
                rowIndex == board.count ||
                columnIndex < 0 ||
                columnIndex == board[rowIndex].count ||
                board[rowIndex][columnIndex] != chars[inProgressSequenceCount])
        {
            return false
        }
        
        let temp: Character = board[rowIndex][columnIndex]
        
        board[rowIndex][columnIndex] = Character(" ")

        let existOnLeft: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex - 1,
                                          columnIndex: columnIndex,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        let existOnRight: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex + 1,
                                          columnIndex: columnIndex,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        let existOnTop: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex,
                                          columnIndex: columnIndex - 1,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        let existOnBottom: Bool = backtrack(board: &board,
                                          chars: chars,
                                          rowIndex: rowIndex,
                                          columnIndex: columnIndex + 1,
                                          inProgressSequenceCount: inProgressSequenceCount + 1)
        
        board[rowIndex][columnIndex] = temp
        
        let hasFound: Bool = existOnLeft || existOnRight || existOnTop || existOnBottom
        return hasFound
    }
}
