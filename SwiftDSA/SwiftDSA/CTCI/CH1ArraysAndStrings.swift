//
//  CH1ArraysAndStrings.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 3/12/20.
//  Copyright © 2020 Sunny Chan. All rights reserved.
//

import Foundation

class CH1ArraysAndStrings {
    
}

// MARK: - 1.1
// Is Unique: Implement an algorithm to determine if a string has all unique characters. What if you cannot use
// additional data structures?

extension CH1ArraysAndStrings {
    static func hasAllUniqueCharacters(inputStr: String) -> Bool {
        var uniqueCharacters: Set<Character> = []
        
        for char in inputStr {
            guard !uniqueCharacters.contains(char) else {
                return false
            }
            
            uniqueCharacters.insert(char)
        }
        
        return true
    }
    
    static func hasAllUniqueCharactersWithoutAdditionalDataStructure(inputStr: String) -> Bool {
        let sortedInputStr: [Character] = inputStr.sorted()
        var previousChar: Character? = nil
        
        for char in sortedInputStr {
            if char == previousChar {
                return false
            }
            
            previousChar = char
        }
        
        return true
    }
}
