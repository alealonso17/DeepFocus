//
//  MainTabView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            TaskView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            FocusView()
                .tabItem{
                    Image(systemName: "timer")
                    Text("Focus")
                }
            ProgressView()
                .tabItem{
                    Image(systemName: "chart.line.uptrend.xyaxis").foregroundColor(.purple)
                    Text("Progress")
                }
            
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}
