//
//  WatchFaceApp.swift
//  WatchFace
//
//  Created by 颜小 on 08/07/2023.
//

import SwiftUI

@main
struct WatchFaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
