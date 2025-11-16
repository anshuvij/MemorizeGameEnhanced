//
//  ContentView.swift
//  Memorize
//
//  Created by Anshu Vij on 14/11/25.
//

import SwiftUI

// contentView behaves like a view
struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "✈️", "🕸️", "😱", "🍟", "🔥","😏"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
           
        }
        .padding() // doesn't pass down to internal views
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cards: some View {
        //LazyVGrid takes as minimum space as possible
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundStyle(.orange)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol:  "rectangle.stack.badge.minus.fill")
        
    }
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol:  "rectangle.stack.badge.plus.fill")
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
           
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp : Bool = true // @State keeps a pointer to isFaceUp thats why since pointer cant change but the isFaceUp can change
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)  // Type Inference
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}






#Preview {
    ContentView()
}
