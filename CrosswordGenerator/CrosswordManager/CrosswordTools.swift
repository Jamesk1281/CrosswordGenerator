//
//  CrosswordTools.swift
//  CrosswordGenerator
//
//  Created by James . on 7/2/25.
//

import Foundation

class CrosswordTools {
    static func getWordsOnBoard(_ board: Board) -> [String] {
        let matrix = board.matrix
        if matrix.isEmpty { return [] }
        
        var words: [String] = []
        for row in matrix { // Rows
            var currentWord = ""
            for char in row {
                if char != "-" { // If the square is not black, continue building the word
                    currentWord.append(char)
                } else { // Otherwise, the word is complete, so add it to the list and reset
                    words.append(currentWord)
                    currentWord = ""
                }
            }
            if !currentWord.isEmpty { words.append(currentWord) }
        }
        for col in 0..<matrix[0].count {
            var currentWord = ""
            for row in 0..<matrix.count {
                if matrix[row][col] != "-" { // If the square is not black, continue building the word
                    currentWord.append(matrix[row][col])
                } else { // Otherwise, the word is complete, so add it to the list and reset
                    words.append(currentWord)
                    currentWord = ""
                }
            }
            if !currentWord.isEmpty { words.append(currentWord) }
        }
        return words
    }
    
    static func printBoard(_ board: Board) {
        var printString = ""
        for row in board.matrix {
            for square in row {
                printString += String(square)
                printString += " "
            }
            printString += "\n"
        }
        print(printString)
    }
}

extension [String] {
    func sortedByLength() -> [String] {
        return self.sorted { $0.count > $1.count }
    }
}
