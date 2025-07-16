# Technical Architecture - TheekKaro

## Architecture Overview
TheekKaro follows a **Model-View-ViewModel (MVVM)** architecture pattern using SwiftUI and Combine for reactive programming. The app prioritizes local data storage and offline-first functionality.

## System Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   SwiftUI Views │────│   ViewModels    │────│   Services      │
│   (UI Layer)    │    │  (Logic Layer)  │    │ (Data Layer)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │                        │
                              │                        │
                    ┌─────────────────┐    ┌─────────────────┐
                    │     Models      │    │ Core Location   │
                    │  (Data Models)  │    │   & Camera      │
                    └─────────────────┘    └─────────────────┘
```

## Project Structure

### 📁 **Models/**
- **`Issue.swift`**: Core data model for civic issues
  - Identifiable, Codable for JSON persistence
  - GPS coordinates, category, description, timestamp, photo path
  - Computed property for CLLocationCoordinate2D conversion
  
- **`IssueCategory.swift`**: Enum defining issue types
  - 5 categories: Pothole, Streetlight, Garbage, Water Leak, Other
  - Associated colors, SF Symbols, and display names
  - Color-coded for visual categorization

### 📁 **Views/**
- **`MapHomeView.swift`**: Main interface (202 lines)
  - Full-screen MapKit integration with user location
  - Issue pins with category-specific styling
  - Category filter chips with horizontal scroll
  - Floating Action Button (FAB) for new reports
  - Heatmap toggle control

- **`ReportSheetView.swift`**: Issue reporting form (314 lines)
  - Camera/photo library integration
  - Category selection grid
  - Description input field
  - Form validation and save logic

- **`IssueDetailView.swift`**: Issue detail viewer (252 lines)
  - Photo display with fallback handling
  - Issue information cards
  - Mini-map for location context
  - Delete functionality with confirmation

### 📁 **ViewModels/**
- **`IssueViewModel.swift`**: Central business logic (92 lines)
  - ObservableObject with @Published properties
  - CRUD operations for issues
  - Category filtering logic
  - UI state management (sheet presentation, selection)
  - Photo loading coordination

### 📁 **Services/**
- **`LocalStorageService.swift`**: Data persistence layer (82 lines)
  - JSON encoding/decoding for issues
  - Photo storage in Documents/photos/
  - CRUD operations with error handling
  - Directory management and cleanup

- **`LocationManager.swift`**: GPS services (58 lines)
  - CLLocationManager wrapper
  - Permission request handling
  - Real-time location updates
  - Authorization status monitoring

### 📁 **Utilities/**
- **`Extensions.swift`**: Helper extensions (26 lines)
  - Date formatting utilities
  - Custom color definitions
  - Reusable functionality

## Data Flow Architecture

### 1. **Issue Creation Flow**
```
User Tap FAB → ReportSheetView → Camera/Library → 
Category Selection → Description Input → Save Action →
IssueViewModel.addIssue() → LocalStorageService.savePhoto() →
LocalStorageService.addIssue() → JSON Persistence → UI Update
```

### 2. **Map Display Flow**
```
LocationManager → GPS Coordinates → MapHomeView → 
IssueViewModel.filteredIssues → Map Annotations → 
Pin Rendering with Category Colors
```

### 3. **Data Persistence Flow**
```
Issues Array → JSON Encoder → Documents/issues.json
Photos → JPEG Compression → Documents/photos/[UUID].jpg
```

## Key Technical Decisions

### **1. Local Storage Strategy**
- **Choice**: JSON + FileManager over Core Data
- **Rationale**: Simpler implementation, no migration complexity, easy data export
- **Trade-offs**: Less query optimization, manual relationship management

### **2. Photo Storage**
- **Choice**: Local file system with JPEG compression (0.8 quality)
- **Rationale**: Privacy-first, no cloud dependencies, faster access
- **Implementation**: UUID-based filenames, automatic cleanup on deletion

### **3. Location Services**
- **Choice**: CoreLocation with "When In Use" permissions
- **Rationale**: Minimal privacy impact, sufficient for reporting use case
- **Implementation**: Request on first use, graceful degradation if denied

### **4. UI Framework**
- **Choice**: SwiftUI with iOS 17+ target
- **Rationale**: Modern declarative UI, better animation support, reduced code
- **Trade-offs**: iOS 17+ requirement, some UIKit bridging needed

## Performance Optimizations

### **Map Rendering**
- Efficient annotation clustering for large datasets
- Category-based filtering to reduce visible pins
- Viewport-based loading (future enhancement)

### **Photo Handling**
- JPEG compression to balance quality vs storage
- Lazy loading of thumbnails in lists
- Background queue processing for saves

### **Memory Management**
- Combine publishers with proper cancellation
- Weak references in closures
- Efficient SwiftUI state management

## Security & Privacy

### **Data Protection**
- All data stored in app sandbox (iOS protection)
- No network requests or external data transmission
- Camera/location permissions with user-friendly descriptions

### **Permission Handling**
```swift
// Info.plist configurations
NSCameraUsageDescription: "TheekKaro needs camera access to take photos..."
NSLocationWhenInUseUsageDescription: "TheekKaro needs location access to accurately tag..."
```

## Platform Requirements

### **Minimum Requirements**
- iOS 17.0+
- Xcode 15.0+
- Swift 5.0
- Camera capability (graceful degradation to photo library)

### **Device Compatibility**
- iPhone: Full functionality
- iPad: Supported (universal app)
- Simulator: Limited (no camera, location simulation)

## Build Configuration

### **Bundle Settings**
- Bundle ID: `Carrick.TheekKaro`
- Version: 1.0.1
- Target: iPhone/iPad universal
- Deployment: iOS 17.0+

### **Code Signing**
- Development Team: MQ3K8ZFKDV
- Automatic signing enabled
- Provisioning profile managed by Xcode

## Testing Strategy

### **Unit Tests** (`TheekKaroTests/`)
- Model serialization/deserialization
- Business logic validation
- Storage service operations

### **UI Tests** (`TheekKaroUITests/`)
- Critical user flows
- Permission request handling
- Cross-device compatibility

## Future Technical Enhancements

### **Phase 2 Architecture**
- Backend API integration
- Real-time sync capabilities
- Offline queue management
- Push notification support

### **Performance Improvements**
- Core Data migration for complex queries
- Image caching and optimization
- Background processing for large datasets

### **Platform Expansion**
- watchOS companion app
- macOS Catalyst support
- Widget extensions

---
*Technical Architecture v1.0 | Updated July 2025* 