//
//  CodeHeaderButton.swift
//  LanguageParser
//
//  Created by Snow Lukin on 17.03.2023.
//

import SwiftUI

struct CodeHeaderButton: View {
    
    var text: String
    var condition: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(text)
                .frame(maxWidth: .infinity)
                .frame(height: 25)
                .background(condition ? Color.codeBackground : Color(.windowBackgroundColor))
        }.buttonStyle(.plain)
    }
}
