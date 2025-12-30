//
//  ContentView.swift
//  Memorize
//
//  Created by Anshu Vij on 14/11/25.
//

import SwiftUI


struct Theme {
    let name: String
    let icon: String
    let emojis: [String]
    let color: Color
}

// contentView behaves like a view
struct ContentView: View {
    
    @State var emojis = [String]()
    @State var cardCount: Int = 0
    @State var faceUpStates: [Bool] = []
    @State var themeColor: Color =  .orange
    
    let themes: [Theme] = [
        Theme(name: "Cars", icon: "car", emojis: ["🚙", "🏎️", "🚗", "🚕", "🚙", "🏎️", "🚗", "🚕"], color: .red),
        Theme(name: "Smile", icon: "face.smiling", emojis: ["😀", "🤪", "😆", "😁", "😀", "🤪", "😆", "😁"], color: .blue),
        Theme(name: "Default", icon: "restart.circle", emojis: ["👻", "🎃", "🕷️", "😈", "✈️","👻", "🎃", "🕷️", "😈", "✈️"], color: .orange)
    ]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
            
            ScrollView {
                cards
            }
            Spacer()
            // cardCountAdjusters
            cardThemes
            
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
    @ViewBuilder
    var cards: some View {
        if emojis.count > 0 {
            //LazyVGrid takes as minimum space as possible
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index], isFaceUp: $faceUpStates[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
                
            }
            .foregroundStyle(themeColor)
        } else {
            Text("Select a theme to start")
                .font(.title)
                .foregroundStyle(.red)
        }
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
    
    var cardThemes: some View {
        HStack {
            ForEach(themes, id: \.name) { theme in
                Spacer()
                Button {
                    emojis = theme.emojis.shuffled()
                    cardCount = theme.emojis.count
                    themeColor = theme.color
                    faceUpStates = .init(repeating: false, count: cardCount)
                } label: {
                    VStack {
                        Image(systemName: theme.icon)
                        Text(theme.name)
                            .font(.headline)
                    }
                }
                Spacer()

            }
            
        }
        .font(.title)
        .padding()
        
    }
}

struct CardView: View {
    let content: String
    @Binding var isFaceUp : Bool
    
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
    ContentView(emojis: [String](), faceUpStates: [])
}

