# Agent Guidelines for SCOOP Documentation Repository

## Repository Overview
This repository contains the main documentation for the SCOOP (Carbon Offset Open Platform) project, built with MkDocs and the Material theme. It consists primarily of Markdown files organized in the `docs/` directory. The documentation is deployed to GitHub Pages at https://carbon-offset-open-platform.github.io/mainPublicDoc.

## Development Setup

### Prerequisites
- Python 3.x
- pip
- Git

### Installation
```bash
# Clone the repository
git clone git@github.com:Carbon-Offset-Open-Platform/mainPublicDoc.git
cd mainPublicDoc

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
(venv) pip install mkdocs-material
(venv) pip install pillow cairosvg  # For image processing in documentation

# Verify installation
mkdocs --version
```

## Build/Lint/Test Commands

### Local Development
```bash
# Start local development server with hot reload
source venv/bin/activate
mkdocs serve

# Access at http://127.0.0.1:8000
# The server automatically rebuilds when documentation files change
```

### Building Documentation
```bash
# Build static site for production
source venv/bin/activate
mkdocs build --clean

# Output generated in ./site directory
# Use --clean to ensure fresh build
```

### Deployment
```bash
# Deploy to GitHub Pages (requires push permissions)
source venv/bin/activate
mkdocs gh-deploy --force --clean

# For preview deployments:
# mkdocs gh-deploy --force --clean --remote-branch gh-pages-preview
```

### Validation and Testing Commands
As this is a documentation repository, traditional unit tests don't apply. Use these validation commands:

#### Markdown Syntax Validation
```bash
# Install markdownlint if not present
(venv) pip install markdownlint-cli

# Validate all markdown files
markdownlint './docs/**/*.md'

# Validate a single markdown file (for testing individual changes)
markdownlint './docs/path/to/file.md'

# Fix common issues automatically
markdownlint './docs/**/*.md' --fix
```

#### Link Validation
```bash
# Install htmltest for link validation
(venv) pip install htmltest

# Validate all internal and external links
htmltest

# Validate links in a specific directory
htmltest --conf .htmltest.yml --directory docs/howto/
```

#### MkDocs Configuration Validation
```bash
# Strict build that fails on warnings
source venv/bin/activate
mkdocs build --strict

# Check for unused files and configurations
mkdocs build --verbose 2>&1 | grep -i "warning\|unused"
```

#### Image Optimization Validation
```bash
# Check for oversized images (requires identify from ImageMagick)
find docs/ -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" | while read img; do
  width=$(identify -format "%w" "$img")
  height=$(identify -format "%h" "$img")
  if [ $width -gt 2000 ] || [ $height -gt 2000 ]; then
    echo "Oversized image: $img (${width}x${height})"
  fi
done
```

### Pre-commit Hooks (Recommended)
```bash
# Install pre-commit framework
(venv) pip install pre-commit

# Install the hooks
pre-commit install

# Run all checks manually
pre-commit run --all-files
```

## Code Style Guidelines

### File Organization
- Place new documentation files in appropriate subdirectories under `docs/`
- Use lowercase filenames with hyphens as separators (e.g., `new-feature.md`, `user-guide.md`)
- Group related content in subdirectories (e.g., `docs/howto/`, `docs/research/`, `docs/articles/`)
- Keep directory depth reasonable (maximum 3 levels deep)
- Name directories using lowercase with hyphens (e.g., `api-reference`, `troubleshooting-guide`)
- Place image assets in `docs/images/` or section-specific subdirectories like `docs/howto/images/`

### Markdown Formatting
- Use `#` for page titles (H1), `##` for sections (H2), `###` for subsections (H3), etc.
- Only one H1 per file (the page title)
- Keep line length under 100 characters for readability (except URLs)
- Use blank lines to separate paragraphs, sections, and block elements
- For lists:
  - Use `-` for unordered lists
  - Use numbers for ordered lists (e.g., `1.`, `2.`)
  - Indent nested lists with 2 spaces
- Use fenced code blocks with language specifiers for code examples:
  ```markdown
  ```python
  # Python code with proper indentation
  def hello_world():
      print("Hello World")
  ```
  ```
- Use blockquotes for citations or important notes:
  ```markdown
  > This is a blockquote for emphasis or citations.
  > It can span multiple lines.
  ```
- Use horizontal rules (`---`) to separate major sections within a page
- Use emphasis sparingly: `*italic*` for emphasis, `**bold` for strong emphasis
- Use inline code formatting for technical terms: `` `function_name()` `` or `` `configuration.yaml` ``

### Linking
- Use relative links for internal documentation: `[Link Text](./relative/path.md)`
- For section links within the same file: `[Link Text](#section-name)`
  - Section names should be lowercase with hyphens (generated automatically by MkDocs)
- For external links: use full URLs with descriptive link text
  - Avoid "click here" or "this link" as link text
  - Example: `[SCOOP GitHub Repository](https://github.com/Carbon-Offset-Open-Platform)`
- Validate links periodically to prevent rot using `htmltest` or similar tools
- Use reference-style links only for frequently repeated URLs
- When linking to API documentation, use version-specific URLs when possible

### Images and Assets
- Place images in appropriate directories (e.g., `docs/images/`, `docs/howto/images/`)
- Reference images using relative paths: `![Alt text](./images/image.png)`
- Optimize images for web use:
  - Maximum width: 2000 pixels for screenshots
  - Use appropriate formats: PNG for diagrams/screenshots, JPEG for photographs
  - Compress images without significant quality loss
- Use descriptive alt text for accessibility (describe the image content and purpose)
- For diagrams, consider providing both PNG and SVG versions when appropriate
- Use figure captions when needed:
  ```markdown
  ![Architecture overview showing components](./images/architecture.png)
  *Figure 1: SCOOP system architecture overview*
  ```
- Avoid embedding large binary files directly in Markdown

### Navigation
- Update `mkdocs.yml` nav section when adding new pages or restructuring
- Keep navigation structure shallow and intuitive (maximum 3 levels deep)
- Group related pages under common sections in the navigation
- Use clear, concise navigation labels
- Maintain consistent ordering: alphabetical or logical workflow order
- When adding new sections, consider existing users' mental models
- Document navigation changes in pull request descriptions

### Commit Messages
- Use clear, descriptive commit messages in present tense
- Prefix with type when appropriate:
  - `docs:` for documentation changes
  - `fix:` for typo fixes or minor corrections
  - `refactor:` for restructuring content
  - `style:` for formatting improvements
  - `test:` for adding validation or tests
- Example: `docs: add Nebula overlay network installation guide`
- Keep subject line under 50 characters when possible
- Provide detailed explanation in commit body for complex changes
- Reference related issues: `Fixes #123` or `Related to #456`

### Language and Style
- Write in clear, concise English suitable for international audience
- Use active voice when possible ("Configure the setting" vs "The setting should be configured")
- Define acronyms on first use: "Carbon Offset Open Platform (SCOOP)"
- Be consistent with terminology across documents (use same term for same concept)
- Follow existing style in similar documents for consistency
- Use serial comma in lists for clarity
- Use neutral, professional tone
- Avoid overly technical jargon without explanation
- When mentioning version numbers, specify which version
- Use present tense for current features, future tense for planned features

### Code Examples and Tutorials
- Make code examples copy-pasteable and functional
- Include necessary context (imports, setup) in examples
- Use realistic but anonymized data in examples
- Clearly mark placeholder values that users must replace:
  ```markdown
  api_key = "your-api-key-here"  # Replace with actual key
  ```
- For multi-step procedures, number the steps clearly
- Include expected outputs or results when relevant
- Warn about potential pitfalls or security considerations
- Keep examples focused on one concept when possible

### Accessibility Considerations
- Use descriptive link text that makes sense out of context
- Provide adequate color contrast in diagrams (check with accessibility tools)
- Ensure font sizes in images are readable when scaled
- Use ARIA labels sparingly but appropriately in HTML snippets
- Test documentation with screen readers when possible
- Provide transcripts for any audio/video content

## Contribution Workflow
1. Fork the repository on GitHub
2. Clone your fork locally: `git clone git@github.com:your-username/mainPublicDoc.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes following the guidelines above
5. Test locally: `source venv/bin/activate && mkdocs serve`
6. Validate changes: Run markdownlint, htmltest, and mkdocs build --strict
7. Commit changes: `git commit -m "docs: add feature description"`
8. Push to branch: `git push origin feature/your-feature-name`
9. Open a Pull Request against the main branch
10. Address review feedback promptly
11. Keep branch updated with main: `git pull upstream main`

## Special Considerations
- This repository is primarily for documentation, not code
- Focus on clarity, accuracy, and completeness of information
- Ensure all content is appropriate for public consumption
- Respect licensing for any third-party content included
- When documenting external projects, link to official sources
- Keep documentation version-aligned with software releases when applicable
- Consider international audience: avoid culture-specific references
- Regularly review and update outdated content
- Follow the project's branding guidelines for terminology and tone