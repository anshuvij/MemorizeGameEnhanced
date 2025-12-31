//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anshu Vij on 14/11/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var model = MemorizeGameViewModel()
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(memorizeEmojiViewModel: model)
        }
    }
}
