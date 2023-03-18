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
            List(MainSection.allCases, selection: $viewModel.selectedMainSection) { section in
                Text(section.rawValue)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.updateCode(with: viewModel.code)
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    .keyboardShortcut("r", modifiers: .command)
                }
                
                ToolbarItem {
                    Button {
                        viewModel.nextSection()
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    .keyboardShortcut(.downArrow, modifiers: .command)
                    .hidden()
                }
            }
        } detail: {
            switch viewModel.selectedMainSection {
            case .codingSpace:
                CodingSpaceView()
                    .environmentObject(viewModel)
            case .lexicalAnalyzer:
                LexicalAnalyzerView(inputCode: viewModel.savedCode)
            case .polishNotation:
                PolishNotationView(inputCode: viewModel.savedCode)
            default:
                Text("Select module.")
            }
        }
    }
}
