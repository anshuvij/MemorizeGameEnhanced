//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Anshu Vij on 30/12/25.
//

import Foundation

struct MemorizeGame<ContentType> where ContentType : Equatable {

    var cards: [Card]
    let numberOfPair: Int
    
    init(numberOfPair: Int, contentType : (Int) -> ContentType) {
        cards = []
        self.numberOfPair = numberOfPair
        
        for index in 0..<max(2,numberOfPair) {
            cards.append(Card(id: "\(index+1)a", content: contentType(index)))
            cards.append(Card(id: "\(index+2)b", content: contentType(index)))
        }
        
        shuffle()
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp}.only
        }
        
        set {cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    func cards(at index: Int) -> Card {
        return cards[index]
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
       
        if let chosenIndex = cards.firstIndex(where:  {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: ContentType
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
