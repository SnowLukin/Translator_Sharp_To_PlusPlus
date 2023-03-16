//
//  MainView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 16.03.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    CodingSpaceView()
                        .environmentObject(viewModel)
                } label: {
                    Text("Coding Space")
                }
                
                NavigationLink {
                    LexicalAnalyzerView(inputCode: viewModel.savedCode)
                } label: {
                    Text("Lexical analyzer")
                }
                
                NavigationLink {
                    PolishNotationView(inputCode: viewModel.savedCode)
                } label: {
                    Text("Polish notation")
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.updateCode(with: viewModel.code)
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    .keyboardShortcut("r", modifiers: .command)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
}
