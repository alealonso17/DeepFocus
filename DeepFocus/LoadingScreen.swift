//
//  LoadingScreen.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        let backgrounGradient = LinearGradient(colors:[
            Color(red: 0.36, green: 0.24, blue: 0.85),
            Color(red: 0.45, green: 0.26, blue: 0.90)
        ],
                startPoint: .top,
                endPoint: .bottom)
        VStack{
            Spacer()
            
            ZStack {
                Circle().fill(.white).frame(width: 160,height: 160)
                Circle().fill(backgrounGradient).frame(width: 130,height: 130)
                Circle().fill(.white.opacity(0.2)).frame(width: 107,height: 107)
            }.offset(y:-10)
            VStack(spacing: 10) {
                Text("DeepWork").font(.system(size: 60)).foregroundColor(.white)
                
                Text("Focus · Acomplish · Thrive").font(.title).foregroundColor(.white)
            }
           
            Spacer()
        }.offset(y:-10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgrounGradient)
    }
}

#Preview {
    LoadingScreen()
}
