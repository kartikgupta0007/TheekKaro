import SwiftUI
import CoreLocation

struct EnhancedReportSheetView: View {
    @ObservedObject var viewModel: IssueViewModel
    let userLocation: CLLocationCoordinate2D?
    
    // Form state
    @State private var capturedImages: [UIImage] = []
    @State private var selectedCategories: Set<IssueCategory> = []
    @State private var description: String = ""
    @State private var showingImagePicker = false
    
    @Environment(\.dismiss) private var dismiss
    
    // Computed properties
    private var isFormValid: Bool {
        !capturedImages.isEmpty && !selectedCategories.isEmpty
    }
    
    private var locationString: String {
        if userLocation != nil {
            return "Current Location" // In real app, you'd reverse geocode this
        }
        return "Unknown Location"
    }
    
    var body: some View {
        TKPopoverContainer {
            VStack(spacing: 0) {
                // Header
                headerSection
                
                // Scrollable Content
                ScrollView {
                    VStack(spacing: .tkPaddingXXL) {
                        // Step 1: Photo Capture
                        photoCaptureStep
                        
                        // Step 2: Category Selection
                        categorySelectionStep
                        
                        // Step 3: Description
                        descriptionStep
                    }
                    .padding(.horizontal, .tkPaddingXXL)
                    .padding(.bottom, .tkPaddingXXL)
                }
                
                // Footer with buttons
                footerSection
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            EnhancedImagePicker(image: Binding(
                get: { nil },
                set: { newImage in
                    if let image = newImage {
                        capturedImages.append(image)
                    }
                }
            ))
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: .tkPaddingLG) {
            // Main Title
            HStack {
                Text("You saw it, you felt it.\nNow share it.")
                    .font(.tkTitle)
                    .foregroundColor(.tkTextPrimary)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            // Location Tag
            HStack {
                TKLocationTag(location: locationString)
                Spacer()
            }
        }
        .padding(.horizontal, .tkPaddingXXL)
        .padding(.top, .tkPaddingXXL)
        .padding(.bottom, .tkPaddingLG)
    }
    
    // MARK: - Step 1: Photo Capture
    private var photoCaptureStep: some View {
        VStack(spacing: .tkPaddingLG) {
            TKSectionHeader(
                stepNumber: "❶",
                title: "Capture the situation",
                description: "Photos lock in GPS data, so everyone sees where it happened"
            )
            
            TKPhotoUploadGrid(
                capturedImages: $capturedImages,
                showingImagePicker: $showingImagePicker
            )
        }
    }
    
    // MARK: - Step 2: Category Selection
    private var categorySelectionStep: some View {
        VStack(spacing: .tkPaddingLG) {
            TKSectionHeader(
                stepNumber: "❷",
                title: "What's wrong here?",
                description: "Choose as many tags as you need, every detail counts"
            )
            
            TKCategoryChipGrid(
                selectedCategories: $selectedCategories,
                allowMultiple: true
            )
        }
    }
    
    // MARK: - Step 3: Description
    private var descriptionStep: some View {
        VStack(spacing: .tkPaddingLG) {
            TKSectionHeader(
                stepNumber: "❸",
                title: "Tell people more",
                description: "Your words help fix what your have experienced"
            )
            
            TKTextInputArea(
                text: $description,
                placeholder: "I felt worried when I saw…"
            )
        }
    }
    
    // MARK: - Footer Section
    private var footerSection: some View {
        VStack(spacing: .tkPaddingMD) {
            TKPrimaryButton(
                title: "Share Your Find",
                action: saveIssue,
                isEnabled: isFormValid
            )
            
            TKSecondaryButton(
                title: "Maybe Later",
                action: { dismiss() }
            )
        }
        .padding(.horizontal, .tkPaddingXXL)
        .padding(.vertical, .tkPaddingLG)
    }
    
    // MARK: - Actions
    private func saveIssue() {
        guard let location = userLocation,
              !capturedImages.isEmpty,
              let selectedCategory = selectedCategories.first else {
            return
        }
        
        // For now, we'll use the first image and first category
        // In a real implementation, you might want to handle multiple images/categories
        viewModel.addIssue(
            location: location,
            category: selectedCategory,
            description: description.isEmpty ? "No description provided" : description,
            photo: capturedImages.first!
        )
        
        dismiss()
    }
}

// MARK: - Enhanced Image Picker
struct EnhancedImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // Check if camera is available, fallback to photo library if not
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.cameraDevice = .rear
            picker.cameraCaptureMode = .photo
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.allowsEditing = false
        picker.mediaTypes = ["public.image"]
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: EnhancedImagePicker
        
        init(_ parent: EnhancedImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    EnhancedReportSheetView(
        viewModel: IssueViewModel(),
        userLocation: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    )
} 