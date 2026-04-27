//
//  Colors.swift
//  ch02_scribble_mail
//
//  Created by Al Barra' Nasser Attamimy on 26/04/26.
//
import SwiftUI

extension Color {
    static let risoBackground = Color(hex: "#F5F0E8")
    static let risoCorаl = Color(hex: "#E85A3A")
    static let risoMustard = Color(hex: "#F2C12E")
    static let risoNavy = Color(hex: "#1B2A4A")
    static let risoSage = Color(hex: "#A8B5A0")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        r = Double((int >> 16) & 0xFF) / 255
        g = Double((int >> 8) & 0xFF) / 255
        b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
