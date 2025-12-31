//
//  MemorizeGameView.swift
//  Memorize
//
//  Created by Anshu Vij on 14/11/25.
//

import SwiftUI

// contentView behaves like a view
struct MemorizeGameView: View {
    
    @ObservedObject var memorizeEmojiViewModel: MemorizeGameViewModel
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
            
            ScrollView {
                cards
                    .animation(.default, value: memorizeEmojiViewModel.cards)
            }
            
            Button {
                memorizeEmojiViewModel.shuffle()
            } label: {
                Text("Shuffle")
            }

        }
        .padding() // doesn't pass down to internal views
    }

    @ViewBuilder
    var cards: some View {
        //LazyVGrid takes as minimum space as possible
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(memorizeEmojiViewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        memorizeEmojiViewModel.choose(card)
                    }
                
                   
            }
            
        }
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)  // Type Inference
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
        
    }
}


#Preview {
    MemorizeGameView(memorizeEmojiViewModel: MemorizeGameViewModel())
}

