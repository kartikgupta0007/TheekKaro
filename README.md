# TheekKaro - Civic Issue Reporting 🏙️

A beautiful, user-friendly iOS app for reporting civic issues with GPS-tagged photos and community engagement.

## 🚀 Latest Update - v1.0.2

**Enhanced Add Issue Flow** - Replaced basic form with polished 6-step guided experience:
- **Modern Design System** - Consistent colors, typography, and spacing
- **Multi-Step Flow** - Photo capture → Category selection → Description → Review
- **Reusable Components** - Professional UI component library
- **Better UX** - Guided, intuitive issue reporting process

## Core Features ✨

### 📱 Issue Reporting
- **6-Step Guided Flow**: Beautiful multi-step form with clear progression
- **Photo Capture**: Camera integration with GPS tagging (up to 6 photos)
- **Smart Categories**: Roads, Lighting, Waste, Water, Other with visual chips
- **Rich Descriptions**: Easy text input with helpful prompts

### 🗺️ Map & Discovery
- **Interactive Map**: View all reported issues on live map
- **Category Filters**: Toggle visibility by issue type
- **Issue Details**: Full issue view with photos and location
- **Current Location**: GPS integration with precise positioning

### 🎨 Design System
- **Consistent Colors**: Professional green/brown palette 
- **Modern Typography**: Clear hierarchy with proper sizing
- **Reusable Components**: Buttons, chips, inputs, photo grids
- **Responsive Layout**: Optimized for all iOS device sizes

## Quick Start 🚀

1. **Clone & Run**
   ```bash
   git clone <repository>
   cd TheekKaro
   open TheekKaro.xcodeproj
   ```

2. **Test the New Flow**
   - Tap the green "+" button
   - Follow the 6-step guided process
   - Take photos → Select categories → Add description
   - See your issue appear on the map

## Project Structure 📁

```
TheekKaro/
├── Models/
│   ├── Issue.swift              # Core data model
│   └── IssueCategory.swift      # Category definitions
├── Services/
│   ├── LocationManager.swift    # GPS services
│   └── LocalStorageService.swift # Data persistence
├── Views/
│   ├── MapHomeView.swift        # Main map interface
│   ├── EnhancedReportSheetView.swift # NEW: Multi-step form
│   ├── DesignSystemComponents.swift  # NEW: Component library
│   └── IssueDetailView.swift    # Issue details
├── Utilities/
│   └── Extensions.swift         # NEW: Design system tokens
└── ViewModels/
    └── IssueViewModel.swift     # Business logic
```

## Requirements ✅

- iOS 17.0+
- Xcode 15.0+
- Camera and Location permissions (auto-requested)

## Recent Updates 📝

### v1.0.2 - Enhanced Add Issue Flow (Current)
- 🎨 **Design System**: Complete color, typography, and spacing tokens
- 📝 **Multi-Step Form**: 6-step guided issue reporting flow
- 🧩 **Component Library**: Reusable UI components (buttons, chips, inputs)
- ✨ **Better UX**: Intuitive step-by-step experience with validation
- 📸 **Enhanced Photos**: Grid layout supporting up to 6 images

### v1.0.1 - Build Ready & Enhanced UI
- ✅ **Production Ready**: Successfully builds and deploys to iOS devices
- 📸 **Photo Capture**: Improved camera interface with fallback support
- 🎯 **Better Validation**: Visual feedback for form completion

### v1.0 - Initial Release
- 🗺️ **Interactive Map**: Issue pins with category filtering
- 📍 **GPS Integration**: Location-based issue reporting
- 💾 **Local Storage**: JSON persistence with photo management

---

**Built with ❤️ for better communities**  
*v1.0.2 - Enhanced Issue Reporting Experience* 