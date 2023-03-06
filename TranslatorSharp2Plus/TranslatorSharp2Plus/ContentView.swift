//
//  ContentView.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    LexicalAlalyzerView()
                } label: {
                    Text("Lexical analyzer")
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
