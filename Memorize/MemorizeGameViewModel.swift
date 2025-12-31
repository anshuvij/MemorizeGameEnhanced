//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Anshu Vij on 30/12/25.
//

import Combine
import Foundation
import SwiftUI

class MemorizeGameViewModel: ObservableObject {
    
    private static let themes: [Theme] = [
        Theme(name: "Vehicle", numberOfPairs: 6, emojis: ["🚙", "🏎️", "🚗", "🚕", "🚔", "🚖", "🚘", "🚜"], color: .red),
        Theme(name: "Smile", numberOfPairs: 5, emojis: ["😀", "🤪", "😆", "😁", "😀", "🤪", "😆", "😁"], color: .mint),
        Theme(name: "Animals", numberOfPairs: 7, emojis: ["🐶", "🐭", "🐔", "🐺", "🪱","🫎", "🪰", "🪲", "🐆", "🦇"], color: .orange),
        Theme(name: "Fruits", numberOfPairs: 9, emojis: ["🍏", "🍎", "🍍", "🍓", "🍋","🍑", "🍋‍🟩", "🍇"], color: .brown),
        Theme(name: "Sports", numberOfPairs: 4, emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎","🥏", "🎱", "🏒"], color: .yellow),
        Theme(name: "Electronics", numberOfPairs: 5, emojis: ["⌚️", "📱", "📲", "💻", "🖥️","🖨️", "🖲️", "📺"], color: .cyan),
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemorizeGame<String> {
        let pairs = min(theme.numberOfPairs, theme.emojis.count)
        let shuffledEmojis = theme.emojis.shuffled()
        let chosenEmojis = Array(shuffledEmojis.prefix(pairs))
        
        return MemorizeGame<String>(numberOfPair: pairs) { pairIndex in
            chosenEmojis[pairIndex]
        }
    }
    
    var randomThemeIndex: Int {
        Int.random(in: 0..<Self.themes.count)
    }
    
    @Published private var game : MemorizeGame<String>
    @Published private(set) var selectedTheme: Theme
    
    init() {
        let theme = Self.themes[0]
        selectedTheme = theme
        game = Self.createMemoryGame(theme: theme)
        
    }
    
    var cards: [MemorizeGame<String>.Card] {
        game.cards
    }
    
    func cards(at index: Int) -> MemorizeGame<String>.Card {
        game.cards(at: index)
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func reset() {
        let randomTheme = Self.themes[randomThemeIndex]
        selectedTheme = randomTheme
        self.game = Self.createMemoryGame(theme: randomTheme)
        
    }
    
    var themeColor : Color {
        selectedTheme.color
    }
    
    var themeName: String {
        selectedTheme.name
    }
    
    var score: Int {
        game.score
    }
    
    func choose(_ card : MemorizeGame<String>.Card) {
        game.choose(card: card)
    }
    
}
