//
//  MemoryGApp.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 19.10.2021.
//

import SwiftUI

@main
struct MemoryGApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
