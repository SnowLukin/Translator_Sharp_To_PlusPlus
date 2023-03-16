//
//  LexemeTableView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 17.03.2023.
//

import SwiftUI

struct LexemeTableView: View {
    var lexemes: [Lexeme]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(lexemes, id: \.self) { lexeme in
                HStack {
                    Text(lexeme.value)
                    Spacer()
                    Text(lexeme.rawValue)
                }.padding(.vertical, 5)
                Divider()
            }
        }
        .padding()
        .background(Color.codeBackground)
        .cornerRadius(10)
    }
}
