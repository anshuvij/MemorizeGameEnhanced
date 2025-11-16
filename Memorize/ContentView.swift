//
//  ContentView.swift
//  Memorize
//
//  Created by Anshu Vij on 14/11/25.
//

import SwiftUI

// contentView behaves like a view
struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "😈"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp : Bool = true // @State keeps a pointer to isFaceUp thats why since pointer cant change but the isFaceUp can change
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)  // Type Inference
            if isFaceUp {
               base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}






#Preview {
    ContentView()
}
