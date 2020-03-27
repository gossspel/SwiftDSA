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

extension CH1ArraysAndStrings {
    static func isPermutation(string1: String, string2: String) -> Bool {
        let sortedString1 = string1.sorted()
        let sortedString2 = string2.sorted()
        let isPermutation: Bool = sortedString1 == sortedString2
        return isPermutation
    }
    
    static func isPermutationWithoutSort(string1: String, string2: String) -> Bool {
        guard string1.count == string2.count else {
            return false
        }
        
        var charSet: Set<Character> = []
        
        for char in string1 {
            charSet.insert(char)
        }
        
        for char in string2 {
            charSet.remove(char)
        }
        
        return charSet.isEmpty
    }
}

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

extension CH1ArraysAndStrings {
	static func getURLCompatibleStr(str: String) -> String {
		var words: [String] = []
		var currentWord: [Character] = []
		
		for char in str {
			if char == " " {
				if !currentWord.isEmpty {
					let currentWordStr: String = String(currentWord)
					words.append(currentWordStr)
					currentWord = []
				}
			} else {
				currentWord.append(char)
			}
		}
		
		if !currentWord.isEmpty {
			let currentWordStr: String = String(currentWord)
			words.append(currentWordStr)
		}
		
		let URLCompatibleStr: String = words.joined(separator: "%20")
		return URLCompatibleStr
	}
	
	static func getURLCompatibleStrCharacters(str: inout [Character], trueLength: Int) -> [Character] {
		var spaceCount: Int = 0
		
		for i in 0..<trueLength  {
			if str[i] == " " {
				spaceCount += 1
			}
		}
		
		var newCount: Int = trueLength + spaceCount * 2
		str.reserveCapacity(newCount)
		
		// NOTE: Remove any extra space at the end of the str
		if trueLength < str.count {
			for _ in 0..<(str.count - trueLength) {
				str.removeLast()
			}
		}
		
		for _ in (0..<spaceCount * 2) {
			str.append(" ")
		}
		
		for i in (0..<trueLength).reversed() {
			if str[i] == " " {
				str[newCount - 1] = "0"
				str[newCount - 2] = "2"
				str[newCount - 3] = "%"
				newCount -= 3
			} else {
				str[newCount - 1] = str[i]
				newCount -= 1
			}
		}
		
		return str
	}
}

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

// MARK: - 1.5
// One Away: There are three types of edits that can be performed on strings: insert a character, remove a character,
// or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
// Strategy1: - If the lengthDiff between two strings are > 1, return false immediately; else if lengthDiff is 1, loop
// through the longer string by each character, and try to insert that character in each index of the shorter str.
// Compare the str with the inserted character with the longer str, if they match, return true immediately, else
// move to the next iteration, once all iteration exhaust, return false. If lengthDiff is 0, loop through string1 by
// each character, and replace that character with every character of string2. Compare the string2 with te string with
// the replaced character, if they match return true immediately, else move to the next iteration, once all iteration
// exhaust, return false. This is O(N^2)
// Strategy2 - If the lengthDiff between two strings are > 1, return false immediately; else if lengthDiff is 1, loop
// through both string together and check to see if their characters are the same in each iteration. Keep going until
// the characters aren't the same. Stop and insert the last looped character from the longer string to the shorter
// string at the last looped index. Now that both strings are at equal length again, loop both strings to see if
// characters from each iteration are the same, return false immediately if one of them are not the same, else return
// true after the iterations are exhausted. If the lengthDiff is 0, loop through both string together and check to see
// if their chracters are the same in each iteration. Keep going until the characters aren't the same. Stop and replace
// the last looped chracter from one of the string with the last looped chracter of the other string. Now loop both the
// replaced str and the other string together, check to see if their characters are the same in each iteration, return
// false immediately if one of them are not the same, else return true after all iterations have been exhausted. This is
// O(N).

// MARK: - 1.6
// String Compression - Implement a method to perform basic string compression using the counts of repeated characters.
// For example, the string aabcccccaaa would become a2b1c5a3. If the "compressed" string would not become smaller than
// the original string, your method should return the original string. You can assume the string has only uppercase and
// lowercase letters (a - z).
// Strategy1: Make a method that loop through the whole string. It needs a few variables to do the job:
// iterationChar (String), iterationCharCompressionCount (Int), and compressedStr (String). For each iteration, mark
// if loopedChar != iterationChar, append iterationChar and iterationCharCompressionCount to
// compressedStr and then reset them with iterationChar = loopedChar and iterationCharCompressionCount = 1, else if
// loopedChar == iterationChar, increment the iterationCharCompressionCount and go to the next iteration. In the end,
// check if length of compressedStr is less than originalStr, if true return the compressedStr, else return the
// originalStr. This is O(N).
