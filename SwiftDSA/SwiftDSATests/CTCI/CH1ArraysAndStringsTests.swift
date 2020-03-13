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
