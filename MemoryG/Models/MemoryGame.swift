//
//  MemoryGame.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 20.10.2021.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get { cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    var themeColor: Color
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[choosenIndex].isFaceUp,
           !cards[choosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[choosenIndex].content == cards[potentialMatchIndex].content{
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    changeScore(to: score + MATCH_POINT_CHANGE)
                } else {
                    changeScore(to: score - MISMATCH_POINT_CHANGE)
                }
                cards[choosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
        }
    }
 
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent, themeColor: Color){
        cards = []
        score = 0
        //add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
        self.themeColor = themeColor
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func changeScore(to newScore: Int) {
        score = newScore
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
    
    //MARK: Constants
    
    let MATCH_POINT_CHANGE = 10
    let MISMATCH_POINT_CHANGE = 5
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
