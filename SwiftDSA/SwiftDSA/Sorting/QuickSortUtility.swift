//
//  QuickSortUtility.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 10/23/19.
//  Copyright © 2019 Sunny Chan. All rights reserved.
//

import Foundation

class QuickSortUtility {
	
	/// Method to do quick sort
	/// LINK: https://runestone.academy/runestone/books/published/pythonds/SortSearch/TheQuickSort.html
	/// STEP 1 - select the pivot value using the first item of the list of items
	/// STEP 2 - will do partition by moving leftMarkIndex (LMI) and rightMarkIndex (RMI) until they cross
	/// STEP 3 - move LMI to the right, stop when leftMarkValue (LMV) is greater than pivot value and record LFI
	/// STEP 4 - move RMI to the left, stop when rightMarkValue (RMV) is less than pivot value and record RFI
	/// STEP 5 - swap the value of the stopped LMI and RMI if LMI is less than RMI, otherwise stop
	/// STEP 6 - continue step 3 - 5 until LMI is greater than RMI
	/// STEP 7 - swap the value of right mark and pivot
	/// STEP 8 - quick sort the left half and right half of the split point
	/// - Parameter items: [T] - generic items
	static func quickSort<T: Comparable>(items: inout [T]) {
		guard !items.isEmpty else {
			return
		}
		
		let pivotValue: T = items.first!
		var leftMark: Int = 1
		var rightMark: Int = items.count - 1
		
		// Move left mark and right mark until they stop, and then swap value.
		// Repeat until leftMark >= rightMark
		while leftMark <= rightMark {
			(leftMark, rightMark) = getMarkStops(items: items,
												 leftMark: leftMark,
												 rightMark: rightMark,
												 pivotValue: pivotValue)
			
			// Values of leftMark and rightMark should be swaped if split point hasn't been found yet
			if leftMark <= rightMark {
				swapValueAtIndices(items: &items, firstIndex: leftMark, secondIndex: rightMark)
			}
		}
		
		// Swap value of right mark and pivot
		swapValueAtIndices(items: &items, firstIndex: 0, secondIndex: rightMark)
		
		var leftHalf: [T] = Array(items[0..<rightMark])
		var rightHalf: [T] = (rightMark + 1 < items.count) ? Array(items[rightMark+1..<items.count]) : []
		quickSort(items: &leftHalf)
		quickSort(items: &rightHalf)
		items = leftHalf + [pivotValue] + rightHalf
	}
	
	static func getMarkStops<T: Comparable>(items: [T], leftMark: Int, rightMark: Int, pivotValue: T) -> (Int, Int) {
		var leftMarkStop: Int = leftMark
		var rightMarkStop: Int = rightMark
		
		// Move left mark until we find a value greater than the pivot
		while (leftMarkStop < items.count) && (items[leftMarkStop] <= pivotValue) {
			leftMarkStop += 1
		}
		
		// Move right mark until we find a value less than pivot
		while (rightMarkStop > 0) && (items[rightMarkStop] >= pivotValue) {
			rightMarkStop -= 1
		}
		
		return (leftMarkStop, rightMarkStop)
	}
	
	static func swapValueAtIndices<T: Comparable>(items: inout [T], firstIndex: Int, secondIndex: Int) {
		let newLeftMarkValue: T = items[secondIndex]
		let newRightMarkValue: T = items[firstIndex]
		items[firstIndex] = newLeftMarkValue
		items[secondIndex] = newRightMarkValue
	}
}
