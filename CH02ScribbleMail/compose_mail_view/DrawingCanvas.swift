//
//  ContentView.swift
//  drawing_test
//
//  Created by Rowang Pramudito on 16/04/26.
//

import SwiftUI
import SwiftData

struct Line {
    var points = [CGPoint]()
    var color: Color = .black
    var lineWidth: Double = 1.0
}

struct DrawingCanvas: View {
    @Environment(\.modelContext) private var modelContext
    
    var backgroundImage: UIImage?
    
    @Binding var currentLine: Line
    @Binding var lines: [Line]
    @Binding var thickness: Double

    var body: some View {
        Canvas { context, size in
            
            if let uiImage = backgroundImage {
                            let image = Image(uiImage: uiImage)
                            let resolved = context.resolve(image)
                            context.draw(resolved, in: CGRect(origin: .zero, size: size))
            }
            
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color), style: StrokeStyle(
                        lineWidth: line.lineWidth,
                        lineCap: .round,
                        lineJoin: .round
                ))
            }
            
            var activePath = Path()
            activePath.addLines(currentLine.points)
            context.stroke(activePath, with: .color(currentLine.color), style: StrokeStyle(
                lineWidth: currentLine.lineWidth,
                lineCap: .round,
                lineJoin: .round
            ))
        }
        .frame(width: 350, height: 350)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.25), lineWidth: 2)
        )
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({value in
                currentLine.lineWidth = thickness
                currentLine.points.append(value.location)
            })
            .onEnded({value in
                self.lines.append(currentLine)
                self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
            })
        )
    }
}


/*
#Preview {
    DrawingCanvas()
}
*/


