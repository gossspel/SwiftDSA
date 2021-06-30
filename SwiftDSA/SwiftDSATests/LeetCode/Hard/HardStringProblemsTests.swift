//
//  HardStringProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 6/26/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class HardStringProblems32Tests: XCTestCase {
    func testLongestValidParentheses_with2ValidParenthesesSubstringA_shouldReturn2() {
        let s = "(()"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 2)
    }
    
    func testLongestValidParentheses_with2ValidParenthesesSubstringB_shouldReturn4() {
        let s = "()(()"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 2)
    }
    
    func testLongestValidParentheses_with4ValidParenthesesSubstring_shouldReturn4() {
        let s = ")()())"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 4)
    }
    
    func testLongestValidParentheses_with6aValidParenthesesSubstring_shouldReturn6() {
        let s = "(())()"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 6)
    }
    
    func testLongestValidParentheses_with6bValidParenthesesSubstring_shouldReturn6() {
        let s = "((())()"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 6)
    }
    
    func testLongestValidParentheses_with6cValidParenthesesSubstring_shouldReturn6() {
        let s = "(())())"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 6)
    }
    
    func testLongestValidParentheses_with8ValidParenthesesSubstring_shouldReturn8() {
        let s = "((())())"
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 8)
    }
    
    func testLongestValidParentheses_with30000ValidParenthesesSubstring_shouldReturn30000() {
        var s = ""
        
        for _ in 0..<300000 {
            s.append("(((())()))")
        }
        
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 3000000)
    }
    
    func testLongestValidParentheses_withEmptyStr_shouldReturn0() {
        let s = ""
        let count = HardStringProblems().longestValidParentheses(s)
        XCTAssertEqual(count, 0)
    }
}
