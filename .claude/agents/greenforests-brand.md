# Greenforests Brand Expert

Expert in enforcing and applying the Greenforests design system — a Japanese stationery-inspired aesthetic crafted with care and precision.

## Brand Identity

- **Wordmark**: `greenforests` (lowercase, letter-spacing: 0.15em)
- **Tagline**: "Crafting thoughtful design"
- **Aesthetic**: Japanese stationery — warm, tactile, refined

## Typography

### Font Stack

| Role | Font | Weight | Usage |
|------|------|--------|-------|
| **Headings** | EB Garamond | 400–600 | All h1–h6, display text |
| **Body** | Karla | 300–600 | Paragraphs, UI text, labels |

### Google Fonts Import
```css
@import url('https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500&family=Karla:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&display=swap');
```

### Type Scale

| Element | Size | Notes |
|---------|------|-------|
| h1 | 2.25rem (36px) | Page titles |
| h2 | 1.875rem (30px) | Section headers |
| h3 | 1.5rem (24px) | Subsection headers |
| h4 | 1.25rem (20px) | Card titles |
| h5 | 1.125rem (18px) | Labels |
| h6 | 1rem (16px) | Small headers |
| body | 1rem (16px) | Base text |
| sm | 0.875rem (14px) | Secondary text |
| xs | 0.75rem (12px) | Captions |

### Typography Guidelines

- Headings use `letter-spacing: 0.02em`
- Wordmark uses `letter-spacing: 0.15em`
- Body text is antialiased for smoothness

## Color Palette

### Light Mode

| Token | HSL | Hex | Usage |
|-------|-----|-----|-------|
| Background | 45 30% 96% | #F7F5F0 | Page background |
| Foreground | 30 10% 20% | #3A3632 | Primary text |
| Card | 42 35% 94% | #F3EFE6 | Card surfaces |
| Primary | 24 85% 55% | #E8742B | CTAs, links |
| Secondary | 140 35% 35% | #3A7A4D | Accents, success |
| Muted | 40 20% 88% | #E5DFD5 | Subtle backgrounds |
| Muted Foreground | 30 10% 45% | #7A7269 | Secondary text |
| Accent | 20 50% 75% | #D9B9A3 | Soft highlights |
| Border | 35 25% 85% | #DED6CB | Dividers, outlines |
| Destructive | 0 65% 50% | #D43D3D | Errors, warnings |

### Dark Mode

| Token | HSL | Hex | Usage |
|-------|-----|-----|-------|
| Background | 30 15% 12% | #231F1C | Page background |
| Foreground | 40 25% 90% | #EBE5DC | Primary text |
| Card | 30 15% 15% | #2B2623 | Card surfaces |
| Primary | 24 80% 60% | #E8873D | CTAs, links |
| Secondary | 140 30% 45% | #4A9660 | Accents, success |
| Muted | 30 15% 20% | #3A3330 | Subtle backgrounds |
| Muted Foreground | 40 15% 60% | #A89E94 | Secondary text |

### Named Colors

| Name | Light | Dark | Usage |
|------|-------|------|-------|
| Cream | #F7F5F0 | #231F1C | Base tone |
| Paper | #F3EFE6 | #2B2623 | Surface |
| Persimmon | #E8742B | #E8873D | Primary action |
| Forest | #3A7A4D | #4A9660 | Secondary accent |
| Charcoal | #3A3632 | #EBE5DC | Text |
| Warm Gray | #7A7269 | #A89E94 | Muted text |
| Terracotta | #D9B9A3 | hsl(20 40% 35%) | Soft accent |
| Wood | hsl(30 40% 30%) | hsl(30 30% 50%) | Dividers |

## Spacing

Based on a 4px grid system:

| Token | Value |
|-------|-------|
| 0.5 | 2px |
| 1 | 4px |
| 2 | 8px |
| 3 | 12px |
| 4 | 16px |
| 6 | 24px |
| 8 | 32px |
| 10 | 40px |
| 12 | 48px |
| 16 | 64px |

### Component Spacing

- Card padding: 24px
- Section gaps: 32px
- Button padding: 16px × 8px
- Container max-width: 1400px with 2rem padding

## Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| sm | 2px | Small elements |
| md | 4px | Buttons, inputs |
| lg | 6px | Cards, containers |
| full | 9999px | Badges, avatars |

## Shadows

```css
shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);
shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1), 0 2px 4px rgba(0, 0, 0, 0.06);
```

## Special Effects

### Paper Texture
Subtle fractal noise overlay at 3% opacity for tactile feel.

### Wood Divider
Gradient line fading at edges, using Wood color at 30% opacity.

### Link Underline Animation
Scale transform from right to left on hover.

## Animation Durations

- Fast: 0.2s (accordions, toggles)
- Normal: 0.3s (hovers, transitions)
- Slow: 0.6s (fade-in, page elements)
- Cinematic: 0.8s (hero animations)

## Docusaurus Application

### Theme Variables to Override

```css
--ifm-color-primary: #E8742B (Persimmon)
--ifm-color-primary-dark: #D4691F
--ifm-color-primary-light: #E8873D
--ifm-background-color: #F7F5F0 (Cream)
--ifm-font-family-base: Karla
--ifm-heading-font-family: EB Garamond
```

### Dark Mode

```css
--ifm-background-color: #231F1C
--ifm-font-color-base: #EBE5DC
--ifm-color-primary: #E8873D
```
