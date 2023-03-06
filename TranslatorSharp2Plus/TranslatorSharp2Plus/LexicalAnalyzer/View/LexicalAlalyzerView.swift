//
//  LexicalAlalyzerView.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import SwiftUI
import AppKit

struct LexicalAlalyzerView: View {
    @StateObject private var viewModel = LexicalAnalyzerViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextEditor(text: $viewModel.code)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .autocorrectionDisabled()
                TextEditor(text: $viewModel.lexicalCode)
                    .font(.system(size: 14, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .disabled(true)
                    
            }
            HStack {
                Button("Run") {
                    viewModel.run()
                }
                .padding()
                
                Button("Clear") {
                    viewModel.reset()
                }
                .padding()
            }
        }
    }
}

struct LexicalAlalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        LexicalAlalyzerView()
    }
}
