//
//  MediumStringProblems.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 6/11/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import Foundation

class MediumStringProblems {}

// MARK: - 3. Longest Substring Without Repeating Characters
// LINK: https://leetcode.com/problems/longest-substring-without-repeating-characters/
//
// Description: Given a string s, find the length of the longest substring without repeating characters.
//
// Strategy: Use the following vars: characterIndexMap: [Char: Int], start: Int, maxLength: Int. Loop through the
// string by each character. If the character does not exist in characterIndexMap, record it along with its index in
// the characterIndexMap and update maxLength = max(maxLength, (i - start + 1)). If the character exists in
// characterIndexMap, update start = characterIndexMap[char] + 1 only if (characterIndexMap[char] + 1 > start) since we
// only want the start to increase to avoid repetition, otherwise, update maxLength = max(maxLength, (i - start + 1)).
// Before moving on to the next iteration, we have to update characterIndexMap[char] = currentIndex
//
// zabcdaz => when the current iteration is processing the second z, the start would be at index 2, which has a value
// of b, and we won't want to update the start to the index after the first z, which is index 1, because we would have
// updated the start to a lesser value, which guarantees repetition.

extension MediumStringProblems {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var characterIndexMap: [Character: Int] = [:]
        var start: Int = 0
        var maxLength: Int = 0
        let chars: [Character] = Array(s)
        
        for (index, char) in chars.enumerated() {
            if let existingIndex = characterIndexMap[char], (existingIndex + 1) > start {
                start = existingIndex + 1
            } else {
                maxLength = max(maxLength, index - start + 1)
            }
            
            characterIndexMap[char] = index
        }
        
        return maxLength
    }
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

// MARK: - 49. Group Anagrams
// LINK: https://leetcode.com/problems/group-anagrams/
//
// Description: Given an array of strings strs, group the anagrams together. You can return the answer in any order. An
// Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the
// original letters exactly once.
//
// Strategy: Use a dictionary as the storage, with key being sorted string of elements in strs. We are taking advantage
// of the fact that all anagrams of the same letter combination would be sorted to the same str.

extension MediumStringProblems {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        guard strs.count > 1 else {
            return [[strs[0]]]
        }
        
        var dict: [String: [String]] = [:]
        
        for str in strs {
            let sortedStr = String(str.sorted())
            if let _ = dict[sortedStr] {
                dict[sortedStr]?.append(str)
            } else {
                dict[sortedStr] = [str]
            }
        }
        
        var results: [[String]] = []
        
        for (_, value) in dict {
            results.append(value)
        }
        
        return results
    }
}

// MARK: - 424. Longest Repeating Character Replacement
// LINK: https://leetcode.com/problems/longest-repeating-character-replacement/
//
// Description: You are given a string s and an integer k. You can choose any character of the string and change it to
// any other uppercase English character. You can perform this operation at most k times. Return the length of the
// longest substring containing the same letter you can get after performing the above operations.
//
// Strategy: You want a start: Int to measure the starting index of the sub string, and then you want a charCountMap:
// [Character: Count] to keep track of the counting of the character, and then you want a result: Int to keep track of
// the longest same char substring. You want to loop through the string, and update the charCountMap by incrementing
// the currentChar count by 1. If the currentSubstringCount (i - start + 1) minus maxCount of a char in the
// charCountMap <= k, we want to update the result with the currentSubStringCount, else we would want to update the
// sliding window by incrementing the start by 1 and decrementing the corresponding character count by 1 in the
// charCountMap.

extension MediumStringProblems {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        let chars: [Character] = Array(s)
        var charCountMap: [Character: Int] = [:]
        var start: Int = 0
        var result: Int = 0
        var charCountMax: Int = 0
        
        for (i, char) in chars.enumerated() {
            let currentCharCount: Int = (charCountMap[char] ?? 0) + 1
            charCountMap[char] = currentCharCount
            charCountMax = max(charCountMax, currentCharCount)
            
            let currentSubstrCount: Int = i - start + 1
            
            if (currentSubstrCount - charCountMax) <= k {
                result = max(result, currentSubstrCount)
            } else {
                charCountMap[chars[start]] = (charCountMap[chars[start]] ?? 0) - 1
                start += 1
                result = max(result, i - start + 1)
            }
        }
        
        return result
    }
}
