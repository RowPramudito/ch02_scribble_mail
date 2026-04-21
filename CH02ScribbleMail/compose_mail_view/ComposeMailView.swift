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
    @Environment(\.dismiss) var dismiss
    
    @State private var recipient: String = ""
    @State private var subject: String = ""
    @State private var content: String = ""
    
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
                    // TextField("", text: $recipient)
                    Text("rowang.pramudito@gmail.com")
                }
                Divider()
                HStack {
                    Text("Caption:").opacity(0.5)
                    TextField("", text: $subject)
                }
                Divider()
                
                // drawing input
                DrawingCanvas()
                
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
                        
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    .buttonStyle(.borderedProminent).tint(Color(.green))
                }
            }
            .padding(.top, 10)
            .padding(.leading, 25).padding(.trailing, 25)
        }
    }
}

#Preview {
    ComposeMailView()
}

