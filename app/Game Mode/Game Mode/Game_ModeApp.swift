//
//  Game_ModeApp.swift
//  Game Mode
//
//  Created by Илья Кот on 4/28/25.
//

import SwiftUI

@main
struct Game_ModeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
