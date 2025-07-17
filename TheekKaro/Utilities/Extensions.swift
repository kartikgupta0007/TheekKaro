import SwiftUI
import Foundation

// MARK: - Design System Colors
extension Color {
    // MARK: - Primary Colors
    static let tkPrimary = Color(hex: "606c38")           // Primary green for borders, accents
    static let tkPrimaryDark = Color(hex: "283618")       // Dark green for headers, main text
    static let tkPrimaryLight = Color(hex: "374017")      // Dark green for chip text
    
    // MARK: - Secondary Colors
    static let tkSecondary = Color(hex: "bc6c25")         // Orange/brown for accent text, location
    static let tkSecondaryBackground = Color(hex: "e8e0cb") // Light beige/cream background
    
    // MARK: - Surface Colors
    static let tkSurface = Color.white                    // White for input areas
    static let tkSurfaceVariant = Color(hex: "fefae0")    // Cream for button text
    
    // MARK: - Interactive Colors
    static let tkButtonPrimary = Color(hex: "606c38").opacity(0.6)  // Primary button background
    static let tkChipBackground = Color(hex: "374017").opacity(0.12) // Chip background
    static let tkBorderDashed = Color(hex: "606c38").opacity(0.4)   // Dashed border
    
    // MARK: - Text Colors
    static let tkTextPrimary = Color(hex: "283618")       // Primary text (headers)
    static let tkTextSecondary = Color(hex: "606c38")     // Secondary text (descriptions)
    static let tkTextAccent = Color(hex: "bc6c25")        // Accent text (location)
    static let tkTextChip = Color(hex: "374017")          // Chip text
    static let tkTextButton = Color(hex: "fefae0")        // Button text
    static let tkTextPlaceholder = Color(hex: "444d28").opacity(0.5) // Placeholder text
}

// MARK: - Design System Typography
extension Font {
    // MARK: - Headers
    static let tkTitle = Font.custom("Raleway", size: 32).weight(.bold)
    static let tkSectionHeader = Font.custom("Raleway", size: 20).weight(.bold)
    
    // MARK: - Body Text
    static let tkBody = Font.system(size: 16, weight: .regular)
    static let tkBodySmall = Font.system(size: 14, weight: .regular)
    static let tkCaption = Font.system(size: 12, weight: .regular)
    
    // MARK: - Interactive Elements
    static let tkButton = Font.system(size: 20, weight: .regular)
    static let tkButtonSecondary = Font.system(size: 16, weight: .regular)
    static let tkChip = Font.system(size: 14, weight: .regular)
    static let tkLocationTag = Font.system(size: 14, weight: .semibold)
}

// MARK: - Design System Spacing
extension CGFloat {
    // MARK: - Padding
    static let tkPaddingXS: CGFloat = 4
    static let tkPaddingSM: CGFloat = 8
    static let tkPaddingMD: CGFloat = 12
    static let tkPaddingLG: CGFloat = 16
    static let tkPaddingXL: CGFloat = 24
    static let tkPaddingXXL: CGFloat = 32
    
    // MARK: - Corner Radius
    static let tkRadiusSM: CGFloat = 8
    static let tkRadiusMD: CGFloat = 12
    static let tkRadiusLG: CGFloat = 16
    static let tkRadiusXL: CGFloat = 24
    static let tkRadiusPopover: CGFloat = 32
    
    // MARK: - Border Width
    static let tkBorderThin: CGFloat = 1
    static let tkBorderMedium: CGFloat = 1.6
    static let tkBorderThick: CGFloat = 2
}

// MARK: - Helper Extensions
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Date Extensions (existing)
extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
} 