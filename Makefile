# Virtual environment paths (if venv exists, use it; otherwise use system binaries)
VENV = venv
VENV_EXISTS := $(shell [ -d $(VENV) ] && echo 1 || echo 0)

ifeq ($(VENV_EXISTS),1)
    PYTHON = $(VENV)/bin/python
    PIP = $(VENV)/bin/pip
    JUPYTER = $(VENV)/bin/jupyter
else
    PYTHON = python3
    PIP = pip3
    JUPYTER = jupyter
endif

.PHONY: blog clean setup help

help:
	@echo "Available commands:"
	@echo "  make setup  - Create venv and install dependencies"
	@echo "  make blog   - Build site (.ipynb → HTML)"
	@echo "  make clean  - Remove generated files"
	@echo ""
	@echo "Note: Requires Pandoc (brew install pandoc)"

setup:
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo ""
	@echo "✅ Setup complete! Virtual environment created at ./venv"
	@echo "   All make commands will automatically use this venv."

blog: posts/*.ipynb
	$(JUPYTER) nbconvert --to markdown posts/*.ipynb
	mkdir -p docs
	@for md in posts/*.md; do \
		base=$$(basename "$$md" .md); \
		pandoc "$$md" -o "docs/$$base.html" --template=pandoc_template.html --standalone --katex; \
		if [ -d "posts/$${base}_files" ]; then \
			cp -r "posts/$${base}_files" docs/; \
		fi; \
	done
	rm -f posts/*.md
	rm -rf posts/*_files
	@echo "✅ Blog built successfully"

clean:
	rm -f posts/*.md
	rm -rf posts/*_files
	rm -f docs/*.html
	rm -rf docs/*_files
