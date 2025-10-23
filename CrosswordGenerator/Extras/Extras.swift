//
//  Extras.swift
//  CrosswordGenerator
//
//  Created by James . on 7/3/25.
//

import Foundation


// This block of code located a black square and placed a word next to it if no intersections could be found, but it was determined
// that this was unnecessary because so many intersections can be found if the list of words is long enough
//                for word in wordsCopy {
//                    var x = 0
//                    var y = 0
//                    while let blackSquareCoordinates =  findBlackSquare(x: x, y: y, board: &board) { // Locate a black square
//                        let dir = blackSquareCoordinates.2
//                        let horizontal = dir == .left || dir == .right
//                        var startX = 0
//                        var startY = 0
//
//                        if dir == .right { startX = x; startY = y + 1 } // Calculate the start coordinates of new word
//                        else if dir == .below { startX = x + 1; startY = y }
//                        else if dir == .left { startX = x; startY = y - word.count}
//                        else { startX = x - word.count; startY = y }
//
//                        if  placeWord(word, x: startX, y: startY, horizontal: horizontal, board: &board) { // If this word can be legally placed
//                            wordsCopy.removeAll(where: {$0 == word})
//                            attemptsWithoutPlacement = 0 // Reset counter
//                            break
//                        } else {
//                            if y == size-1 { // Wrap around if this is at the end of a row
//                                x = blackSquareCoordinates.0 + 1
//                                y = 0
//                            } else {
//                                x = blackSquareCoordinates.0
//                                y = blackSquareCoordinates.1 + 1
//                            }
//                        }
//                    }
//                }

// The following function was used in the code above. It originally resided on the Crossword actor

/*
 Starting at the given coordinates, returns the coordinates of the first black square ("-")
 with at least one undetermined square ("*") adjacent to it
 */
//private static func findBlackSquare(x: Int, y: Int, board: inout Board) -> (Int, Int, Direction)? {
//    let matrix = board.matrix
//    let rows = matrix.count
//    let cols = matrix[0].count
//    
//    for i in x..<rows {
//        let startY = (i == x) ? y : 0 // Reset y to 0 after the first iteration
//        for j in startY..<cols {
//            if matrix[i][j] == "-" {
//                if (i-1 >= 0 && matrix[i-1][j] == "*") { return (i, j, .above) }
//                if (i+1 < matrix.count && matrix[i+1][j] == "*") { return (i, j, .below) }
//                if (j-1 >= 0 && matrix[i][j-1] == "*") { return (i, j, .left) }
//                if (j+1 < matrix[i].count && matrix[i][j+1] == "*") { return (i, j, .right) }
//            }
//        }
//    }
//    return nil
//}
