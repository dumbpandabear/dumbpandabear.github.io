# Virtual environment paths (if venv exists, use it; otherwise use system binaries)
VENV = venv
VENV_EXISTS := $(shell [ -d $(VENV) ] && echo 1 || echo 0)

ifeq ($(VENV_EXISTS),1)
    PYTHON = $(VENV)/bin/python
    PIP = $(VENV)/bin/pip
    JUPYTEXT = $(VENV)/bin/jupytext
    JUPYTER = $(VENV)/bin/jupyter
    BLACK = $(VENV)/bin/black
    FLAKE8 = $(VENV)/bin/flake8
else
    PYTHON = python3
    PIP = pip3
    JUPYTEXT = jupytext
    JUPYTER = jupyter
    BLACK = black
    FLAKE8 = flake8
endif

.PHONY: notebook py html blog black flake clean setup help

help:
	@echo "Available commands:"
	@echo "  make setup     - Create venv and install dependencies"
	@echo "  make notebook  - Generate .ipynb from .py using jupytext"
	@echo "  make py        - Sync .ipynb to .py (after writing in Jupyter)"
	@echo "  make html      - Generate HTML from notebook using Pandoc"
	@echo "  make blog      - Build full blog (alias for html)"
	@echo "  make black     - Format code with black"
	@echo "  make flake     - Check code with flake8"
	@echo "  make clean     - Remove generated files"
	@echo ""
	@echo "Note: Pandoc is required for HTML generation."
	@echo "      Install with: brew install pandoc"

setup:
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo ""
	@echo "✅ Setup complete! Virtual environment created at ./venv"
	@echo "   All make commands will automatically use this venv."

notebook: posts/*.py
	$(JUPYTEXT) --to ipynb posts/*.py

py: posts/*.ipynb
	$(JUPYTEXT) --to py:percent posts/*.ipynb

execute: posts/*.py
	$(JUPYTEXT) --execute --to ipynb posts/*.py

html: posts/*.py
	$(JUPYTEXT) --execute --to ipynb posts/*.py
	$(JUPYTER) nbconvert --to markdown posts/*.ipynb
	mkdir -p docs
	@for md in posts/*.md; do \
		base=$$(basename "$$md" .md); \
		pandoc "$$md" -o "docs/$$base.html" --template=pandoc_template.html --standalone; \
		if [ -d "posts/$${base}_files" ]; then \
			cp -r "posts/$${base}_files" docs/; \
		fi; \
	done
	rm -f posts/*.md
	rm -rf posts/*_files
	@echo "✅ Notebooks converted with Pandoc (Annotated Transformer styling)"

blog: html
	@echo "✅ Blog built successfully"

black: posts/*.py
	$(BLACK) --line-length 79 posts/*.py

flake: posts/*.py
	$(FLAKE8) --show-source posts/*.py

clean:
	rm -f posts/*.ipynb
	rm -f posts/*.md
	rm -rf posts/*_files
	rm -f docs/*.html
	rm -rf docs/*_files
