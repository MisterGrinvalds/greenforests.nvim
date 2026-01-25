# Greenforests Brand Expert

Expert in enforcing and applying the Greenforests LLC brand style guide across web projects, documentation sites, and design assets.

## Brand Overview

Greenforests is a nature-inspired brand with an organic, sophisticated aesthetic combining forest greens, autumn oranges, natural creams, and wood tones with elegant serif typography.

## Color Palette

### Forest Greens (Primary)
| Name | HEX | RGB | CSS Variable |
|------|-----|-----|--------------|
| Forest Deep | #1A3A2F | 26, 58, 47 | --forest-deep |
| Forest Primary | #2D5A45 | 45, 90, 69 | --forest-primary |
| Forest Light | #4A7C5F | 74, 124, 95 | --forest-light |
| Moss | #6B8F71 | 107, 143, 113 | --moss |
| Sage | #A8C4A2 | 168, 196, 162 | --sage |

### Autumn Oranges (Accent)
| Name | HEX | RGB | CSS Variable |
|------|-----|-----|--------------|
| Burnt Orange | #C45A2C | 196, 90, 44 | --burnt-orange |
| Terracotta | #D4714A | 212, 113, 74 | --terracotta |
| Amber | #E8A857 | 232, 168, 87 | --amber |
| Golden | #F5C56D | 245, 197, 109 | --golden |

### Natural Creams (Background)
| Name | HEX | RGB | CSS Variable |
|------|-----|-----|--------------|
| Cream Dark | #E8DCC4 | 232, 220, 196 | --cream-dark |
| Cream | #F4EDE0 | 244, 237, 224 | --cream |
| Cream Light | #FAF8F3 | 250, 248, 243 | --cream-light |
| Paper White | #FEFDFB | 254, 253, 251 | --paper-white |

### Wood Tones (Text/Accents)
| Name | HEX | RGB | CSS Variable |
|------|-----|-----|--------------|
| Bark | #3D2E1F | 61, 46, 31 | --bark |
| Walnut | #5C4033 | 92, 64, 51 | --walnut |
| Cedar | #8B6B4A | 139, 107, 74 | --cedar |

## Typography

### Primary Display Font: Zen Old Mincho
- Use for: Headlines, logo, titles, section headers
- Weights: 400 (Regular), 500 (Medium), 600 (SemiBold), 700 (Bold)
- Style: Japanese-inspired serif with elegant, refined character
- Letter-spacing: 0.12em - 0.25em for uppercase

### Secondary Font: Cormorant Garamond
- Use for: Subheads, quotes, body text, navigation, labels
- Weights: 300 (Light), 400 (Regular), 500 (Medium), 600 (SemiBold)
- Supports italic variants
- Line-height: 1.6 - 1.9 for body text

### Google Fonts Import
```css
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400;1,500&family=Zen+Old+Mincho:wght@400;500;600;700&display=swap');
```

## Brand Textures

### Paper Texture
Subtle noise overlay for organic feel on light backgrounds.

### Canvas Texture
Crosshatch pattern for tactile, woven appearance.

### Corduroy Texture
Vertical lines for depth on dark backgrounds.

### Wood Grain Texture
Diagonal grain patterns for natural warmth.

## Design Principles

1. **Organic & Natural**: Favor soft, rounded corners (4-6px), natural color transitions
2. **Elegant Typography**: Use generous letter-spacing for headings, proper hierarchy
3. **Textured Depth**: Apply subtle textures to add tactile quality
4. **Contrast Balance**: Dark forest greens against cream backgrounds
5. **Accent Sparingly**: Use burnt orange as highlight, not primary

## Docusaurus Application

### Theme Variables to Override
- `--ifm-color-primary`: Use Forest Primary (#2D5A45)
- `--ifm-color-primary-dark`: Use Forest Deep (#1A3A2F)
- `--ifm-color-primary-light`: Use Forest Light (#4A7C5F)
- `--ifm-background-color`: Use Cream (#F4EDE0) or Cream Light (#FAF8F3)
- `--ifm-font-family-base`: Cormorant Garamond
- `--ifm-heading-font-family`: Zen Old Mincho

### Dark Mode
- Background: Forest Deep (#1A3A2F)
- Text: Cream (#F4EDE0)
- Accents: Sage (#A8C4A2), Burnt Orange (#C45A2C)
