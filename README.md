# Civic Transparency POC - TheekKaro 🏙️

A SwiftUI-based iOS app for citizen-driven civic issue reporting, built as a Proof of Concept for transparent governance.

## Features ✨

### Core Functionality
- 📍 **Interactive Map**: View your location and all reported issues
- 📸 **Issue Reporting**: Capture photos with GPS tagging
- 🏷️ **Category System**: Pothole, Streetlight, Garbage, Water Leak, Other
- 🗂️ **Category Filtering**: Toggle visibility by issue type
- 📊 **Heatmap Toggle**: Visual density overlay (UI ready)
- 📱 **Issue Details**: Full issue information with photo and location
- 🗑️ **Issue Management**: Delete functionality with confirmation

### Technical Features
- 💾 **Local Storage**: JSON-based persistence with photo management
- 📍 **GPS Integration**: CoreLocation with proper permissions
- 🎨 **Modern UI**: SwiftUI with Material Design elements
- 🌓 **Dark Mode**: Automatic light/dark theme support
- ♿ **Accessibility**: VoiceOver ready with proper labels

## Project Structure 📁

```
TheekKaro/
├── Models/
│   ├── Issue.swift              # Core issue data model
│   └── IssueCategory.swift      # Category enum with colors
├── Services/
│   ├── LocationManager.swift    # GPS and location services
│   └── LocalStorageService.swift # JSON persistence & photo storage
├── ViewModels/
│   └── IssueViewModel.swift     # Business logic & state management
├── Views/
│   ├── MapHomeView.swift        # Main map interface
│   ├── ReportSheetView.swift    # Issue reporting form
│   └── IssueDetailView.swift    # Issue detail viewer
├── Utilities/
│   └── Extensions.swift         # Date & Color extensions
└── Info.plist                  # Camera & location permissions
```

## Category System 🏷️

| Category    | Color  | Icon | Use Case |
|-------------|--------|------|----------|
| Pothole     | Red    | ⚠️   | Road damage, traffic hazards |
| Streetlight | Orange | 💡   | Broken/missing street lighting |
| Garbage     | Green  | 🗑️   | Waste management issues |
| Water Leak  | Blue   | 💧   | Plumbing, water infrastructure |
| Other       | Purple | ❓   | Miscellaneous civic issues |

## Key Components 🧩

### Data Flow
1. **LocationManager** → GPS coordinates
2. **Camera** → UIImagePickerController → Photo capture
3. **LocalStorageService** → JSON + FileManager → Data persistence
4. **IssueViewModel** → Combine publishers → UI updates

### UI Architecture
- **MapHomeView**: Main interface with floating controls
- **FAB (Floating Action Button)**: Primary issue reporting trigger
- **Category Filters**: Horizontal scroll with selection state
- **Bottom Sheets**: Native iOS presentation for forms and details

## Requirements ✅

- iOS 17.0+
- Xcode 15.0+
- Camera access permission
- Location access permission
- Device storage for photos and data

## Getting Started 🚀

1. **Clone & Open**
   ```bash
   git clone <repository>
   cd TheekKaro
   open TheekKaro.xcodeproj
   ```

2. **Run the App**
   - Select target device/simulator
   - Build and run (⌘+R)
   - Grant location and camera permissions when prompted

3. **Test Core Flow**
   - Tap the blue "+" FAB
   - Take a photo of an issue
   - Select category and add description
   - Save and see the pin appear on map
   - Tap pin to view details

## Data Storage 💾

### Local Persistence
- **Issues**: Stored as JSON in Documents directory
- **Photos**: JPEG files in Documents/photos/ folder
- **Location**: App sandbox only (privacy compliant)

### Data Model
```json
{
  "id": "UUID",
  "latitude": 37.7749,
  "longitude": -122.4194,
  "category": "pothole",
  "description": "Large pothole near bus stop",
  "timestamp": "2025-07-16T10:00:00Z",
  "photoPath": "uuid.jpg"
}
```

## Performance Targets 🎯

| Metric | Target | Status |
|--------|--------|--------|
| Map FPS | ≥30fps | ✅ Optimized |
| Heatmap Toggle | ≤200ms | ✅ Smooth |
| Issue Creation | <30s | ✅ Fast |
| Crash Rate | ≥99% | ✅ Stable |

## Future Enhancements 🔮

- 🗂️ **Heatmap Implementation**: Actual density visualization
- 📶 **Offline Mode**: Better offline issue creation
- 🔄 **Data Export**: Share issues as CSV/JSON
- 📊 **Analytics**: Usage and issue type statistics
- 🌐 **Backend Integration**: Server sync capabilities

## Design System 🎨

### Colors
- **Primary**: Indigo 500 (#6366F1)
- **Categories**: Red, Orange, Green, Blue, Purple
- **Background**: System adaptive (light/dark)
- **Surfaces**: Ultra-thin material with blur

### Typography
- **Headlines**: SF Pro Rounded, Bold
- **Body**: SF Pro, Medium
- **Captions**: SF Pro, Regular

### Animations
- **Spring**: Response 0.3, Damping 0.7
- **Ease**: 150-200ms for state changes
- **Micro-interactions**: Scale, fade, slide

---

**Built with ❤️ by Kartik Gupta**  
*Civic Transparency POC - July 2025* 