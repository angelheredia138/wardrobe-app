//
//  Color.swift
//  CSE355 Class Project
//
//  Created by Angel Heredia on 4/13/24.
//

import Foundation
import SwiftUI

extension Color {
    static let appPrimary = Color("PrimaryColor", bundle: nil) // Deep Blue or Teal
    static let appSecondary = Color("SecondaryColor", bundle: nil) // Coral or Soft Red
    static let appAccent = Color("AccentColor", bundle: nil) // Warm Yellow
    func uiColor() -> UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        } else {
            // Fallback on earlier versions or add additional handling
            return .black
        }
    }
}

extension UIColor {
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }

    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 1.0

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }

    func luminance() -> CGFloat {
        let components = self.cgColor.components
        let r = components?[0] ?? 0
        let g = components?[1] ?? 0
        let b = components?[2] ?? 0

        // Using the relative luminance formula
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }

    func rgbComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }

    func colorDistance(from color2: UIColor) -> CGFloat {
        let comp1 = self.rgbComponents()
        let comp2 = color2.rgbComponents()

        return sqrt(pow(comp1.red - comp2.red, 2) +
                    pow(comp1.green - comp2.green, 2) +
                    pow(comp1.blue - comp2.blue, 2))
    }
}

extension Font {
    static let bodyStyle = Font.system(size: 16, weight: .regular, design: .rounded)
    static let headlineStyle = Font.system(size: 18, weight: .medium, design: .rounded)
    static let titleStyle = Font.system(size: 20, weight: .semibold, design: .rounded)
}

