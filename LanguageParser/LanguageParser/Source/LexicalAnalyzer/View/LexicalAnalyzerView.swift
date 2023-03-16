//
//  LexicalAnalyzerView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI


struct LexicalAnalyzerView: View {
    
    enum LexicalSection {
        case output
        case tables
    }
    
    @StateObject private var viewModel = LexicalAnalyzerViewModel()
    @State private var lexicalSection = LexicalSection.output
    var inputCode: String
    
    var body: some View {
        VStack(spacing: 0) {
            headerButtons
            
            switch lexicalSection {
            case .output:
                TextEditor(text: $viewModel.lexemesCode)
                    .modifier(CodingTextEditModifier())
            case .tables:
                tableSectionBody
            }
        }
        .onAppear {
            viewModel.update(with: inputCode)
        }
    }
}

extension LexicalAnalyzerView {
    
    private var headerButtons: some View {
        HStack(spacing: 0) {
            CodeHeaderButton(text: "Output", condition: lexicalSection == .output) {
                lexicalSection = .output
            }
            CodeHeaderButton(text: "Generated/System Tables", condition: lexicalSection == .tables) {
                lexicalSection = .tables
            }
        }
    }
    
    private var tableSectionBody: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 300), alignment: .top),
                    GridItem(.adaptive(minimum: 300), alignment: .top),
                    GridItem(.adaptive(minimum: 300), alignment: .top)
                ], spacing: 20)
            {
                LexemeTableView(lexemes: viewModel.identifierLexemas)
                LexemeTableView(lexemes: viewModel.constantLexemas)
                LexemeTableView(lexemes: viewModel.literalLexemas)
                
                LexemeTableView(lexemes: SystemTable.keyword.getTable())
                LexemeTableView(lexemes: SystemTable.divider.getTable())
                LexemeTableView(lexemes: SystemTable.operator.getTable())
            }
            .padding()
        }
    }
}
