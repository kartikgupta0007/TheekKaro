# Design System - TheekKaro

## Design Philosophy

TheekKaro's design system prioritizes **clarity, accessibility, and civic pride**. The interface combines modern iOS patterns with trustworthy civic colors to create an approachable yet professional experience for citizen reporting.

## 🎨 **Color Palette**

### **Primary Colors**
- **Primary Accent**: Indigo 500 (#6366F1)
  - Usage: FAB, primary CTAs, selected states
  - Implementation: `Color.indigo` in Extensions.swift
  - RGB: (99, 102, 241)

### **Category System Colors**
| Category | Color | Hex Code | RGB Values | Usage |
|----------|-------|----------|------------|-------|
| **Pothole** | Red 600 | #DC2626 | (220, 38, 38) | Pins, filters, badges |
| **Streetlight** | Orange 600 | #D97706 | (217, 119, 6) | Pins, filters, badges |
| **Garbage** | Green 600 | #16A34A | (22, 163, 74) | Pins, filters, badges |
| **Water Leak** | Blue 600 | #2563EB | (37, 99, 235) | Pins, filters, badges |
| **Other** | Purple 600 | #9333EA | (147, 51, 234) | Pins, filters, badges |

### **System Colors**
- **Background**: System Background (adaptive light/dark)
- **Surface**: Ultra-thin material with blur effects
- **Text Primary**: Label color (.primary)
- **Text Secondary**: Secondary label color (.secondary)
- **Success**: Green 500 (#10B981)
- **Warning**: Amber 500 (#F59E0B)
- **Error**: Red 500 (#EF4444)

### **Heatmap Gradient** (Future Implementation)
- **Low Density**: Green (#34D399)
- **Medium Density**: Amber (#FBBF24)
- **High Density**: Red (#F87171)

---

## 📝 **Typography**

### **Font Stack**
- **Primary**: SF Pro (iOS system font)
- **Rounded**: SF Pro Rounded (for headlines and FAB)
- **Monospace**: SF Mono (for coordinates display)

### **Type Scale**
| Style | Font Size | Weight | Line Height | Usage |
|-------|-----------|--------|-------------|-------|
| **H1** | 28pt | Bold | 34pt | Navigation titles |
| **H2** | 22pt | Bold | 28pt | Section headers |
| **H3** | 18pt | Semibold | 24pt | Card titles |
| **Body** | 16pt | Medium | 22pt | Primary text |
| **Body Small** | 14pt | Regular | 20pt | Descriptions |
| **Caption** | 12pt | Regular | 16pt | Metadata, timestamps |
| **Button** | 16pt | Semibold | 22pt | Interactive elements |

### **Dynamic Type Support**
- All text scales with iOS accessibility settings
- Maintains readable contrast at all sizes
- Proper line spacing preserved across scale factors

---

## 🧩 **Component Library**

### **Buttons**

#### **Floating Action Button (FAB)**
```swift
// Primary action button for issue reporting
Circle()
    .fill(Color.indigo)
    .frame(width: 60, height: 60)
    .shadow(radius: 8, y: 4)
    .overlay(
        Image(systemName: "plus")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
    )
```

#### **Category Filter Chips**
```swift
// Horizontal scrolling category filters
Capsule()
    .fill(isSelected ? category.color : Color.clear)
    .stroke(category.color, lineWidth: isSelected ? 0 : 1)
    .overlay(
        HStack {
            Image(systemName: category.systemImageName)
            Text(category.displayName)
        }
        .foregroundColor(isSelected ? .white : .primary)
    )
```

#### **Action Buttons**
- **Primary**: Indigo background, white text, 12pt corner radius
- **Secondary**: Clear background, indigo border, indigo text
- **Destructive**: Red background, white text, confirmation required

### **Cards & Surfaces**

#### **Issue Information Cards**
```swift
RoundedRectangle(cornerRadius: 12)
    .fill(Color.gray.opacity(0.1))
    .overlay(content)
    .shadow(radius: 2, y: 1)
```

#### **Bottom Sheets**
- **Material**: Ultra-thin blur background
- **Corner Radius**: 16pt top corners
- **Detents**: 30%, 60%, 80% height options
- **Handle**: Standard iOS grab indicator

### **Map Components**

#### **Issue Pins**
```swift
// Category-coded map annotations
Circle()
    .fill(issue.category.color)
    .frame(width: 32, height: 32)
    .shadow(radius: 4)
    .overlay(
        Image(systemName: issue.category.systemImageName)
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
    )
```

#### **User Location Indicator**
```swift
// Blue circle with white border
Circle()
    .fill(Color.blue)
    .frame(width: 20, height: 20)
    .overlay(
        Circle()
            .stroke(Color.white, lineWidth: 3)
    )
```

---

## 🎭 **Animations & Transitions**

### **Animation Timing**
- **Fast**: 150ms (filter toggles, button states)
- **Standard**: 250ms (sheet presentations, view transitions)
- **Slow**: 400ms (pin drops, major state changes)

### **Easing Functions**
- **Spring**: Response 0.3, Damping 0.7 (default for iOS-feel)
- **Ease In-Out**: For linear property changes
- **Ease Out**: For exit animations

### **Micro-interactions**

#### **Button Press Animation**
```swift
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
```

#### **Pin Drop Animation**
```swift
.scaleEffect(isNew ? 0 : 1)
.animation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.1), value: isNew)
```

#### **Filter Selection**
```swift
.animation(.easeInOut(duration: 0.15), value: isSelected)
```

### **Sheet Transitions**
- **Presentation**: Scale up from 90% → 100% with spring
- **Dismissal**: Scale down with fade out
- **Snap**: Between detent levels with haptic feedback

---

## 📐 **Layout & Spacing**

### **Grid System**
- **Base Unit**: 4pt
- **Spacing Scale**: 4, 8, 12, 16, 20, 24, 32, 48pt
- **Container Padding**: 16pt (standard), 20pt (FAB offset)

### **Component Spacing**
| Component | Padding | Margin | Corner Radius |
|-----------|---------|--------|---------------|
| **Cards** | 16pt | 12pt vertical | 12pt |
| **Buttons** | 12pt horizontal, 8pt vertical | 8pt | 8pt |
| **Chips** | 12pt horizontal, 8pt vertical | 6pt | Capsule |
| **Sheets** | 20pt | - | 16pt (top only) |

### **Safe Areas**
- **Respect all safe areas** for universal device support
- **Navigation**: Account for Dynamic Island and notch
- **Home Indicator**: Maintain proper bottom spacing
- **Keyboard**: Automatic content adjustment

---

## ♿ **Accessibility**

### **Color Accessibility**
- **WCAG AA Compliance**: All text meets 4.5:1 contrast ratio
- **Color Independence**: Never rely solely on color for information
- **High Contrast Support**: Automatic adjustments in accessibility mode

### **VoiceOver Support**
```swift
// Proper accessibility labels for all interactive elements
.accessibilityLabel("Report new civic issue")
.accessibilityHint("Opens camera to capture photo of issue")
.accessibilityRole(.button)
```

### **Dynamic Type**
- **All text scales** with user preferences
- **Layout adaptability** maintains usability at all sizes
- **Icon scaling** proportional to text size changes

### **Motor Accessibility**
- **Touch targets**: Minimum 44x44pt for all interactive elements
- **Gesture alternatives**: Tap alternatives for all swipe actions
- **Voice Control**: Compatible with iOS voice navigation

---

## 🌓 **Dark Mode Adaptation**

### **Color Behavior**
- **Automatic adaptation** using iOS semantic colors
- **Surface elevation** through opacity adjustments
- **Shadow modifications** for dark backgrounds
- **Blur materials** maintain consistency across themes

### **Implementation Strategy**
```swift
// Use semantic colors for automatic adaptation
.foregroundColor(.primary)  // Auto light/dark text
.background(.ultraThinMaterial)  // Auto blur material
.shadow(color: .black.opacity(0.1), radius: 4)  // Adaptive shadows
```

---

## 📱 **Responsive Design**

### **iPhone Layouts**
- **Portrait**: Standard single-column layouts
- **Landscape**: Optimized for one-handed use
- **Dynamic spacing**: Adjusts to screen size variations

### **iPad Adaptations**
- **Larger touch targets** for tablet interaction
- **Increased spacing** for larger screens
- **Sidebar potential** for future multi-column layouts

### **Device-Specific Optimizations**
- **iPhone Mini**: Compact spacing adjustments
- **iPhone Pro Max**: Enhanced readability with larger elements
- **iPad Pro**: Prepared for future desktop-class features

---

## 🎯 **Component States**

### **Interactive States**
- **Default**: Base appearance
- **Hover**: Subtle highlight (iPad with pointer)
- **Pressed**: Scale + shadow reduction
- **Disabled**: 40% opacity + no interaction
- **Loading**: Progress indicators + disabled state

### **Validation States**
- **Valid**: Green accent (checkmark icon)
- **Invalid**: Red accent (warning icon)
- **Required**: Red asterisk or "Required" badge
- **Optional**: Subtle "Optional" text

### **Selection States**
- **Selected**: Category color background + white text/icons
- **Unselected**: Clear background + category border + dark text
- **Multiple Selection**: Checkbox indicators (future)

---

## 🔧 **Implementation Notes**

### **SwiftUI Best Practices**
- **Semantic colors** for automatic theme support
- **SF Symbols** for scalable, consistent iconography
- **Native animations** using SwiftUI's built-in systems
- **Material backgrounds** for proper depth and translucency

### **Performance Considerations**
- **Lazy loading** for expensive view rendering
- **Animation optimization** with explicit value dependencies
- **Image compression** balanced with visual quality
- **Memory management** for photo-heavy interfaces

### **Future Enhancements**
- **Component library extraction** for code reuse
- **Design token system** for consistent theming
- **Animation library** for complex micro-interactions
- **Accessibility testing** framework integration

---
*Design System v1.0 | Updated July 2025* 