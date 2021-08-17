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

// MARK: - 20. Valid Parentheses
// LINK: https://leetcode.com/problems/valid-parentheses/
//
// Description: Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input
// string is valid. An input string is valid if: 1.) Open brackets must be closed by the same type of brackets. 2.)
// Open brackets must be closed in the correct order.
//
// Strategy: Use an array as a stack. Loop through the string, if the character is '(', '[', or '{', push it to the
// stack, if the character is ')', ']' or '}', pop from the stack and check if the popped element can form a complete
// parantheses with the current character, if it can't, return false. When the loop is finished, if the stack is empty,
// return true, else return false

extension EasyStringProblems {
    func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else {
            return false
        }
        
        var charStack: [Character] = []
        
        for char in s {
            if char == "(" || char == "[" || char == "{" {
                charStack.append(char)
            } else if char == ")" || char == "]" || char == "}" {
                guard let poppedChar = charStack.popLast() else {
                    return false
                }
                
                if char == ")" && poppedChar != "(" {
                    return false
                }
                
                if char == "]" && poppedChar != "[" {
                    return false
                }
                
                if char == "}" && poppedChar != "{" {
                    return false
                }
            }
        }
        
        return charStack.isEmpty
    }
}

// MARK: - 242. Valid Anagram
// LINK: https://leetcode.com/problems/valid-anagram/
//
// Description: Given two strings s and t, return true if t is an anagram of s, and false otherwise.
//
// Strategy: Create a dict called occurrenceByChar: [Char: Int]. Loop through the first string, update occurrenceByChar
// by incrementing the occurrence. After that, loop through the second string, update occurrenceByChar by decrementing
// the occurrence. In the end, loop through the dict and make sure the occurrence of any char is 0.

extension EasyStringProblems {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var occurrenceByChar: [Character: Int] = [:]
        let sChars: [Character] = Array(s)
        
        for char in sChars {
            occurrenceByChar[char] = (occurrenceByChar[char] ?? 0) + 1
        }
        
        let tChars: [Character] = Array(t)
        
        for char in tChars {
            occurrenceByChar[char] = (occurrenceByChar[char] ?? 0) - 1
        }
        
        for (_, value) in occurrenceByChar {
            if value != 0 {
                return false
            }
        }
        
        return true
    }
}
