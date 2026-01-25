# Greenforests Brand Audit

Audit CSS/styling files for compliance with Greenforests brand guidelines.

## Instructions

1. Search for CSS files in the target directory (default: current project)
2. Check for brand color compliance:
   - Flag any hardcoded colors not in the brand palette
   - Identify missing CSS custom properties
   - Check color contrast ratios

3. Check typography compliance:
   - Verify Zen Old Mincho is used for headings
   - Verify Cormorant Garamond is used for body text
   - Check font imports are present

4. Report findings:
   - List non-compliant colors with line numbers
   - Suggest brand-compliant replacements
   - Identify missing Google Fonts imports

## Brand Colors Reference

### Approved Colors
- Forest: #1A3A2F, #2D5A45, #4A7C5F, #6B8F71, #A8C4A2
- Orange: #C45A2C, #D4714A, #E8A857, #F5C56D
- Cream: #E8DCC4, #F4EDE0, #FAF8F3, #FEFDFB
- Wood: #3D2E1F, #5C4033, #8B6B4A

### Required Fonts
- Zen Old Mincho (headings)
- Cormorant Garamond (body)

$ARGUMENTS
