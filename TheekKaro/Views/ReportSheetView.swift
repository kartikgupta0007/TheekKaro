import SwiftUI
import CoreLocation

struct ReportSheetView: View {
    @ObservedObject var viewModel: IssueViewModel
    let userLocation: CLLocationCoordinate2D?
    
    @State private var selectedCategory: IssueCategory = .pothole
    @State private var description: String = ""
    @State private var showingImagePicker = false
    @State private var capturedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Photo Section
                PhotoCaptureSection(
                    capturedImage: $capturedImage,
                    showingImagePicker: $showingImagePicker
                )
                
                // Category Selection
                CategorySelectionSection(selectedCategory: $selectedCategory)
                
                // Description Input
                DescriptionSection(description: $description)
                
                Spacer()
                
                // Save Button
                SaveButton(
                    isEnabled: capturedImage != nil && userLocation != nil,
                    action: saveIssue
                )
            }
            .padding()
            .navigationTitle("Report Issue")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $capturedImage)
        }
    }
    
    private func saveIssue() {
        guard let image = capturedImage,
              let location = userLocation else {
            return
        }
        
        viewModel.addIssue(
            location: location,
            category: selectedCategory,
            description: description,
            photo: image
        )
        
        dismiss()
    }
}

// MARK: - Supporting Views

struct PhotoCaptureSection: View {
    @Binding var capturedImage: UIImage?
    @Binding var showingImagePicker: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Take a Photo")
                .font(.headline)
                .foregroundColor(.primary)
            
            Button(action: {
                showingImagePicker = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                        )
                    
                    if let image = capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(12)
                    } else {
                        VStack {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("Tap to take photo")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct CategorySelectionSection: View {
    @Binding var selectedCategory: IssueCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Category")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                ForEach(IssueCategory.allCases, id: \.self) { category in
                    CategorySelectionCard(
                        category: category,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
        }
    }
}

struct CategorySelectionCard: View {
    let category: IssueCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                Image(systemName: category.systemImageName)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : category.color)
                
                Text(category.displayName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? category.color : Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(category.color, lineWidth: isSelected ? 0 : 1)
            )
        }
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

struct DescriptionSection: View {
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Description (Optional)")
                .font(.headline)
                .foregroundColor(.primary)
            
            TextField("Add details about the issue...", text: $description, axis: .vertical)
                .lineLimit(3...6)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                )
        }
    }
}

struct SaveButton: View {
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Save Issue")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isEnabled ? Color.indigo : Color.gray)
                )
        }
        .disabled(!isEnabled)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

// MARK: - Image Picker

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    ReportSheetView(
        viewModel: IssueViewModel(),
        userLocation: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    )
} 