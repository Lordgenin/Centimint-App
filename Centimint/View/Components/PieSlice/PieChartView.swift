//
//  PieChartView.swift
//  Centimint
//
//  Created by Sompumpkins on 10/19/23.
//

import SwiftUI

class PieChartViewModel: ObservableObject {
	let appCoordinator: AppCoordinator

	init(appCoordinator: AppCoordinator) {
		self.appCoordinator = appCoordinator
	}

}


struct PieChartView: View {
    var data: [PieSliceData]
    var totalValue: CGFloat {
        data.map { $0.value }.reduce(0, +)
    }

    var body: some View {
        let sliceAngles = angles(for: data.map { $0.value })
        let colors: [Color] = [
            .red, .blue, .green, .yellow, .orange, .pink, .purple, .gray, .black, .brown
        ]

        
        return ZStack {
               ForEach(0..<data.count, id: \.self) { index in
                   PieSlice(startAngle: sliceAngles[index].start, endAngle: sliceAngles[index].end)
                       .fill(colors[index % colors.count])  // Use modulo to wrap around
               }
           }
       }

    func angles(for values: [CGFloat]) -> [(start: Angle, end: Angle)] {
        var currentStart = Angle(degrees: 0)
        var angles: [(start: Angle, end: Angle)] = []

        for value in values {
            let portion = value / totalValue
            let degrees = portion * 360.0
            let currentEnd = currentStart + Angle(degrees: Double(degrees))
            angles.append((start: currentStart, end: currentEnd))
            currentStart = currentEnd
        }
        return angles
    }

}

struct PieSliceData {
    var title: String
    var value: CGFloat
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startPoint = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )

        var path = Path()
        path.move(to: center)
        path.addLine(to: startPoint)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(
            data: [
                PieSliceData(title: "Eating habits", value: 10),
                PieSliceData(title: "Test2", value: 20),
                PieSliceData(title: "Test3", value: 30),
                PieSliceData(title: "Eating habits", value: 40),
                PieSliceData(title: "Test2", value: 50),
                PieSliceData(title: "Test3", value: 60),
                PieSliceData(title: "Eating habits", value: 70),
                PieSliceData(title: "Test2", value: 80),
                PieSliceData(title: "Test3", value: 90)
            ]
        )
        //.frame(width: 150, height: 150)

    }
}
