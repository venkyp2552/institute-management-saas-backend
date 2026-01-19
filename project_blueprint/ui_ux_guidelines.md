# 🎨 UI/UX Guidelines & Design System

## 1. Core Philosophy
**"Professional, Educational, & Premium."**
The interface should feel trustworthy and authoritative for an educational institution, yet modern and engaging for users. Avoid cluttered "old-school" ERP looks.

## 2. Visual Style
### 2.1 Color Palette
- **Primary Brand:** Deep Trust Blue (`#1e3a8a` / `blue-900`) - Used for Headings, Primary Actions.
- **Secondary Accent:** Emerald Green (`#10b981` / `emerald-500`) - Used for Success states, "Active" badges, and primary buttons on dark backgrounds.
- **Backgrounds:** 
    - Light: `#f8fafc` (Slate-50) for main backgrounds.
    - Surface: `#ffffff` (White) for Cards and Containers.
- **Text:**
    - Headings: `#0f172a` (Slate-900).
    - Body: `#334155` (Slate-700).
    - Muted: `#94a3b8` (Slate-400).

### 2.2 Typography
- **Headings:** `Merriweather` (Serif) or `Inter` (Sans-serif) with bold weights (600/700).
- **Body:** `Inter` or `Roboto` (Sans-serif) for high readability.
- **Hierarchy:**
    - `H1`: 32px (Page Titles).
    - `H2`: 24px (Section Headers).
    - `H3`: 18px (Card Titles).
    - `Body`: 16px (Standard text).

## 3. Component Guidelines
### 3.1 Buttons
- **Primary:** Solid Blue or Green background, White text.
    - *Hover:* Slight brightness increase + Transform `scale(1.02)`.
    - *Active:* `scale(0.98)`.
- **Secondary:** Outline with colored border.
- **Ghost:** Text-only for less important actions (e.g., "Cancel").

### 3.2 Cards & Containers
- **Style:** White background, `rounded-xl` (12px or 16px radius).
- **Shadows:** Use deeply subtle shadows (`shadow-sm` typically, `shadow-md` on hover).
- **Borders:** Very light gray (`border-slate-200`) for structural definition.

### 3.3 Forms
- **Input Fields:** Large tap targets (min 44px height).
- **Focus States:** Distinct ring color (`ring-2 ring-blue-500`) to ensure accessibility.
- **Validation:** Inline error messages in **Red** (`text-red-500`) below the input.

## 4. Interaction & Motion
**Rule:** "Motion should enhance clarity, not reduce performance."
- **Page Transitions:** Gentle fade-in (`opacity-0` to `opacity-100`) on navigation.
- **Hover Effects:** Interactive elements (cards, buttons) should lift or glow slightly.
- **Loading:** Use Skeleton Loaders (gray pulsing blocks) instead of spinners for content loading.

## 5. Layout Patterns
- **Dashboard:** Sidebar Navigation (Left) + Top Header (User Profile) + Main Content Area.
- **Visual Hierarchy:** Most important elements (KPIs, Primary Actions) appear top-left or top-center.
- **Whitespace:** Use generous padding (`p-6` or `p-8`) to prevent cramping.

---
*These guidelines apply to ALL 6 Phases of development.*
