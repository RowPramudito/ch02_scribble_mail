//
//  ComposeMailView.swift
//  drawing_test
//
//  Created by Rowang Pramudito on 20/04/26.
//


import SwiftUI
import SwiftData
import Foundation

struct ComposeMailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var sender: String = "rowang.pram@email.com"
    @State var recipient: String
    @State var subject: String = ""
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                // text input
                HStack {
                    Text("To:").opacity(0.5)
                    TextField("", text: $recipient)
                }
                Divider()
                HStack {
                    Text("From:").opacity(0.5)
                    TextField("", text: $sender)
                    // Text("rowang.pramudito@gmail.com")
                }
                Divider()
                HStack {
                    Text("Caption:").opacity(0.5)
                    TextField("", text: $subject)
                }
                Divider()
                
                // drawing input
                // DrawingCanvas()
                
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
                    
                    DrawingCanvas(currentLine: $currentLine, lines: $lines, thickness: $thickness)
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
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                }
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                         guard let imageData = renderDrawing() else {return }
                         let newMail = MailSent(sender: sender, recipient: recipient, mail_title: subject, image_data: imageData, isRead: false)
                         modelContext.insert(newMail)
                        
                         try? modelContext.save()
                        
                        dismiss()
                        
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    .buttonStyle(.borderedProminent).tint(Color(.blue))
                }
            }
            .padding(.leading, 25).padding(.trailing, 25)
        }
    }
    
    /*
    @MainActor
    func renderDrawing() -> Data? {
        let renderer = ImageRenderer(content: DrawingCanvas(currentLine: $currentLine, lines: $lines, thickness: $thickness))
        renderer.scale = UITraitCollection.current.displayScale
        
        return renderer.uiImage?.pngData()
    }
    */
    
    @MainActor
    func renderDrawing() -> Data? {
        // Render ONLY the raw canvas content, not the full DrawingCanvas view
        let canvasView = Canvas { context, size in
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
        .frame(width: 393, height: 400)
        .background(Color.white)

        let renderer = ImageRenderer(content: canvasView)
        renderer.scale = UITraitCollection.current.displayScale
        return renderer.uiImage?.pngData()
    }
     
     
     
}

#Preview {
    ComposeMailView(recipient: "")
}

