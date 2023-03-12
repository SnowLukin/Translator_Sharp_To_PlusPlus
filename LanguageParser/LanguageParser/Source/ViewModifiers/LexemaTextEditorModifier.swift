//
//  LexemaTextEditorModifier.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

struct LexemaTextEditorModifier: ViewModifier {
    var status: Bool
    var string: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .font(.system(size: 14, design: .rounded))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(10)
                .overlay {
                    if status {
                        Text(string)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background"))
            .cornerRadius(10)
    }
}
