//
//  CH2LinkedLists.swift
//  SwiftDSA
//
//  Created by Sunny Chan on 3/18/20.
//  Copyright © 2020 Sunny Chan. All rights reserved.
//

import Foundation

class CH2LinkedLists {
    
}

// MARK: - 2.1
// Remove Dups: Write code to remove duplicates from an unsorted linked list.
// Strategy1: - Use the following variables: uniqueSet (Set<Int>). Insert the first node of the linked list into the
// uniqueSet, and then iterate the linked list, insert the node.next.data (Int) into the uniqueSet. If the uniqueSet
// count didn't increase, delete the node.next by setting node.next = node.next.next. Finish the iteration and return
// the linked list.
// Strategy2: - No buffer allowed. If we don't have a buffer, we can iterate two linked list pointers: current which
// iterates through the linked list, and runner which checks all subsequent nodes for duplicates.
