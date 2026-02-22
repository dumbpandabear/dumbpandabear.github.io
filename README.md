# dumbpandabear.github.io

My blog.

## Setup (One Time)

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

# 5. Commit (only .py files!)
git add posts/*.py
git commit -m "Add post"
git push
```

GitHub Actions automatically deploys to https://dumbpandabear.github.io

## Commands

- `make setup` - Install dependencies
- `make py` - Sync .ipynb → .py
- `make html` - Build site
- `make black` - Format code
- `make flake` - Check style
