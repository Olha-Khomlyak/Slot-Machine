//
//  Slot_MachineApp.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 15.11.2023.
//

import SwiftUI

@main
struct Slot_MachineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
