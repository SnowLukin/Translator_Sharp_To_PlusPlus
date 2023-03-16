//
//  CodingSpaceView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 14.03.2023.
//

import SwiftUI

struct CodingSpaceView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        TextEditor(text: $viewModel.code)
            .modifier(CodingTextEditModifier())
            .toolbar {
                ToolbarItem {
                    Button {
                        print("Import")
                    } label: {
                        Image(systemName: "square.and.arrow.down.fill")
                    }
                }
            }
    }
}
