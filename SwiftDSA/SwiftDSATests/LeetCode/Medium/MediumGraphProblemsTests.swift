//
//  MediumGraphProblemsTests.swift
//  SwiftDSATests
//
//  Created by Sunny Chan on 7/21/21.
//  Copyright © 2021 Sunny Chan. All rights reserved.
//

import XCTest
@testable import SwiftDSA

class MediumGraphProblem133Tests: XCTestCase {
    func testCloneGraph_with4Nodes_shouldReturnClonedGraph() {
        let firstNode = Node(1)
        let secondNode = Node(2)
        let thirdNode = Node(3)
        let fourthNode = Node(4)
        firstNode.neighbors = [secondNode, fourthNode]
        secondNode.neighbors = [firstNode, thirdNode]
        thirdNode.neighbors = [secondNode, fourthNode]
        fourthNode.neighbors = [firstNode, thirdNode]
        let clonedFirstNode = MediumGraphProblems().cloneGraph(firstNode)
        XCTAssertEqual(clonedFirstNode?.val, 1)
        
        guard let sureClonedFirstNode = clonedFirstNode else {
            XCTFail("clonedFirstNode is nil!")
            return
        }
        
        let memAddressOfFirstNode: String = "\(Unmanaged.passUnretained(firstNode).toOpaque())"
        let memAddressOfClonedFirstNode: String = "\(Unmanaged.passUnretained(sureClonedFirstNode).toOpaque())"
        XCTAssertNotEqual(memAddressOfFirstNode, memAddressOfClonedFirstNode)
        
        var hasTestedClonedSecondNode: Bool = false
        var hasTestedClonedThirdNode: Bool = false
        var hasTestedClonedFourthNode: Bool = false
        
        var clonedSecondNode: Node? = nil
        
        for clonedNeighbor in sureClonedFirstNode.neighbors {
            guard let sureClonedNeighbor = clonedNeighbor else {
                XCTFail("clonedNeighbor is nil!")
                return
            }
            
            if sureClonedNeighbor.val == 2 {
                let memAddressOfSecondNode: String = "\(Unmanaged.passUnretained(secondNode).toOpaque())"
                let memAddressOfClonedSecondNode: String = "\(Unmanaged.passUnretained(sureClonedNeighbor).toOpaque())"
                XCTAssertNotEqual(memAddressOfSecondNode, memAddressOfClonedSecondNode)
                clonedSecondNode = sureClonedNeighbor
                hasTestedClonedSecondNode = true
            } else if sureClonedNeighbor.val == 4 {
                let memAddressOfFourthNode: String = "\(Unmanaged.passUnretained(fourthNode).toOpaque())"
                let memAddressOfClonedFourthNode: String = "\(Unmanaged.passUnretained(sureClonedNeighbor).toOpaque())"
                XCTAssertNotEqual(memAddressOfFourthNode, memAddressOfClonedFourthNode)
                hasTestedClonedFourthNode = true
            }
        }
        
        guard let sureClonedSecondNode = clonedSecondNode else {
            XCTFail("clonedSecondNode is nil!")
            return
        }
        
        for clonedNeighbor in sureClonedSecondNode.neighbors {
            guard let sureClonedNeighbor = clonedNeighbor else {
                XCTFail("clonedNeighbor is nil!")
                return
            }
            
            if sureClonedNeighbor.val == 3 {
                let memAddressOfThirdNode: String = "\(Unmanaged.passUnretained(thirdNode).toOpaque())"
                let memAddressOfClonedThirdNode: String = "\(Unmanaged.passUnretained(sureClonedNeighbor).toOpaque())"
                XCTAssertNotEqual(memAddressOfThirdNode, memAddressOfClonedThirdNode)
                hasTestedClonedThirdNode = true
            }
        }
        
        XCTAssertTrue(hasTestedClonedSecondNode)
        XCTAssertTrue(hasTestedClonedThirdNode)
        XCTAssertTrue(hasTestedClonedFourthNode)
    }
}
