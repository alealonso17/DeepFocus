import SwiftUI

struct ProgressView: View {

    let days = Array(1...31)
    let fakeIntensity: [Int: Int] = [
        1: 1, 2: 2, 3: 3, 5: 4, 8: 2, 10: 3, 12: 1,
        15: 4, 18: 3, 20: 2, 22: 4, 25: 3, 30: 1
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                HeaderView(title: "Progress", description: "Track your journey").padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                // STATS
                HStack(spacing: 16) {
                    StatCard(icon: "target", value: "0", label: "Total")
                    StatCard(icon: "flame", value: "0", label: "Streak")
                    StatCard(icon: "chart.line.uptrend.xyaxis", value: "0", label: "This Month")
                }
                .padding(.horizontal)

                // CALENDAR CARD
                VStack(spacing: 16) {

                    // Month selector
                    HStack {
                        Image(systemName: "chevron.left")
                        Spacer()
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                            Text("December 2025")
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal)

                    // Week days
                    HStack {
                        ForEach(["S","M","T","W","T","F","S"], id: \.self) {
                            Text($0)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                        }
                    }

                    // Days grid
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                        ForEach(days, id: \.self) { day in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorFor(day))
                                .frame(height: 42)
                                .overlay(
                                    Text("\(day)")
                                        .foregroundColor(.black.opacity(0.7))
                                )
                        }
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal)

                // LEGEND
                HStack(spacing: 12) {
                    Text("Less")
                        .foregroundColor(.gray)

                    ForEach(0..<4) { i in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(intensityColor(i))
                            .frame(width: 30, height: 16)
                    }

                    Text("More")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(.white)
                .cornerRadius(16)
                .padding(.horizontal)

            }
            .padding(.vertical)
        }
        .background(Color.backgroundTask)
    }

    // MARK: Fake helpers

    func colorFor(_ day: Int) -> Color {
        let level = fakeIntensity[day, default: 0]
        return intensityColor(level)
    }

    func intensityColor(_ level: Int) -> Color {
        switch level {
        case 1: return Color.blue.opacity(0.15)
        case 2: return Color.blue.opacity(0.3)
        case 3: return Color.blue.opacity(0.5)
        case 4: return Color.blue
        default: return Color.gray.opacity(0.15)
        }
    }
}
struct StatCard: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.blue)

            Text(value)
                .font(.title2)
                .bold()

            Text(label)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .frame(maxWidth: .infinity, minHeight: 90)
        .background(.white)
        .cornerRadius(16)
    }
}

#Preview {
    ProgressView()
}
