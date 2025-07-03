//
//  CrosswordViewModel.swift
//  CrosswordGenerator
//
//  Created by James . on 7/1/25.
//

import Foundation

class CrosswordViewModel: ObservableObject {
    var crosswordManager = Crossword(size: 20, words: SampleWords.words)
    
    func getBoard() async -> Board {
        return await crosswordManager.board
    }
    
    func getSquares() async -> [[CrosswordSquare]] {
        var matrix = await crosswordManager.board.matrix
        var board: [[CrosswordSquare]] = []
        
        for row in matrix {
            for square in row {
                
            }
        }
    }
}
