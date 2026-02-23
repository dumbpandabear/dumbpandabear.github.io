# How to Blog

Complete guide for writing and publishing posts.

## Setup (One Time)

```bash
# Install Pandoc
brew install pandoc

# Install Python dependencies
make setup
```

## Writing Posts

### Working on Drafts

```bash
# 1. Start Jupyter
venv/bin/jupyter notebook

# 2. Create/edit notebooks in drafts/ folder
#    drafts/my_post.ipynb

# 3. Commit drafts (synced across machines, not published)
git add drafts/my_post.ipynb
git commit -m "WIP: Working on post"
git push
```

**Drafts** are committed to git (synced) but not built or published.

### Publishing a Post

```bash
# 1. Move from drafts to posts
mv drafts/my_post.ipynb posts/

# 2. Build
make blog

# 3. Add link to docs/index.html
# Edit and add: <li><a href="my_post.html">My Post Title</a></li>

# 4. Commit
git add posts/my_post.ipynb docs/my_post.html docs/index.html
git commit -m "Publish: My Post Title"
git push
```

## Commands

- `make setup` - Install dependencies
- `make blog` - Build site (.ipynb → HTML)
- `make clean` - Remove build artifacts

## How It Works

The build process:

1. `.ipynb` → `.md` (via nbconvert, with images in `*_files/`)
2. `.md` → `.html` (via Pandoc with custom template)
3. Copy `*_files/` image directories to `docs/`

Only notebooks in `posts/` are built. Notebooks in `drafts/` are ignored by `make blog`.

## Publishing

GitHub Actions automatically deploys to https://dumbpandabear.github.io on every push to main.

The workflow runs `make blog` to rebuild the site from `posts/*.ipynb` files.
