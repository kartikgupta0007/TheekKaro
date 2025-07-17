import SwiftUI

// MARK: - Section Header Component
struct TKSectionHeader: View {
    let stepNumber: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: .tkPaddingSM) {
            Text("\(stepNumber) \(title)")
                .font(.tkSectionHeader)
                .foregroundColor(.tkTextPrimary)
            
            Text(description)
                .font(.tkBodySmall)
                .foregroundColor(.tkTextSecondary)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Photo Upload Grid Component
struct TKPhotoUploadGrid: View {
    @Binding var capturedImages: [UIImage]
    @Binding var showingImagePicker: Bool
    let maxImages: Int = 6
    
    var body: some View {
        VStack(spacing: .tkPaddingLG) {
            // Photo Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                ForEach(0..<maxImages, id: \.self) { index in
                    if index < capturedImages.count {
                        TKPhotoFrame(image: capturedImages[index], onDelete: {
                            capturedImages.remove(at: index)
                        })
                    } else if index == capturedImages.count && capturedImages.count < maxImages {
                        TKPhotoFrameAdd {
                            showingImagePicker = true
                        }
                    } else {
                        TKPhotoFrameDisabled()
                    }
                }
            }
            
            // Caption
            HStack {
                Text("You can add upto \(maxImages) photos")
                    .font(.tkCaption)
                    .foregroundColor(.tkTextSecondary)
                Spacer()
            }
        }
    }
}

// MARK: - Photo Frame Components
struct TKPhotoFrameAdd: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: .tkPaddingSM) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.tkPrimary)
                
                Image(systemName: "camera.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.tkPrimary)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: .tkRadiusSM)
                    .stroke(Color.tkPrimary, style: StrokeStyle(lineWidth: .tkBorderMedium, dash: [8, 4]))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TKPhotoFrame: View {
    let image: UIImage
    let onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 80)
                .clipped()
                .cornerRadius(.tkRadiusSM)
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.tkSurface)
                    .background(Color.tkTextPrimary, in: Circle())
            }
            .offset(x: 8, y: -8)
        }
    }
}

struct TKPhotoFrameDisabled: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .tkRadiusSM)
            .fill(Color.clear)
            .frame(height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: .tkRadiusSM)
                    .stroke(Color.tkBorderDashed, style: StrokeStyle(lineWidth: .tkBorderMedium, dash: [8, 4]))
            )
            .overlay(
                Image(systemName: "photo")
                    .font(.system(size: 24))
                    .foregroundColor(.tkBorderDashed)
            )
    }
}

// MARK: - Category Chip Components
struct TKCategoryChipGrid: View {
    @Binding var selectedCategories: Set<IssueCategory>
    let categories: [IssueCategory] = IssueCategory.allCases
    let allowMultiple: Bool
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: .tkPaddingLG) {
            ForEach(categories, id: \.self) { category in
                TKCategoryChip(
                    category: category,
                    isSelected: selectedCategories.contains(category)
                ) {
                    if allowMultiple {
                        if selectedCategories.contains(category) {
                            selectedCategories.remove(category)
                        } else {
                            selectedCategories.insert(category)
                        }
                    } else {
                        selectedCategories = [category]
                    }
                }
            }
        }
    }
}

struct TKCategoryChip: View {
    let category: IssueCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: .tkPaddingSM) {
                Image(systemName: category.systemImageName)
                    .font(.system(size: 14, weight: .medium))
                
                Text(category.displayName)
                    .font(.tkChip)
            }
            .foregroundColor(isSelected ? .tkSurfaceVariant : .tkTextChip)
            .padding(.horizontal, .tkPaddingMD)
            .padding(.vertical, .tkPaddingSM)
            .background(
                isSelected ? Color.tkPrimary : Color.tkChipBackground,
                in: RoundedRectangle(cornerRadius: .tkRadiusSM)
            )
            .overlay(
                RoundedRectangle(cornerRadius: .tkRadiusSM)
                    .stroke(Color.tkPrimary, lineWidth: isSelected ? 0 : .tkBorderThin)
            )
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

// MARK: - Text Input Components
struct TKTextInputArea: View {
    @Binding var text: String
    let placeholder: String
    let minHeight: CGFloat = 121
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.tkBodySmall)
                    .foregroundColor(.tkTextPlaceholder)
                    .padding(.tkPaddingMD)
            }
            
            TextEditor(text: $text)
                .font(.tkBodySmall)
                .foregroundColor(.tkTextPrimary)
                .padding(.tkPaddingSM)
                .background(Color.tkSurface)
                .cornerRadius(.tkRadiusSM)
                .overlay(
                    RoundedRectangle(cornerRadius: .tkRadiusSM)
                        .stroke(Color(.systemGray5), lineWidth: .tkBorderThin)
                )
        }
        .frame(minHeight: minHeight)
    }
}

// MARK: - Button Components
struct TKPrimaryButton: View {
    let title: String
    let action: () -> Void
    let isEnabled: Bool
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.tkButton)
                .foregroundColor(.tkTextButton)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    isEnabled ? .tkButtonPrimary : Color.gray.opacity(0.3),
                    in: RoundedRectangle(cornerRadius: .tkRadiusMD)
                )
        }
        .disabled(!isEnabled)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

struct TKSecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.tkButtonSecondary)
                .foregroundColor(.tkTextAccent)
                .frame(height: 44)
                .padding(.horizontal, .tkPaddingXL)
        }
    }
}

// MARK: - Location Tag Component
struct TKLocationTag: View {
    let location: String
    
    var body: some View {
        HStack(spacing: .tkPaddingXS) {
            Text(location)
                .font(.tkLocationTag)
                .foregroundColor(.tkTextAccent)
                .lineLimit(1)
            
            Image(systemName: "chevron.down")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.tkTextAccent)
        }
    }
}

// MARK: - Main Container Component
struct TKPopoverContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(Color.tkSecondaryBackground)
        .cornerRadius(.tkRadiusPopover, corners: [.topLeft, .topRight])
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

// MARK: - Helper for Corner Radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
} 