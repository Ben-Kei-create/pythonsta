//
//  AppColors.swift
//  pythonsta
//
//  Created by 茂木史明 on 2026/06/05.
//

import SwiftUI

extension Color {
    static let primaryPurple = Color(hex: "#5C44F5")
    static let deepPurple    = Color(hex: "#4026D9")
    static let pythonLime    = Color(hex: "#B9F238")
    static let snakeGreen    = Color(hex: "#20D6A4")
    static let appTeal       = Color(hex: "#1FD1C2")
    static let warmYellow    = Color(hex: "#FFD66B")
    static let appBackground = Color(hex: "#F7F8FC")
    static let textDark      = Color(hex: "#1D2433")
    static let textGray      = Color(hex: "#7A8194")
    static let successGreen  = Color(hex: "#36D399")
    static let errorRed      = Color(hex: "#FF6B6B")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
