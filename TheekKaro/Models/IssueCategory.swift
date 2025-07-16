import SwiftUI

enum IssueCategory: String, CaseIterable, Codable {
    case pothole = "pothole"
    case streetlight = "streetlight" 
    case garbage = "garbage"
    case waterLeak = "waterLeak"
    case other = "other"
    
    var displayName: String {
        switch self {
        case .pothole:
            return "Pothole"
        case .streetlight:
            return "Streetlight"
        case .garbage:
            return "Garbage"
        case .waterLeak:
            return "Water Leak"
        case .other:
            return "Other"
        }
    }
    
    var color: Color {
        switch self {
        case .pothole:
            return Color.red // Red 600 (#DC2626)
        case .streetlight:
            return Color.orange // Yellow 600 (#D97706)
        case .garbage:
            return Color.green // Green 600 (#16A34A)
        case .waterLeak:
            return Color.blue
        case .other:
            return Color.purple
        }
    }
    
    var systemImageName: String {
        switch self {
        case .pothole:
            return "exclamationmark.triangle.fill"
        case .streetlight:
            return "lightbulb.fill"
        case .garbage:
            return "trash.fill"
        case .waterLeak:
            return "drop.fill"
        case .other:
            return "questionmark.circle.fill"
        }
    }
} 