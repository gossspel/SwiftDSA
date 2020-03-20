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
