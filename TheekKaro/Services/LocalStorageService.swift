import Foundation
import UIKit

class LocalStorageService: ObservableObject {
    private let documentsDirectory: URL
    private let issuesFileName = "issues.json"
    private let photosDirectory: URL
    
    init() {
        documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        photosDirectory = documentsDirectory.appendingPathComponent("photos")
        
        // Create photos directory if it doesn't exist
        try? FileManager.default.createDirectory(at: photosDirectory, withIntermediateDirectories: true)
    }
    
    private var issuesFileURL: URL {
        documentsDirectory.appendingPathComponent(issuesFileName)
    }
    
    // MARK: - Issue CRUD Operations
    
    func saveIssues(_ issues: [Issue]) {
        do {
            let data = try JSONEncoder().encode(issues)
            try data.write(to: issuesFileURL)
        } catch {
            print("Failed to save issues: \(error)")
        }
    }
    
    func loadIssues() -> [Issue] {
        do {
            let data = try Data(contentsOf: issuesFileURL)
            return try JSONDecoder().decode([Issue].self, from: data)
        } catch {
            print("Failed to load issues: \(error)")
            return []
        }
    }
    
    func addIssue(_ issue: Issue) {
        var issues = loadIssues()
        issues.append(issue)
        saveIssues(issues)
    }
    
    func deleteIssue(withId id: String) {
        var issues = loadIssues()
        issues.removeAll { $0.id == id }
        saveIssues(issues)
    }
    
    // MARK: - Photo Operations
    
    func savePhoto(_ image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        let filename = "\(UUID().uuidString).jpg"
        let fileURL = photosDirectory.appendingPathComponent(filename)
        
        do {
            try imageData.write(to: fileURL)
            return filename
        } catch {
            print("Failed to save photo: \(error)")
            return nil
        }
    }
    
    func loadPhoto(filename: String) -> UIImage? {
        let fileURL = photosDirectory.appendingPathComponent(filename)
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func deletePhoto(filename: String) {
        let fileURL = photosDirectory.appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: fileURL)
    }
} 