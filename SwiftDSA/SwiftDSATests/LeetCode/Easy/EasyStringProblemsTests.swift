//
//  EasyStringProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/2/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

@testable import SwiftDSA
import XCTest

class EasyStringProblemsTests: XCTestCase {}

// MARK: - 14. Longest Common Prefix

extension EasyStringProblemsTests {
    func testLongestCommonPrefix_withStrsHavingCommonPrefixes_shouldReturnLongestCommonPrefix() {
        let strs: [String] = ["flower", "flow", "flight"]
        let result: String = EasyStringProblems.longestCommonPrefix(strs)
        XCTAssertEqual(result, "fl")
    }
    
    func testLongestCommonPrefix_withStrsHavingNoCommonPrefixes_shouldReturnEmptyStr() {
        let strs: [String] = ["dog", "racecar", "car"]
        let result: String = EasyStringProblems.longestCommonPrefix(strs)
        XCTAssertEqual(result, "")
    }
}

// MARK: - 125. Valid Palindrome

class EasyStringProblem125Tests: XCTestCase {
    func testIsPalindrome_withPanamaPalindrome_shouldReturnTrue() {
        let str: String = "A man, a plan, a canal: Panama"
        XCTAssertTrue(EasyStringProblems().isPalindrome(str))
    }
}
