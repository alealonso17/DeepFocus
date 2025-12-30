//
//  FocusView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 29/12/25.
//

import SwiftUI
struct FocusView: View {

    @State private var studyTime: Double = 25
    @State private var breakTime: Double = 5

    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(title: "Pomodoro", description: "Configure your session")

                Spacer()

                VStack {
                    FocusSlider(
                        title: "Study Time",
                        icon: Image(systemName: "brain"),
                        from: 10,
                        to: 90,
                        count: $studyTime
                    )

                    FocusSlider(
                        title: "Break Time",
                        icon: Image(systemName: "cup.and.saucer"),
                        from: 5,
                        to: 30,
                        count: $breakTime
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(.white)
                .cornerRadius(30)
                .padding(.horizontal, 20)

               
                NavigationLink {
                    TimerView(
                        studyMinutes: Int(studyTime),
                        breakMinutes: Int(breakTime)
                    )
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Start Session")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(.blue)
                    .cornerRadius(16)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                }

                Spacer()
            }
            .background(Color.backgroundTask)
        }
    }
}
struct FocusSlider: View {
    let title: String
    let icon: Image
    let from: Double
    let to: Double
    @Binding var count: Double   // 👈 binding

    var body: some View {
        VStack {
            HStack {
                HStack {
                    icon.foregroundColor(.blue)
                    Text(title)
                }
                Spacer()
                Text("\(Int(count)) min")
                    .foregroundColor(.blue)
                    .bold()
            }
            .padding(.horizontal, 60)

            Slider(value: $count, in: from...to)
                .padding(.horizontal, 50)
        }
        .frame(maxHeight: 100)
    }
}


#Preview {
    FocusView()
}
