# dumbpandabear.github.io

Technical blog with deep dives and learning notes.

https://dumbpandabear.github.io

## Quick Start

```bash
# Setup (one time)
brew install pandoc
make setup

# Write posts in drafts/
venv/bin/jupyter notebook

# Publish: move to posts/ and build
mv drafts/my_post.ipynb posts/
make blog

# Commit and deploy
git add posts/*.ipynb docs/*.html docs/index.html
git commit -m "Publish: My Post"
git push
```

See [how_to_blog.md](how_to_blog.md) for detailed instructions.
