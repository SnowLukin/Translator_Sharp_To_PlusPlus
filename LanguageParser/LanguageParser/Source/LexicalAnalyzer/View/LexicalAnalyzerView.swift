//
//  LexicalAnalyzerView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

struct LexicalAnalyzerView: View {
    @StateObject private var viewModel = LexicalAnalyzerViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextEditor(text: $viewModel.code)
                    .lexemaTE(viewModel.code.isEmpty, "C# code")
                TextEditor(text: $viewModel.lexicalCode)
                    .lexemaTE(viewModel.lexicalCode.isEmpty, "Lexemas")
                    .disabled(true)
                VStack {
                    userTokenGrid(viewModel.identifierLexemas)
                        .lexemaToken(viewModel.identifierLexemas.isEmpty, "Identifiers")
                    userTokenGrid(viewModel.constantLexemas, viewModel.literalLexemas)
                        .lexemaToken(viewModel.constantLexemas.isEmpty && viewModel.literalLexemas.isEmpty, "Values")
                }
            }
            HStack {
                runButton
                resetButton
            }
        }.padding()
    }
}

struct LexicalAnalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        LexicalAnalyzerView()
    }
}


extension LexicalAnalyzerView {
    private var runButton: some View {
        Button {
            viewModel.run()
        } label: {
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "play.fill")
                        .font(.title)
                }
                .padding()
        }.buttonStyle(.plain)
    }
    
    private var resetButton: some View {
        Button {
            viewModel.reset()
        } label: {
            Text("Reset")
                .font(.headline)
                .frame(width: 100, height: 50)
                .background(.red)
                .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
    
    private func userTokenGrid(_ lexemas1: [Lexema], _ lexemas2: [Lexema] = []) -> some View {
        ScrollView(.vertical) {
            userTokenList(lexemas1)
                .padding([.horizontal, .top])
            
            if !lexemas2.isEmpty {
                userTokenList(lexemas2)
                    .padding([.horizontal, .bottom])
            }
        }
            .frame(maxHeight: .infinity)
            .frame(width: 200)
            .background(Color("background"))
            .cornerRadius(10)
    }
    
    private func userTokenList(_ lexemas: [Lexema]) -> some View {
        VStack(spacing: 5) {
            ForEach(lexemas, id: \.self) { lexema in
                HStack {
                    Text(lexema.value)
                    Spacer()
                    Divider()
                    Text(lexema.rawValue)
                        .frame(width: 40, alignment: .trailing)
                }.frame(height: 15)
            }
        }
    }
}
