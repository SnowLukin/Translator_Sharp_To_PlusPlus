//
//  MainView.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import SwiftUI

struct MainView: View {
    
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
