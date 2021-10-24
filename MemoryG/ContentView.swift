//
//  ContentView.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 19.10.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach (viewModel.cards) {card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            Spacer()
            HStack{
                Button(action: {
                    viewModel.resetMemoryGame()
                }, label: {
                    Text("New Game")
                })
                    .font(.title)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                Spacer()
                Text("Score: \(viewModel.getScore())")
                    .font(.title)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
        }
            .foregroundColor(viewModel.themeColor)
            .padding(.horizontal)
    }
}

struct CardView: View{
    let card: MemoryGame<String>.Card
    
    var body: some View{
        let shape = RoundedRectangle(cornerRadius: 20.0)
        ZStack {
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game).preferredColorScheme(.dark)
        ContentView(viewModel: game).preferredColorScheme(.light)
    }
}

