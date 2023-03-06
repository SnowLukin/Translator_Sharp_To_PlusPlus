//
//  LexemaTokenGridModifier.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import SwiftUI

struct LexemaTokenGridModifier: ViewModifier {
    var status: Bool
    var string: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if status {
                    Text(string)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
            }
    }
}
