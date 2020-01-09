//
//  MergeSortUtilityTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 1/9/20.
//  Copyright © 2020 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class MergeSortUtilityTests: XCTestCase {

	func testMergeSort_withTwoDescInts_shouldExpectTwoAscInts() {
		var twoDescInts: [Int] = [33, 23]
		MergeSortUtility.mergeSort(items: &twoDescInts)
		XCTAssertEqual(twoDescInts, [23, 33])
	}
	
	func testMergeSort_withThreeIntsIncludingTwoIdenticalSmallerInts_shouldExpectThreeAscInts() {
		var threeIntsIncludingTwoIdenticalSmallerInts: [Int] = [55, 93, 55]
		MergeSortUtility.mergeSort(items: &threeIntsIncludingTwoIdenticalSmallerInts)
		XCTAssertEqual(threeIntsIncludingTwoIdenticalSmallerInts, [55, 55, 93])
	}
	
	func testMergeSort_withNineRandomInts_shouldExpectNineAscInts() {
		var nineRandomInts: [Int] = [54, 26, 93, 17, 77, 31, 44, 55, 20]
		MergeSortUtility.mergeSort(items: &nineRandomInts)
		XCTAssertEqual(nineRandomInts, [17, 20, 26, 31, 44, 54, 55, 77, 93])
	}


}
