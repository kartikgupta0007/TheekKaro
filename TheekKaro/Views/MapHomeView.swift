import SwiftUI
import MapKit

struct MapHomeView: View {
    @StateObject private var issueViewModel = IssueViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Main Map View
            Map(position: $cameraPosition) {
                // User location marker
                if let userLocation = locationManager.userLocation {
                    Annotation("Your Location", coordinate: userLocation) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                            )
                    }
                }
                
                // Issue pins
                ForEach(issueViewModel.filteredIssues) { issue in
                    Annotation(issue.category.displayName, coordinate: issue.coordinate) {
                        IssuePin(issue: issue)
                            .onTapGesture {
                                issueViewModel.selectIssue(issue)
                            }
                    }
                }
            }
            .mapStyle(.standard)
            .onAppear {
                locationManager.requestLocation()
                if let userLocation = locationManager.userLocation {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))
                }
            }
            .onReceive(locationManager.$userLocation) { newLocation in
                if let location = newLocation {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: location,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))
                }
            }
            
            // Top controls overlay
            VStack {
                HStack {
                    CategoryFilterView(viewModel: issueViewModel)
                    Spacer()
                    HeatmapToggleButton(viewModel: issueViewModel)
                }
                .padding()
                Spacer()
            }
            
            // Report FAB
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ReportFAB {
                        issueViewModel.openReportSheet()
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .sheet(isPresented: $issueViewModel.showingReportSheet) {
            EnhancedReportSheetView(
                viewModel: issueViewModel,
                userLocation: locationManager.userLocation
            )
        }
        .sheet(isPresented: $issueViewModel.showingIssueDetail) {
            if let selectedIssue = issueViewModel.selectedIssue {
                IssueDetailView(issue: selectedIssue, viewModel: issueViewModel)
            }
        }
    }
}

// MARK: - Supporting Views

struct IssuePin: View {
    let issue: Issue
    
    var body: some View {
        ZStack {
            Circle()
                .fill(issue.category.color)
                .frame(width: 32, height: 32)
                .shadow(radius: 4)
            
            Image(systemName: issue.category.systemImageName)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
        }
    }
}

struct CategoryFilterView: View {
    @ObservedObject var viewModel: IssueViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(IssueCategory.allCases, id: \.self) { category in
                    CategoryFilterChip(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.toggleCategoryFilter(category)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

struct CategoryFilterChip: View {
    let category: IssueCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: category.systemImageName)
                    .font(.system(size: 12))
                Text(category.displayName)
                    .font(.tkCaption)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                isSelected ? Color.tkPrimary : Color.clear,
                in: Capsule()
            )
            .foregroundColor(isSelected ? Color.tkTextButton : Color.tkTextPrimary)
            .overlay(
                Capsule()
                    .stroke(Color.tkPrimary, lineWidth: isSelected ? 0 : 1)
            )
        }
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

struct HeatmapToggleButton: View {
    @ObservedObject var viewModel: IssueViewModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleHeatmap()
        }) {
            Image(systemName: viewModel.showingHeatmap ? "map.fill" : "map")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .frame(width: 40, height: 40)
                .background(.ultraThinMaterial, in: Circle())
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.showingHeatmap)
    }
}

struct ReportFAB: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.tkTextButton)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(Color.tkPrimary)
                        .shadow(color: Color.tkPrimary.opacity(0.3), radius: 8, y: 4)
                )
        }
        .scaleEffect(1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: false)
    }
}

#Preview {
    MapHomeView()
} 