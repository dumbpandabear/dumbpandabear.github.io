# dumbpandabear.github.io

My technical blog with deep dives and learning notes.

## Setup (One Time)

### 1. Install Pandoc

```bash
brew install pandoc
```

### 2. Install Python Dependencies

```bash
make setup
```

## Writing a Post
```bash
# 1. Start Jupyter
venv/bin/jupyter notebook

# 2. Create/edit notebook in posts/ folder

# 3. Sync to .py file
make py

# 4. Build HTML
make html

# 5. Commit
git add posts/*.py docs/*.html
git commit -m "Add post"
```

GitHub Actions automatically deploys to https://dumbpandabear.github.io

## How It Works

The build process converts notebooks to HTML:

1. `.py` files → `.ipynb` (via Jupytext, executed)
2. `.ipynb` → `.md` (via nbconvert, with images in `*_files/`)
3. `.md` → `.html` (via Pandoc with custom template)
4. Copy `*_files/` image directories to `docs/`

The final HTML includes:
- Tufte CSS for elegant typography
- Embedded fonts (self-contained HTML)
- Syntax highlighting with highlight.js
- Math rendering with KaTeX

**Note:** Image directories (`docs/*_files/`) are build artifacts that are automatically regenerated from notebooks. They're gitignored - only commit the source `.py` files and the final `.html` files.

## Commands

- `make setup` - Create venv and install Python dependencies
- `make notebook` - Generate .ipynb from .py files (optional)
- `make py` - Sync .ipynb → .py (after editing in Jupyter)
- `make html` - Build HTML from .py files using Pandoc
- `make blog` - Alias for `make html`
- `make black` - Format Python code
- `make flake` - Check code style
- `make clean` - Remove generated files (.ipynb, .html, image directories)

## Requirements

- Python 3.9+
- Pandoc 3.0+ (install via `brew install pandoc`)
- Dependencies in `requirements.txt` (installed via `make setup`)
