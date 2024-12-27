import SwiftUI
import Charts

struct HalfDonutAndAreaChartView: View {
    var body: some View {
        ZStack {
            // Half-Donut Background
            HalfDonutShape()
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: [.blue, .green, .orange, .red]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180)
                    )
                )
                .frame(width: 300, height: 150) // Adjust size
            
            // Area Chart
            AreaChartView()
                .frame(width: 280, height: 140) // Adjust size to fit within the donut
        }
        .padding()
    }
}

// MARK: - Half Donut Shape
struct HalfDonutShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.width / 2
        let center = CGPoint(x: rect.midX, y: rect.maxY)
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: .degrees(0),
            endAngle: .degrees(180),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: rect.midX - radius, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + radius, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Area Chart
struct AreaChartView: View {
    let data: [AngleData] = (0...180).map { angle in
        AngleData(angle: Double(angle), value: sin(Double(angle) * .pi / 180)) // Example function: sine wave
    }
    
    var body: some View {
        Chart(data) {
            AreaMark(
                x: .value("Angle (°)", $0.angle),
                y: .value("Value", $0.value)
            )
            .foregroundStyle(LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.5), .clear]),
                startPoint: .top,
                endPoint: .bottom
            ))
        }
    }
}

// MARK: - Data Model
struct AngleData: Identifiable {
    let id = UUID()
    let angle: Double
    let value: Double
}

#Preview {
    HalfDonutAndAreaChartView()
}
