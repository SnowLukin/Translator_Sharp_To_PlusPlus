//
//  View+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import SwiftUI

extension View {
    func lexemaTE(_ status: Bool, _ string: String) -> some View {
        modifier(LexemaTextEditorModifier(status: status, string: string))
    }
    
    func lexemaToken(_ status: Bool, _ string: String) -> some View {
        modifier(LexemaTokenGridModifier(status: status, string: string))
    }
}
