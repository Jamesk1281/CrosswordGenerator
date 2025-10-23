import SwiftUI

struct SetupView: View {
    @State private var words: [Word] =  [
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
        Word(word: "legendary", clue: "Famed in stories"),
    ]
    @State private var currentWord: String = ""
    @State private var currentClue: String = ""
    @State private var gridSize: Int = 10
    @State private var errorMessage: String?

    private let maxWords = 25

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Grid Size (5–20)")) {
                    Stepper(value: $gridSize, in: 5...20) {
                        Text("Grid Size: \(gridSize)")
                    }
                }

                Section(header: Text("Add Word & Clue")) {
                    TextField("Word", text: $currentWord)
                        .autocapitalization(.none)
                    TextField("Clue", text: $currentClue)
                    Button("Add Word") {
                        addWord()
                    }
                    .disabled(currentWord.isEmpty || currentClue.isEmpty || words.count >= maxWords)
                }

                if let error = errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }

                Section(header: Text("Added Words (\(words.count)/\(maxWords))")) {
                    if words.isEmpty {
                        Text("No words added yet.")
                    } else {
                        ForEach(words, id: \.self) { word in
                            VStack(alignment: .leading) {
                                Text(word.word).bold()
                                Text("Clue: \(word.clue)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onDelete(perform: deleteWord)
                    }
                }

                Section {
                    NavigationLink(
                        destination: CrosswordView(vm: CrosswordViewModel(size: gridSize, words: words)),
                        label: {
                            Text("Continue")
                        }
                    )
                    .disabled(words.isEmpty)
                }
            }
            .navigationTitle("Crossword Setup")
        }
    }

    private func addWord() {
        guard words.count < maxWords else {
            errorMessage = "Maximum number of words reached."
            return
        }

        let trimmedWord = currentWord.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedClue = currentClue.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedWord.isEmpty && !trimmedClue.isEmpty else {
            errorMessage = "Both fields must be filled."
            return
        }

        let newWord = Word(word: trimmedWord, clue: trimmedClue)
        if words.contains(newWord) {
            errorMessage = "This word has already been added."
            return
        }

        words.append(newWord)
        currentWord = ""
        currentClue = ""
        errorMessage = nil
    }

    private func deleteWord(at offsets: IndexSet) {
        words.remove(atOffsets: offsets)
    }
}

#Preview {
    SetupView()
}
