# Apply Greenforests Brand Styling

Apply the Greenforests brand style guide to a web project.

## Instructions

1. Identify the project type:
   - Docusaurus: Edit `src/css/custom.css`
   - React/Next.js: Edit global CSS or CSS modules
   - Plain HTML: Edit linked stylesheets

2. Add CSS custom properties for all brand colors

3. Configure typography:
   - Add Google Fonts import
   - Set heading font to Zen Old Mincho
   - Set body font to Cormorant Garamond

4. For Docusaurus specifically:
   - Override `--ifm-*` variables
   - Configure light and dark themes
   - Style hero sections with brand colors

5. Apply appropriate textures where suitable

## CSS Variables Template

```css
:root {
  /* Forest Greens */
  --forest-deep: #1a3a2f;
  --forest-primary: #2d5a45;
  --forest-light: #4a7c5f;
  --moss: #6b8f71;
  --sage: #a8c4a2;

  /* Autumn Oranges */
  --burnt-orange: #c45a2c;
  --terracotta: #d4714a;
  --amber: #e8a857;
  --golden: #f5c56d;

  /* Natural Creams */
  --cream-dark: #e8dcc4;
  --cream: #f4ede0;
  --cream-light: #faf8f3;
  --paper-white: #fefdfb;

  /* Wood Tones */
  --bark: #3d2e1f;
  --walnut: #5c4033;
  --cedar: #8b6b4a;
}
```

$ARGUMENTS
