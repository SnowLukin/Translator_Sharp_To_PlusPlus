//
//  ContentView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    LexicalAnalyzerView()
                } label: {
                    Text("Lexical analyzer")
                }
                
                NavigationLink {
                    PolishNotationView()
                } label: {
                    Text("Polish notation")
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
