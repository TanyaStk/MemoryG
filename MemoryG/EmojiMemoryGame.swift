//
//  EmojiMemoryGame.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 20.10.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
    static var emojis = Themes.themesArray.randomElement()!
    var themeColor = emojis.color
    
    static func createMemoryGame() -> MemoryGame<String> {
        if let numberOfPairsOfCards = (2...emojis.content.count).randomElement(){
            return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards, createCardContent: {
                pairIndex in emojis.content[pairIndex]
                        
            }, themeColor: emojis.color)
        }
        return MemoryGame<String>(numberOfPairsOfCards: 2, createCardContent: { pairIndex in emojis.content[pairIndex]}, themeColor: .pink)
    }
    
    func resetMemoryGame() {
        EmojiMemoryGame.emojis = Themes.themesArray.randomElement()!
        themeColor = EmojiMemoryGame.emojis.color
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func getScore() -> Int {
        return model.getScore()
    }
    
}
