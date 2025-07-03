//
//  Board.swift
//  CrosswordGenerator
//
//  Created by James . on 7/2/25.
//

import Foundation

struct Board {
    /*
     Dash (-) means black square (no letter)
     Lowercase character means letter that has not been filled in yet
     Uppercase character means letter that has been filled in
     Asterisk (*) means undetermined square -- should not appear on boards after generation
     */
    var matrix: [[CrosswordSquare]]
    var size: Int
    
    init(size: Int) {
        // Sets the matrix to a (size) X (size) block of undetermined squares (asterisks)
        self.size = size
        self.matrix = Array(repeating: Array(repeating: CrosswordSquare(letter: "*"), count: size), count: size)
    }
}

struct CrosswordSquare {
    var letter: Character
    var parentWord: Word? = nil
}
