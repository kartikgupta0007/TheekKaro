# TheekKaro 🏙️

*Because our cities deserve better, and every citizen should have a voice.*

## What is TheekKaro?

TheekKaro is an iOS app that makes reporting civic issues as easy as taking a photo. Spotted a pothole? Broken streetlight? Just snap, tag, and it's documented with GPS precision. 

I built this because I was tired of walking past the same broken things every day, feeling helpless about it. Now anyone can be part of fixing their neighborhood.

## The Vision

Imagine if reporting a civic issue took just 30 seconds. Imagine if every citizen could contribute to making their city better with just their phone. That's TheekKaro.

**Current Status**: ✅ **Working iOS app** with map, camera, and local storage

## What It Does Right Now

- **📍 Interactive Map**: See all reported issues on a beautiful map with color-coded categories
- **📸 Quick Reporting**: Tap the + button, snap a photo, pick a category (pothole, streetlight, garbage, water leak, other)
- **🗂️ Smart Organization**: Everything is categorized and stored locally on your device
- **🔒 Privacy First**: No servers, no accounts, your data stays on your phone

## What's Coming Next 1.0.21 🎨

I just finished designing a gorgeous 6-step reporting flow in Figma that transforms the basic form into something beautiful:

1. **Smart Start** - Better way to begin reporting
2. **Photo Magic** - Enhanced camera experience  
3. **Easy Tagging** - Beautiful category selection
4. **Story Time** - Guided description input
5. **Review & Polish** - See before you submit
6. **Victory Lap** - Celebrate contribution + sharing as a message

The designs are ready, now it's time to build this delightful experience.

## Why This Matters

Every pothole reported is a step toward better roads. Every broken streetlight documented is a push for safer streets. This isn't just an app—it's a way for regular people to have an impact on their community.

## Tech Stack

- **iOS 17+** with SwiftUI
- **MapKit** for beautiful maps
- **Local storage** for privacy
- **No external dependencies** - pure iOS

## Design System Colors 🎨

Based on the Figma design system, here are the core colors for TheekKaro:

### Neutral & Base Colors
- **Light Gray**: `#F5F5F0` - Background, subtle surfaces
- **Warm Cream**: `#F9F3D1` - Accent backgrounds, highlights
- **Sage Green**: `#6B7A47` - Secondary actions, nature elements
- **Forest Green**: `#3D4A2B` - Primary text, strong accents

### Warm Accent Colors  
- **Soft Beige**: `#E8D5B7` - Warm neutrals, card backgrounds
- **Peachy Orange**: `#D4956A` - Friendly CTAs, notifications
- **Vibrant Orange**: `#C17B3A` - Primary buttons, active states
- **Deep Rust**: `#A0602A` - Emphasis, important actions

These colors create a warm, approachable feel that makes civic engagement feel welcoming rather than bureaucratic.

## Design System Components 🧩

### Typography System
- **Headlines & Large Text**: Raleway (warm, friendly headings)
- **Body & Interface Text**: SF Pro (clean, readable iOS standard)

### Core Components

#### 🔘 Central Button
Primary action buttons in multiple states:
- **Primary**: Forest Green (`#3D4A2B`) with white text and share icon
- **Secondary**: Sage Green (`#6B7A47`) with white text
- **Large**: Full-width for primary actions like "Submit Report"
- **Compact**: Smaller variant for secondary actions

#### 📍 Location Component
- **Display**: "123, Sector 11, Gurugram" format
- **Interactive**: Dropdown for location selection/editing
- **Styling**: Clean text with subtle dropdown indicator

#### 📝 Text Input Areas
- **Long Description**: Multi-line text areas for detailed reporting
- **Placeholder Examples**: 
  - "I felt worried when I saw..."
  - "I felt worried when I saw that this road after the last rain is now completely broken. This isn't okay to commute over daily."
- **Styling**: Clean borders, comfortable padding

#### 🏷️ Category Chips (Chip1)
- **States**: Selected (filled) and unselected (outlined)
- **Colors**: Using sage green from palette
- **Examples**: "Garbage" and other issue categories
- **Interactive**: Toggle selection with smooth transitions

#### 🖼️ Photo Components
- **Photo Uploader**: Square format with camera icon
- **Image Carousel**: Grid layout for multiple photo selection
- **States**: Empty, uploading, and filled with actual photos
- **Constraint**: "You can add upto 6 photos"
- **Real Photo Example**: Shows actual pothole/road damage photos

#### 📋 Section Headers & Content
- **Page Header**: "You saw it, you felt it. Now share it." (Raleway, large)
- **Section Header**: "Capture the situation" (clear hierarchy)
- **Section Description**: "Choose as many tags as you need—every detail counts"
- **Caption Text**: Helpful hints like photo limits

#### ⚡ Action Elements
- **Bottom Button**: Persistent action for key flows
- **Icon Buttons**: Small interactive elements with X/close functionality
- **Maybe Later**: Secondary action option in warm orange

### Component Principles
- **Consistency**: All components use the warm earth-tone color palette
- **Accessibility**: Clear contrast ratios and touch targets
- **Hierarchy**: Raleway for impact, SF Pro for clarity
- **Real Content**: Components show actual use cases (Gurugram location, road damage photos)

## Getting Started

1. Open in Xcode 15+
2. Build and run on iOS device
3. Grant camera and location permissions
4. Start making your neighborhood better!

---

*Built with ❤️ by someone who believes citizens can change their cities, one report at a time.* 