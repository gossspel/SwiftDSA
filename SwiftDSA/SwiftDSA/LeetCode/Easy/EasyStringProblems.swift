//
//  EasyStringProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/2/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class EasyStringProblems {}

// MARK: - 14. Longest Common Prefix
// Write a function to find the longest common prefix string amongst an array of strings.
// If there is no common prefix, return an empty string.

extension EasyStringProblems {
    static func longestCommonPrefix(_ strs: [String]) -> String {
        guard !strs.isEmpty else {
            return ""
        }
        
        let sortedStrs: [String] = strs.sorted()
        var currentLCP: String = sortedStrs.first ?? ""
        
        for str in sortedStrs {
            currentLCP = getCommonPrefix(strA: currentLCP, strB: str)
            
            if currentLCP == "" {
                return ""
            }
        }
        
        return currentLCP
    }
    
    static func getCommonPrefix(strA: String, strB: String) -> String {
        var commonPrefix: String = ""
        let timeToIterate: Int = min(strA.count, strB.count)
        
        for i in 0..<timeToIterate {
            let index = strA.index(strA.startIndex, offsetBy: i)
            if strA[index] == strB[index] {
                commonPrefix += String(strA[index])
            } else {
                break
            }
        }
        
        return commonPrefix
    }
}

