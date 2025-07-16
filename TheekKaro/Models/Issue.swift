import Foundation
import CoreLocation

struct Issue: Identifiable, Codable {
    let id: String
    let latitude: Double
    let longitude: Double
    let category: IssueCategory
    let description: String
    let timestamp: Date
    let photoPath: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(id: String = UUID().uuidString,
         latitude: Double,
         longitude: Double,
         category: IssueCategory,
         description: String,
         timestamp: Date = Date(),
         photoPath: String) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
        self.description = description
        self.timestamp = timestamp
        self.photoPath = photoPath
    }
} 