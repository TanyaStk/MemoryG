//
//  ContentView.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 19.10.2021.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🥳", "🎉", "👯‍♂️", "🍾", "🎁", "🎈", "🎊", "🪅", "😜", "🎂", "🎶", "❤️‍🔥", "🎀","🍺","🥃"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach (emojis[0..<emojiCount],id: \.self) {emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.pink)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }.font(.largeTitle)
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1{
                emojiCount -= 1
            }
        }label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View{
        let shape = RoundedRectangle(cornerRadius: 20.0)
        ZStack {
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }else{
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

