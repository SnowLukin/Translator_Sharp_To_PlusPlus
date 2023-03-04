//
//  TranslatorSharp2PlusPlusApp.swift
//  TranslatorSharp2PlusPlus
//
//  Created by Snow Lukin on 03.03.2023.
//

import SwiftUI

@main
struct TranslatorSharp2PlusPlusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainView()
        }
    }
}
