//
//  Themes.swift
//  MemoryG
//
//  Created by Tanya Samastroyenka on 22.10.2021.
//

import SwiftUI

struct Theme {
    var content: [String]
    var color: Color
    
    init(content: [String], color: Color){
        self.content = content
        self.color = color
    }
}

struct Themes {
    
    private static let partyTheme = Theme(content: ["🥳", "🎉", "👯‍♂️", "🍾", "🎁", "🎈"], color: .pink)
    private static let haloweenTheme = Theme(content: ["👻", "😱", "😈", "🎃", "🧛‍♀️", "🕷"], color: .orange)
    private static let fruitsTheme = Theme(content: ["🍎", "🍐", "🍊", "🍓", "🍒", "🍑"], color: .green)
    
    static let themesArray = [partyTheme, haloweenTheme, fruitsTheme]
}


