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
                    userTokenGrid(viewModel.valueLexemas, prefix1: "N", viewModel.symbolLexemas)
                        .lexemaToken(viewModel.valueLexemas.isEmpty, "Values")
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
    
    private func userTokenGrid(_ tokens1: [UserToken], prefix1: String = "I", _ tokens2: [UserToken] = [], prefix2: String = "S") -> some View {
        ScrollView(.vertical) {
            userTokenList(tokens1, prefix1)
                .padding([.horizontal, .top])
            
            if !tokens2.isEmpty {
                userTokenList(tokens2, prefix2)
                    .padding([.horizontal, .bottom])
            }
        }
            .frame(maxHeight: .infinity)
            .frame(width: 200)
            .background(Color("background"))
            .cornerRadius(10)
    }
    
    private func userTokenList(_ tokens: [UserToken], _ prefix: String) -> some View {
        VStack(spacing: 5) {
            ForEach(tokens, id: \.self) { lexema in
                HStack {
                    Text(lexema.value)
                    Spacer()
                    Divider()
                    Text("\(prefix)_\(lexema.id)")
                        .frame(width: 40, alignment: .trailing)
                }.frame(height: 15)
            }
        }
    }
}
