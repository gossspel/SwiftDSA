//
//  MergeSortUtility.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 1/8/20.
//  Copyright © 2020 Sunny Chan. All rights reserved.
//

import Foundation

class MergeSortUtility {
	static func mergeSort<T: Comparable>(items: inout [T]) {
		// Split if possible
		if var (leftHalf, rightHalf) = split(items: items) {
			mergeSort(items: &leftHalf)
			mergeSort(items: &rightHalf)
			items = merge(sortedLeftHalf: leftHalf, sortedRightHalf: rightHalf)
		}
		
		// If the items can't be split, that means it has already been sorted.
	}
	
	private static func split<T: Comparable>(items: [T]) -> ([T], [T])? {
		guard items.count > 1 else {
			return nil
		}
		
		let midPoint: Int = items.count / 2
		let leftHalf: [T] = Array(items[0..<midPoint])
		let rightHalf: [T] = Array(items[midPoint..<items.count])
		return (leftHalf, rightHalf)
	}
	
	private static func merge<T: Comparable>(sortedLeftHalf: [T], sortedRightHalf: [T]) -> [T] {
		var leftHalfTravelingIndex: Int = 0
		var rightHalfTravelingIndex: Int = 0
		
		var sortedList: [T] = []
		
		while leftHalfTravelingIndex < sortedLeftHalf.count && rightHalfTravelingIndex < sortedRightHalf.count {
			if sortedLeftHalf[leftHalfTravelingIndex] <= sortedRightHalf[rightHalfTravelingIndex] {
				sortedList.append(sortedLeftHalf[leftHalfTravelingIndex])
				leftHalfTravelingIndex += 1
			} else {
				sortedList.append(sortedRightHalf[rightHalfTravelingIndex])
				rightHalfTravelingIndex += 1
			}
		}
		
		// NOTE: if right half is emptied out first, append the remaining left half
		if leftHalfTravelingIndex < sortedLeftHalf.count {
			for i in leftHalfTravelingIndex..<sortedLeftHalf.count {
				sortedList.append(sortedLeftHalf[i])
			}
		}
		
		// NOTE: if left half is emptied out first, append the remaining right half
		if rightHalfTravelingIndex < sortedRightHalf.count {
			for i in rightHalfTravelingIndex..<sortedRightHalf.count {
				sortedList.append(sortedRightHalf[i])
			}
		}
		
		return sortedList
	}
}
