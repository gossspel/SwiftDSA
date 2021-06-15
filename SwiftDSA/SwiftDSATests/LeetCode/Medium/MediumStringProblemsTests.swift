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
