//
//  CH1ArraysAndStringsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 3/13/20.
//  Copyright © 2020 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class CH1ArraysAndStringsTests: XCTestCase {

}

// MARK: - 1.1

extension CH1ArraysAndStringsTests {
    func testHasAllUniqueCharacters_withUniqueInputStr_shouldReturnTrue() {
        let input: String = "abc"
        let isUnique: Bool = CH1ArraysAndStrings.hasAllUniqueCharacters(inputStr: input)
        XCTAssert(isUnique)
    }
    
    func testHasAllUniqueCharacters_withNonUniqueInputStr_shouldReturnFalse() {
        let input: String = "abca"
        let isUnique: Bool = CH1ArraysAndStrings.hasAllUniqueCharacters(inputStr: input)
        XCTAssertFalse(isUnique)
    }
    
    func testHasAllUniqueCharactersWithoutAdditionalDataStructure_withUniqueInputStr_shouldReturnTrue() {
        let input: String = "abc"
        let isUnique: Bool = CH1ArraysAndStrings.hasAllUniqueCharactersWithoutAdditionalDataStructure(inputStr: input)
        XCTAssert(isUnique)
    }
    
    func testHasAllUniqueCharactersWithoutAdditionalDataStructure_withNonUniqueInputStr_shouldReturnFalse() {
        let input: String = "abca"
        let isUnique: Bool = CH1ArraysAndStrings.hasAllUniqueCharactersWithoutAdditionalDataStructure(inputStr: input)
        XCTAssertFalse(isUnique)
    }
}

// MARK: - 1.2

extension CH1ArraysAndStringsTests {
    func testIsPermutation_withPermutation_shouldReturnTrue() {
        let string1: String = "top"
        let string2: String = "pot"
        let isPermuation: Bool = CH1ArraysAndStrings.isPermutation(string1: string1, string2: string2)
        XCTAssert(isPermuation)
    }
    
    func testIsPermutation_withNonPermutation_shouldReturnTrue() {
        let string1: String = "toP"
        let string2: String = "pot"
        let isPermuation: Bool = CH1ArraysAndStrings.isPermutation(string1: string1, string2: string2)
        XCTAssertFalse(isPermuation)
    }
    
    func testIsPermutationWithoutSort_withPermutation_shouldReturnTrue() {
        let string1: String = "top"
        let string2: String = "pot"
        let isPermuation: Bool = CH1ArraysAndStrings.isPermutationWithoutSort(string1: string1, string2: string2)
        XCTAssert(isPermuation)
    }
    
    func testIsPermutationWithoutSort_withNonPermutation_shouldReturnTrue() {
        let string1: String = "toP"
        let string2: String = "pot"
        let isPermuation: Bool = CH1ArraysAndStrings.isPermutationWithoutSort(string1: string1, string2: string2)
        XCTAssertFalse(isPermuation)
    }
}

// MARK: - 1.3

extension CH1ArraysAndStringsTests {
	func testGetURLCompatibleStr_withHappyPath_shouldReturnCorrectURLCompatibleStr() {
		let str: String = "Mr John Smith    "
		let URLCompatibleStr: String = CH1ArraysAndStrings.getURLCompatibleStr(str: str)
		let eStr: String = "Mr%20John%20Smith"
		XCTAssertEqual(URLCompatibleStr, eStr)
	}
	
	func testGetURLCompatibleStrCharacters_withHappyPath_shouldReturnCorrectURLCompatibleStrCharacters() {
		var chars: [Character] = ["M", "r", " ", "J", "o", "h", "n", " ", "S", "m", "i", "t", "h", " ", " ", " ", " "]
		let URLCompatibleStrCharacters = CH1ArraysAndStrings.getURLCompatibleStrCharacters(str: &chars, trueLength: 13)
		let eChars: [Character] = ["M", "r", "%", "2", "0", "J", "o", "h", "n", "%", "2", "0", "S", "m", "i", "t", "h"]
		XCTAssertEqual(URLCompatibleStrCharacters, eChars)
	}
}
