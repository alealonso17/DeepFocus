//
//  TimerView.swift
//  DeepFocus
//
//  Created by Alejandro Alonso on 30/12/25.
//

import SwiftUI
import Combine

struct TimerView: View {

    let studyMinutes: Int
    let breakMinutes: Int

    enum SessionPhase {
        case study
        case rest
    }

    @State private var phase: SessionPhase = .study
    @State private var remainingSeconds: Int
    @State private var totalSeconds: Int
    @State private var isRunning = true

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(studyMinutes: Int, breakMinutes: Int) {
        self.studyMinutes = studyMinutes
        self.breakMinutes = breakMinutes

        let seconds = studyMinutes * 60
        _remainingSeconds = State(initialValue: seconds)
        _totalSeconds = State(initialValue: seconds)
    }

    var body: some View {
        VStack {
            HeaderView(
                title: "Pomodoro",
                description: phase == .study ? "Focus on your work" : "Take a short break"
            )

            Spacer()

            ZStack {
                // Fondo gris
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 14)

                // Progreso dinámico
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        phase == .study ? Color.blue : Color.green,
                        style: StrokeStyle(lineWidth: 14, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear, value: remainingSeconds)

                VStack(spacing: 10) {
                    // Tiempo
                    Text(timeString)
                        .font(.system(size: 56, weight: .bold))

                    // Badge WORKING / RESTING
                    HStack(spacing: 6) {
                        Image(systemName: phase == .study
                              ? "brain.head.profile"
                              : "cup.and.saucer.fill")
                        Text(phase == .study ? "WORKING" : "RESTING")
                    }
                    .font(.caption)
                    .bold()
                    .foregroundColor(phase == .study ? .blue : .green)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill((phase == .study ? Color.blue : Color.green).opacity(0.15))
                    )
                }
            }
            .frame(width: 260, height: 260)

            Spacer()

            // Controles
            HStack(spacing: 40) {
                Button {
                    isRunning.toggle()
                } label: {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.title)
                        .frame(width: 70, height: 70)
                        .background(phase == .study ? Color.blue : Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }

                Button {
                    reset()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title)
                        .frame(width: 70, height: 70)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }

            Spacer()
        }
        .background(Color.backgroundTask)
        .onReceive(timer) { _ in
            guard isRunning else { return }

            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                switchPhase()
            }
        }
    }

    // 🔢 Progreso circular
    var progress: CGFloat {
        CGFloat(remainingSeconds) / CGFloat(totalSeconds)
    }

    // ⏱ Formato mm:ss
    var timeString: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // 🔁 Cambio automático de fase
    func switchPhase() {
        withAnimation {
            if phase == .study {
                phase = .rest
                totalSeconds = breakMinutes * 60
            } else {
                phase = .study
                totalSeconds = studyMinutes * 60
            }
            remainingSeconds = totalSeconds
        }
    }

    // 🔄 Reset manual
    func reset() {
        withAnimation {
            phase = .study
            totalSeconds = studyMinutes * 60
            remainingSeconds = totalSeconds
            isRunning = false
        }
    }
}
