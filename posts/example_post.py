# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %% [markdown]
# # Example Blog Post
#
# This is an example post using Jupytext format.
#
# ## Writing Markdown
#
# You can write regular markdown here. The `# %% [markdown]` marker
# indicates this is a markdown cell.

# %% [markdown]
# ## Code Cells
#
# Code cells don't need the `[markdown]` marker:

# %%
import torch
import matplotlib.pyplot as plt

# Simple example
x = torch.linspace(0, 10, 100)
y = torch.sin(x)

print(f"Generated {len(x)} points")

# %% [markdown]
# ## Visualizations
#
# Matplotlib plots work great:

# %%
plt.figure(figsize=(10, 4))
plt.plot(x.numpy(), y.numpy())
plt.title("Sine Wave")
plt.xlabel("x")
plt.ylabel("sin(x)")
plt.grid(True)
plt.show()

# %% [markdown]
# ## Math with LaTeX
#
# You can include LaTeX math:
#
# Inline: $E = mc^2$
#
# Display:
# $$
# \text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V
# $$

# %% [markdown]
# ## Conclusion
#
# This is the Harvard NLP-style workflow:
# - Write in `.py` files (source control friendly)
# - Generate `.ipynb` with `make notebook`
# - Generate HTML with `make html`
# - `.ipynb` files are build artifacts (not committed)
