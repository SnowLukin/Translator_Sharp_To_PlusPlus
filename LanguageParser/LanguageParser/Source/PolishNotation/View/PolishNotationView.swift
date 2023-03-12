//
//  PolishNotationView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

struct PolishNotationView: View {
    
    @StateObject private var viewModel = PolishNotationViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextEditor(text: $viewModel.code)
                    .lexemaTE(viewModel.code.isEmpty, "Code")
                TextEditor(text: $viewModel.polishNotation)
                    .lexemaTE(viewModel.polishNotation.isEmpty, "Polish Notation")
            }
            HStack {
                runButton
                resetButton
            }
        }.padding()
    }
}

struct PolishNotationView_Previews: PreviewProvider {
    static var previews: some View {
        PolishNotationView()
    }
}

extension PolishNotationView {
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
}
