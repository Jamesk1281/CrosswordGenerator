//
//  CrosswordManager.swift
//  CrosswordGenerator
//
//  Created by James . on 7/1/25.
//

import Foundation

actor Crossword {
    var board: Board
    
    init(size: Int, words: [String]) { 
        self.board = Crossword.generateBoard(size: size, words: words)
    }
    
    /*
     Generates a new crossword with the given size and list of words
     As many words as possible will be added within the size of the board
     */
    private static func generateBoard(size: Int, words: [String])  -> Board {
        var boards: [Board] = []
        
        for startWord in words { // Creates one board iteration for each word in words
            var board = Board(size: size)
            var wordsCopy = words.sortedByLength()
            
            _ =  placeWord(startWord, x: size / 2, y: size / 2 - startWord.count / 2, horizontal: true, board: &board) // Place the first word in the middle of the board
            wordsCopy.removeAll(where: {$0 == startWord})
            
            var attemptsWithoutPlacement = 0
            while !wordsCopy.isEmpty && attemptsWithoutPlacement < wordsCopy.count {
                for word in wordsCopy {
                    var x = 0
                    var y = 0
                    while let common = findCommonCharacter(in: word, x: x, y: y, board: &board) { // Locate a common character
                        let startCoordinates =  calculateStartCoordinates(for: word, intersectX: common.0, intersectY: common.1, board: &board) // Calculate start coordinates of new word
                        if  placeWord(word, x: startCoordinates.0, y: startCoordinates.1, horizontal: startCoordinates.2, board: &board, intersectionCoordinates: (common.0, common.1)) { // If this word can be legally placed
                            wordsCopy.removeAll(where: {$0 == word})
                            attemptsWithoutPlacement = 0 // Reset counter
                            break
                        } else {
                            if y == size-1 { // Wrap around if this is at the end of a row
                                x = common.0 + 1
                                y = 0
                            } else {
                                x = common.0
                                y = common.1 + 1
                            }
                        }
                    }
                }
                attemptsWithoutPlacement += 1
            }
            board.matrix = board.matrix.map { row in // Wipe the board of undetermined squares ("*") and replace with black squares ("-")
                row.map { $0 == "*" ? "-" : $0 }
            }
            boards.append(board)
        }
        return findBestBoard(boards: boards) // Scores all boards and returns the board with the highest score
    }
    
    // Places a word on the matrix beginning at the provided coordinates and direction. Returns true if successful, false if the word would be out of bounds
    private static func placeWord(_ word: String, x: Int, y: Int, horizontal: Bool, board: inout Board, intersectionCoordinates: (Int, Int)? = nil) -> Bool { // TODO: Simplify repetitive code
        if x < 1 || y < 1 || x > board.size - 1 || y > board.size - 1 { return false }
        let size = board.matrix.count
        if horizontal {
            if y + word.count + 1 > size { return false } // Check that the word will fit on the board
            for i in y-1..<y+word.count + 1 { // Check that the word won't overwrite or lie next to any others
                if let intersectionCoordinates {
                    if (x, i) == intersectionCoordinates { continue }
                }
                if x > 0 && board.matrix[x-1][i].isLetter { return false }
                if x < size - 1 && board.matrix[x+1][i].isLetter { return false }
                if board.matrix[x][i] != "*" { return false }
            }
            for (index, char) in word.enumerated() { // Lay the word out horizontally by character
                board.matrix[x][y+index] = char
            }
            if y + word.count < size { // If the word does not end at the right edge of the board, add a black square after it
                board.matrix[x][y+word.count] = "-"
            }
        } else {
            if x + word.count +  1 > size { return false } // Check that the word will fit on the board
            for i in x-1..<x+word.count + 1 { // Check that the word won't overwrite or lie next to any others
                if let intersectionCoordinates {
                    if (i, y) == intersectionCoordinates { continue }
                }
                if y > 0 && board.matrix[i][y-1].isLetter { return false }
                if y < size - 1 && board.matrix[i][y+1].isLetter { return false }
                if board.matrix[i][y] != "*" { return false }
            }
            for (index, char) in word.enumerated() { // Lay the word out vertically by character
                board.matrix[x+index][y] = char
            }
            if x + word.count < size { // If the word does not end at the bottom edge of the board, add a black square after it
                board.matrix[x+word.count][y] = "-"
            }
        }
        return true
    }

    /*
     Finds the first character on the board that exists in the given word starting at the given coordinates
     Returns coordinates of the common character and the common character (x, y, char) if one is found
    */
    private static func findCommonCharacter(in word: String, x: Int, y: Int, board: inout Board) -> (Int, Int, Character)? {
        let matrix = board.matrix
        let rows = matrix.count
        let cols = matrix[0].count
        
        for i in x..<rows {
            let startY = (i == x) ? y : 0
            for j in startY..<cols {
                if word.contains(matrix[i][j]) {
                    return (i, j, matrix[i][j])
                }
            }
        }
        return nil
    }
    
    /*
     Given a word and the location of its intersect with another word, returns the coordinates
     at which the provided word should start to make the desired intersection, and a boolean
     which denotes the direction of the word to be placed (true = horizontal, false = vertical)
     Returns at least one value less than zero if the start location would be out of bounds
     */
    private static func calculateStartCoordinates(for word: String, intersectX: Int, intersectY: Int, board: inout Board) -> (Int, Int, Bool) {
        let matrix = board.matrix
        let intersectChar = matrix[intersectX][intersectY]

        
        let isVertical = // Determines if the word already on the board is vertical
               (intersectX > 0 && matrix[intersectX - 1][intersectY]) ||
                (intersectX < board.size - 1 && matrix[intersectX + 1][intersectY].isLetter)
        let isHorizontal = // Determines if the word already on the board is horizontal
                (intersectY > 0 && matrix[intersectX][intersectY - 1].isLetter) ||
                (intersectY < board.size - 1 && matrix[intersectX][intersectY + 1].isLetter)
        
        if word[word.startIndex] == intersectChar { // If the intersect is at the first letter of the given word
            return (intersectX, intersectY, isVertical)
        }
        
        if isVertical { // If the word already on the board is vertical
            if word[word.index(before: word.endIndex)] == intersectChar { // If the intersect is at the last letter of the given word
                return (intersectX, intersectY - word.count + 1, isVertical)
            }
            guard let charsBeforeIntersect = word.firstIndex(of: intersectChar) else { return (-1, -1, isVertical) } // Calculates how many characters are before the intersect letter
            let intIndex = word.distance(from: word.startIndex, to: charsBeforeIntersect) // Converts that value to an integer
            return (intersectX, intersectY - intIndex, isVertical)
        }
        if isHorizontal { // If the word already on the board is horizontal
            if word[word.index(before: word.endIndex)] == intersectChar { // If the intersect is at the last letter of the given word
                return (intersectX - word.count + 1, intersectY, isVertical)
            }
            guard let charsBeforeIntersect = word.firstIndex(of: intersectChar) else { return (-1, -1, isVertical) } // Calculates how many characters are before the intersect letter
            let intIndex = word.distance(from: word.startIndex, to: charsBeforeIntersect) // Converts that value to an integer
            return (intersectX - intIndex, intersectY, isVertical)
        }
        return (-1, -1, isVertical)
    }
    
    /*
     Locates and returns the board with the highest score
     The score is calculated by a combination of limiting black squares and maximizing intersections
     */
    private static func findBestBoard(boards: [Board]) -> Board {
        var scores: [(Int, Int)] = [] // (Score, Index)
        
        for (boardIndex, board) in boards.enumerated() {
            var spaces = 0
            var intersects = 0
            
            for (rowIndex, row) in board.matrix.enumerated() {
                for (squareIndex, square) in row.enumerated() {
                    if square == "-" {
                        spaces += 1
                    } else {
                        var directions = 0
                        if (rowIndex > 0 && board.matrix[rowIndex - 1][squareIndex] != "-") || // If there is another letter above or below this one
                            (rowIndex < board.matrix.count - 1 && board.matrix[rowIndex + 1][squareIndex] != "-") {
                            directions += 1
                        }
                        if (squareIndex > 0 && board.matrix[rowIndex][squareIndex - 1] != "-") || // If there is another letter to the left or right of this one
                            (squareIndex < board.matrix.count - 1 && board.matrix[rowIndex][squareIndex + 1] != "-") {
                            directions += 1
                        }
                        if directions == 2 { // If there is a letter in both directions, it is an intersect
                            intersects += 1
                        }
                    }
                }
            }
            scores.append( ((intersects * 3) - spaces, boardIndex) ) // MARK: Board Scoring
        }
        if let (_, bestIndex) = scores.max(by: { $0.0 < $1.0 }) { // Find the index of the board with the best score
            return boards[bestIndex]
        } else {
            return boards.first ?? Board(size: 10) // If boards is empty
        }
    }
}
