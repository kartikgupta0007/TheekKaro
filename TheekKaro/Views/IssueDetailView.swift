import SwiftUI
import MapKit

struct IssueDetailView: View {
    let issue: Issue
    @ObservedObject var viewModel: IssueViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Photo Section
                    PhotoSection(issue: issue, viewModel: viewModel)
                    
                    // Issue Information
                    IssueInfoSection(issue: issue)
                    
                    // Location Map
                    LocationMapSection(issue: issue)
                    
                    // Actions
                    ActionsSection(issue: issue, viewModel: viewModel, dismiss: dismiss)
                }
                .padding()
            }
            .navigationTitle("Issue Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct PhotoSection: View {
    let issue: Issue
    @ObservedObject var viewModel: IssueViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Photo")
                .font(.headline)
                .foregroundColor(.primary)
            
            if let image = viewModel.loadPhoto(for: issue) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 250)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 4)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .overlay(
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("Photo not available")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    )
            }
        }
    }
}

struct IssueInfoSection: View {
    let issue: Issue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Information")
                .font(.headline)
                .foregroundColor(.primary)
            
            // Category
            HStack {
                Label {
                    Text(issue.category.displayName)
                        .font(.body)
                        .fontWeight(.medium)
                } icon: {
                    Image(systemName: issue.category.systemImageName)
                        .foregroundColor(issue.category.color)
                }
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(issue.category.color.opacity(0.1))
            )
            
            // Timestamp
            HStack {
                Label {
                    Text(issue.timestamp, style: .date)
                        .font(.body)
                        .fontWeight(.medium)
                    Text(issue.timestamp, style: .time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } icon: {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
            )
            
            // Description
            if !issue.description.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Description", systemImage: "text.alignleft")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(issue.description)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                )
            }
        }
    }
}

struct LocationMapSection: View {
    let issue: Issue
    @State private var cameraPosition: MapCameraPosition
    
    init(issue: Issue) {
        self.issue = issue
        self._cameraPosition = State(initialValue: .region(MKCoordinateRegion(
            center: issue.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Location")
                .font(.headline)
                .foregroundColor(.primary)
            
            Map(position: $cameraPosition) {
                Annotation(issue.category.displayName, coordinate: issue.coordinate) {
                    ZStack {
                        Circle()
                            .fill(issue.category.color)
                            .frame(width: 24, height: 24)
                        
                        Image(systemName: issue.category.systemImageName)
                            .foregroundColor(.white)
                            .font(.system(size: 10, weight: .bold))
                    }
                }
            }
            .frame(height: 150)
            .cornerRadius(12)
            .disabled(true)
            
            // Coordinates
            Text("Lat: \(issue.latitude, specifier: "%.6f"), Lon: \(issue.longitude, specifier: "%.6f")")
                .font(.caption)
                .foregroundColor(.secondary)
                .monospaced()
        }
    }
}

struct ActionsSection: View {
    let issue: Issue
    @ObservedObject var viewModel: IssueViewModel
    let dismiss: DismissAction
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Actions")
                .font(.headline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Delete Button
            Button(action: {
                showingDeleteAlert = true
            }) {
                HStack {
                    Image(systemName: "trash")
                    Text("Delete Issue")
                }
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.red.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                )
            }
        }
        .alert("Delete Issue", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteIssue(issue)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this issue? This action cannot be undone.")
        }
    }
}

#Preview {
    IssueDetailView(
        issue: Issue(
            latitude: 37.7749,
            longitude: -122.4194,
            category: .pothole,
            description: "Large pothole near the bus stop causing traffic issues",
            photoPath: "sample.jpg"
        ),
        viewModel: IssueViewModel()
    )
} 