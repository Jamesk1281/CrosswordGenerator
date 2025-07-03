//
//  SampleWords.swift
//  CrosswordGenerator
//
//  Created by James . on 7/1/25.
//

import Foundation

class SampleWords {
    static let words: [Word] = [
        Word(word: "romance", clue: "Genre of love stories"),
        Word(word: "oral", clue: "Spoken, not written"),
        Word(word: "bad", clue: "Opposite of good"),
        Word(word: "breaking", clue: "Shattering or violating"),
        Word(word: "language", clue: "Means of communication"),
        Word(word: "curses", clue: "Profane outbursts"),
        Word(word: "black", clue: "Color of the night"),
        Word(word: "relationship", clue: "Bond between people"),
        Word(word: "love", clue: "Deep affection"),
        Word(word: "basic", clue: "Fundamental or simple"),
        Word(word: "word", clue: "Unit of speech"),
        Word(word: "drink", clue: "Sip or swallow"),
        Word(word: "bullion", clue: "Gold in bars"),
        Word(word: "partygoer", clue: "Frequent festivity attendee"),
        Word(word: "temporally", clue: "In relation to time"),
        Word(word: "methodically", clue: "Step by step"),
        Word(word: "lethargic", clue: "Sluggish or tired"),
        Word(word: "times", clue: "Chronological points"),
        Word(word: "eden", clue: "Paradise of Genesis"),
        Word(word: "places", clue: "Locations or spots"),
        Word(word: "master", clue: "Expert or skilled person"),
        Word(word: "shack", clue: "Small crude shelter"),
        Word(word: "legendary", clue: "Famed in stories")
    ]
}

struct Word {
    var word: String
    var clue: String
}
