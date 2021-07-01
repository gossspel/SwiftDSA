//
//  MediumStringProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/11/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

@testable import SwiftDSA
import XCTest

class MediumStringProblemsTests: XCTestCase {}

// MARK: - 5. Longest Palindromic Substring

extension MediumStringProblemsTests {
    func testLongestPalindrome_with5CharsInputWith3CharsLP_shouldReturnCorrect3CharsLP() {
        let s = "babad"
        let lp = MediumStringProblems().longestPalindrome(s)
        let validAnswers: [String] = ["bab", "aba"]
        XCTAssert(validAnswers.contains(lp))
    }
    
    func testLongestPalindrome_with4CharsInputWith2CharsLP_shouldReturnCorrect2CharsLP() {
        let s = "cbbd"
        let lp = MediumStringProblems().longestPalindrome(s)
        XCTAssertEqual(lp, "bb")
    }
    
    func testLongestPalindrome_with1CharInputWith1CharLP_shouldReturnCorrect1CharLP() {
        let s = "a"
        let lp = MediumStringProblems().longestPalindrome(s)
        XCTAssertEqual(lp, "a")
    }
    
    func testLongestPalindrome_with2CharsInputWith1CharLP_shouldReturnCorrect1CharLP() {
        let s = "ac"
        let lp = MediumStringProblems().longestPalindrome(s)
        XCTAssertEqual(lp, "a")
    }
}

// MARK: - 49. Group Anagrams

class MediumStringProblem49Tests: XCTestCase {
    func testGroupAnagrams_with6Strs_shouldReturnGroupedAnagrams() {
        let strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
        let group = MediumStringProblems().groupAnagrams(strs)
        
        for i in 0..<group.count {
            let sortedKey = String(group[i][0].sorted())
            if sortedKey == "aet" {
                XCTAssert(group[i].contains("ate"))
                XCTAssert(group[i].contains("eat"))
                XCTAssert(group[i].contains("tea"))
            } else if sortedKey == "abt" {
                XCTAssert(group[i].contains("bat"))
            } else if sortedKey == "ant" {
                XCTAssert(group[i].contains("nat"))
                XCTAssert(group[i].contains("tan"))
            }
        }
        
        XCTAssertEqual(group.count, 3)
    }
    
    func testGroupAnagrams_withOneEmptyStr_shouldReturnEmptyStrIn2Darray() {
        let strs = [""]
        let group = MediumStringProblems().groupAnagrams(strs)
        XCTAssertEqual(group, [[""]])
    }
    
    func testGroupAnagrams_withOneNonEmptyStr_shouldReturnNonEmptyStrIn2Darray() {
        let strs = ["a"]
        let group = MediumStringProblems().groupAnagrams(strs)
        XCTAssertEqual(group, [["a"]])
    }
}
