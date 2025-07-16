import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

// MARK: - Color Extensions
extension Color {
    static let indigo = Color(red: 0.39, green: 0.40, blue: 0.95) // #6366F1
    static let primaryRed = Color(red: 0.86, green: 0.15, blue: 0.15) // #DC2626
    static let primaryOrange = Color(red: 0.85, green: 0.47, blue: 0.04) // #D97706
    static let primaryGreen = Color(red: 0.09, green: 0.64, blue: 0.29) // #16A34A
} 