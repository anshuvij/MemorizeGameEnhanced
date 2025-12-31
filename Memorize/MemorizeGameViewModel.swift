//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Anshu Vij on 30/12/25.
//

import Combine
import Foundation

class MemorizeGameViewModel: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "✈️", "🕸️", "😱", "🍟", "🔥","😏"]
    // will be initialised first then init
    
   private static func createMemoryGame() -> MemorizeGame<String> {
     
       return MemorizeGame<String>(numberOfPair: 8) { pairIndex in
            
           if emojis.indices.contains(pairIndex) {
               return emojis[pairIndex]
           } else {
              return "⁉️"
           }
        }
    }
    
    @Published private var game = createMemoryGame()
    
    var cards: [MemorizeGame<String>.Card] {
        game.cards
    }
    
    func cards(at index: Int) -> MemorizeGame<String>.Card {
        game.cards(at: index)
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func choose(_ card : MemorizeGame<String>.Card) {
        game.choose(card: card)
    }
    
}
