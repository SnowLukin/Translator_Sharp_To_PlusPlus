//
//  CodingTextEditModifier.swift
//  LanguageParser
//
//  Created by Snow Lukin on 17.03.2023.
//

import SwiftUI

struct CodingTextEditModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            content
                .scrollContentBackground(.hidden)
                .scrollDisabled(false)
                .font(.body)
                .fontDesign(.monospaced)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding(.vertical)
                .padding(.leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.codeBackground)
    }
}
