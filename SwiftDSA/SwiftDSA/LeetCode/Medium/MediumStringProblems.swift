//
//  MediumStringProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/11/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumStringProblems {
    var cacheOfIsPalindrome: [String: Bool] = [:]
    var cacheOfLongestPalindrome: [String: String] = [:]
}

// MARK: - 5. Longest Palindromic Substring
// LINK: https://leetcode.com/problems/longest-palindromic-substring/
//
// Description: Given a string s, return the longest palindromic substring in s
//
// Strategy: The brute force iterative approach would be at least O(n^3) and brute force recursive approach would be
// O(2^n), so they are not really worth discussing. It looks at each character as the center of a palindrome and loops
// to determine the largest palindrome with that center. Not that this expand around the center char mechanism can only
// be used to find odd palindrome, but we can insert some arbitrary characters like "!" between every character to find
// both odd and even palindrome, as long as we remove the arbitrary characters "!" in the end.

extension MediumStringProblems {
    func longestPalindrome(_ s: String) -> String {
        var chars: [Character] = Array(s).reversed()
        let specialChar: Character = "!"
        var expandedChars: [Character] = Array(repeating: specialChar, count: (chars.count * 2) + 1)
        
        for i in 0..<expandedChars.count {
            if i % 2 != 0 {
                expandedChars[i] = chars.removeLast()
            }
        }
        
        let LPCharsWithSpecialChar: [Character] = longestPalindromeChars(chars: expandedChars)
        let LPChars: [Character] = LPCharsWithSpecialChar.filter { $0 != specialChar }
        let LPStr: String = String(LPChars)
        return LPStr
    }
    
    private func longestPalindromeChars(chars: [Character]) -> [Character] {
        var LPStart: Int = 0
        var LPEnd: Int = 0
        
        for i in 0..<chars.count {
            let currentLPStart: Int
            let currentLPEnd: Int
            (currentLPStart, currentLPEnd) = getLPStartAndEndFromExpandingCharAtIndex(chars: chars, index: i)
            
            let currentLPLength: Int = currentLPEnd - currentLPStart + 1
            let LPLength: Int = LPEnd - LPStart + 1
            
            if currentLPLength > LPLength {
                (LPStart, LPEnd) = (currentLPStart, currentLPEnd)
            }
        }
        
        let LPCharacters: [Character] = Array(chars[LPStart...LPEnd])
        return LPCharacters
    }
    
    private func getLPStartAndEndFromExpandingCharAtIndex(chars: [Character], index: Int) -> (Int, Int) {
        guard index < chars.count else {
            return (0, 0)
        }
        
        var LPStart: Int = index
        var LPEnd: Int = index
        let minLPStart: Int = 0
        let maxLPEnd: Int = chars.count - 1
        
        while (LPStart > minLPStart) && (LPEnd < maxLPEnd) {
            let nextLPStart: Int = LPStart - 1
            let nextLPEnd: Int = LPEnd + 1
            
            if chars[nextLPStart] == chars[nextLPEnd] {
                LPStart = nextLPStart
                LPEnd = nextLPEnd
            } else {
                break
            }
        }
        
        return (LPStart, LPEnd)
    }
}
