//
//  ColorPickerView.swift
//  drawing_test
//
//  Created by Rowang Pramudito on 17/04/26.
//


import SwiftUI

struct ColorPickerView: View {
    
    let colors = [Color.black, Color.red, Color.yellow, Color.green, Color.blue, Color.purple]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
            
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
                    Spacer()
            }
        }
        .padding(25)
    }
}

struct ColorListView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.black))
    }
}
