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
// Strategy1: - loop through the string by each character to put them into a set. In each iteration, if the set already
// contains the character, return false; otherwise if we haven't return false by the end of the iteration, return true.
// Strategy2: - sort the string, and then do a linear scan to see if there is any repeating consecutive element.

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

// MARK: - 1.2
// Check Permutation: Given two strings, write a method to decide if one is a permuation of the other.
// Strategy1: - sort both strings and check if they are the same. Running time complexity is O(n log n)
// Strategy2: - check to make sure both strings have the same length, and then insert all chars from string1 to the set,
// and then remove all chars in string2 from the set, check to see if the set is empty afterwards.

// MARK: - 1.3
// URLify: Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient
// space at the end to hold the additional characters, and that you are given the "true" length of the string.
// Strategy1: - brute force, use an array of String to record all the words of that sentence, and then join each word
// from the array with '%20'.
// Strategy2: - A common approach in string manipulation problems is to edit the string from the end and working
// backwards, since we have extra buffer at the end, we can change characters without worrying about what we are
// overwriting. So we use a two scan a approach, in the first scan, we collect the number of white space, and then we
// append the (numberOfwhiteSpaces * 2) count of extra empty space to the string as buffer, then we start to loop
// through the string backward starting from index = trueLength - 1, and start populating the element at newIndex =
// (trueLength + 2 * numberOfWhiteSpaces - 1)

// MARK: - 1.4
// Palindrome Permutation: Given a string, write a function to check if it is a permuation of a palindrome. A
// palindrome is a word or phrase that is the same forwards and backwards. A permutation is a rearrangement of letters.
// The palindrome does not need to be limited to just dictionary words.
// Strategy1: - An odd number palindrome is consisted of a pair of every unique character and a single unique midpoint
// character, an even number palindrome is consisted of a pair of every unique character. If a string can meet the
// above requirements, it can be compute rearranged as a palidrome. For this we will use a dictionary: [Character: Int],
// we will loop through the string by each character and mark the dictionary with key=character,
// value=numberOfOccurrencesInThatCharacter. If the string length is odd, we will make sure we will have 1 keyValue
// pair with odd value, and the rest of them have even value; else if the string length is odd, we will make sure all of
// the keyValue pairs have even value.

