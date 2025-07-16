import Foundation
import SwiftUI
import CoreLocation
import Combine

class IssueViewModel: ObservableObject {
    @Published var issues: [Issue] = []
    @Published var selectedCategory: IssueCategory?
    @Published var showingHeatmap = false
    @Published var selectedIssue: Issue?
    @Published var showingReportSheet = false
    @Published var showingIssueDetail = false
    
    private let storageService = LocalStorageService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadIssues()
    }
    
    // MARK: - Data Operations
    
    func loadIssues() {
        issues = storageService.loadIssues()
    }
    
    func addIssue(location: CLLocationCoordinate2D, 
                  category: IssueCategory, 
                  description: String, 
                  photo: UIImage) {
        
        guard let photoFilename = storageService.savePhoto(photo) else {
            print("Failed to save photo")
            return
        }
        
        let newIssue = Issue(
            latitude: location.latitude,
            longitude: location.longitude,
            category: category,
            description: description,
            photoPath: photoFilename
        )
        
        storageService.addIssue(newIssue)
        loadIssues()
    }
    
    func deleteIssue(_ issue: Issue) {
        storageService.deleteIssue(withId: issue.id)
        storageService.deletePhoto(filename: issue.photoPath)
        loadIssues()
    }
    
    // MARK: - Filtering
    
    var filteredIssues: [Issue] {
        if let selectedCategory = selectedCategory {
            return issues.filter { $0.category == selectedCategory }
        }
        return issues
    }
    
    func toggleCategoryFilter(_ category: IssueCategory) {
        if selectedCategory == category {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
    
    // MARK: - UI State
    
    func selectIssue(_ issue: Issue) {
        selectedIssue = issue
        showingIssueDetail = true
    }
    
    func toggleHeatmap() {
        showingHeatmap.toggle()
    }
    
    func openReportSheet() {
        showingReportSheet = true
    }
    
    // MARK: - Photo Loading
    
    func loadPhoto(for issue: Issue) -> UIImage? {
        return storageService.loadPhoto(filename: issue.photoPath)
    }
} 