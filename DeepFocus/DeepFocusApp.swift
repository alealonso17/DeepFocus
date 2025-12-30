//
//  DeepFocusApp.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI
import SwiftData

@main
struct DeepFocusApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }.modelContainer(for: TaskModel.self)
    }
}
