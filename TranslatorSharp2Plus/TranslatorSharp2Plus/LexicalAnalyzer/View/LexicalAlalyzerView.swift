//
//  LexicalAlalyzerView.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import SwiftUI

struct LexicalAlalyzerView: View {
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
                    userTokenGrid(viewModel.numericLexemas, viewModel.stringLiteralLexemas)
                        .lexemaToken(viewModel.numericLexemas.isEmpty && viewModel.stringLiteralLexemas.isEmpty, "Values")
                }
            }
            HStack {
                runButton
                resetButton
            }
        }.padding()
    }
}

struct LexicalAlalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        LexicalAlalyzerView()
    }
}

extension LexicalAlalyzerView {
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
    
    private func userTokenGrid(_ tokens1: [Token], _ tokens2: [Token] = []) -> some View {
        ScrollView(.vertical) {
            userTokenList(tokens1)
                .padding([.horizontal, .top])
            
            if !tokens2.isEmpty {
                userTokenList(tokens2)
                    .padding([.horizontal, .bottom])
            }
        }
            .frame(maxHeight: .infinity)
            .frame(width: 200)
            .background(Color("background"))
            .cornerRadius(10)
    }
    
    private func userTokenList(_ tokens: [Token]) -> some View {
        VStack(spacing: 5) {
            ForEach(tokens, id: \.self) { token in
                HStack {
                    Text(token.value)
                    Spacer()
                    Divider()
                    Text(token.toString)
                        .frame(width: 40, alignment: .trailing)
                }.frame(height: 15)
            }
        }
    }
}
