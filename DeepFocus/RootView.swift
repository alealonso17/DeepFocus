//
//  RootView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI

struct RootView: View {

    @State private var showMainApp = false

    var body: some View {
        ZStack {
            if showMainApp {
                MainTabView()
                    .transition(.opacity)
            } else {
                LoadingScreen()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    showMainApp = true
                }
            }
        }
    }
}
