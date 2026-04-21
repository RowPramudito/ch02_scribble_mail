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
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    lines = []
                    currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
                })
                {
                    HStack {
                        Image(systemName: "xmark")
                        Text("Clear canvas")
                    }
                    
                }
                .foregroundColor(.black)
                .cornerRadius(10)
            }
            
            Canvas { context, size in
                
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
            .frame(maxWidth: .infinity, maxHeight: 400)
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

            .padding(.bottom, 12).padding(.top, 12)
            
            Slider(value: $thickness, in: 1...20) {
                Text("Thickness")
            } minimumValueLabel: {
                Image(systemName: "scribble")
            } maximumValueLabel: {
                Image(systemName: "scribble.variable")
            }
            .frame(maxWidth: 320, alignment: .center)
            .padding(8)
            
            ColorPickerView(selectedColor: $currentLine.color)
        }
        .padding(.top, 20).padding(.bottom, 20)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Mail.self, configurations: config)
    
    return DrawingCanvas()
        .modelContainer(container)
}
