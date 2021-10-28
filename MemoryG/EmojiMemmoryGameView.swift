//
//  ContentView.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 19.10.2021.
//

import SwiftUI

struct EmojiMemmoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach (game.cards) {card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            Spacer()
            HStack{
                Button(action: {
                    game.resetMemoryGame()
                }, label: {
                    Text("New Game")
                })
                    .font(.title)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                Spacer()
                Text("Score: \(game.getScore())")
                    .font(.title)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
        }
            .foregroundColor(game.themeColor)
            .padding(.horizontal)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemmoryGameView(game: game).preferredColorScheme(.dark)
        EmojiMemmoryGameView(game: game).preferredColorScheme(.light)
    }
}

