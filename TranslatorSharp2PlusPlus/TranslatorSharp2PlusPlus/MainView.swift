//
//  MainView.swift
//  TranslatorSharp2PlusPlus
//
//  Created by Snow Lukin on 03.03.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = LexicalTranslator()
    @State private var lexResult: String = ""
    
    let sampleCode = """
    using System;
    namespace YourNamespace {
        class Program {
            static void Main() {
                double c = 3;
                
                int a = 1;
                int e3 = 2;
                int chh = 0;
                if (ed > 2.79) {
                    b = a * e3;
                    f = "as ;ds";
                    chh += 1;
                }
                int count = 0;
                int sd~assd = 212;
                while(true) {
                    if count == 12 {
                        break;
                    }
                }
            }
        }
    }
    """
    var body: some View {
        VStack {
            Text("Hello World")
            Button("Click!") {
                print(viewModel.translate(input: sampleCode))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
