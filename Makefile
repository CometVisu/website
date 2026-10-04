# CometVisu Website Makefile
# ===========================

# Variables
HUGO := hugo
NPM := npm
DEMO_SOURCE := cometvisu
DEMO_TARGET := static/demo
DOCS_TARGET := static/docs
NODE_VERSION := $(shell node --version 2>/dev/null)

VERSION := $(shell cd $(DEMO_SOURCE) && ./cv doc --get-version)
VERSION_PATH := $(shell cd $(DEMO_SOURCE) &&./cv doc --get-target-version)

.DEFAULT_GOAL := build

# Full build (demo + docs + website)
.PHONY: all
all: demo docs build


# Help
.PHONY: help
help:
	@echo "CometVisu Website - Available targets:"
	@echo ""
	@echo "  make all        - Build demo, docs and website (default)"
	@echo "  make build      - Build the Hugo website"
	@echo "  make demo       - Build the CometVisu demo"
	@echo "  make docs       - Build the CometVisu documentation"
	@echo "  make serve      - Start Hugo development server"
	@echo "  make clean      - Remove generated files"
	@echo "  make clean-demo - Remove demo build only"
	@echo "  make clean-docs - Remove docs build only"
	@echo "  make check      - Check dependencies"
	@echo ""

# Check dependencies
.PHONY: check
check:
	@echo "Checking dependencies..."
	@command -v $(HUGO) >/dev/null 2>&1 || { echo "❌ Hugo is not installed"; exit 1; }
	@echo "✓ Hugo: $$($(HUGO) version | head -c 50)..."
	@command -v node >/dev/null 2>&1 || { echo "❌ Node.js is not installed"; exit 1; }
	@echo "✓ Node.js: $(NODE_VERSION)"
	@command -v $(NPM) >/dev/null 2>&1 || { echo "❌ npm is not installed"; exit 1; }
	@echo "✓ npm: $$($(NPM) --version)"
	@test -d $(DEMO_SOURCE) || { echo "❌ CometVisu submodule not found"; exit 1; }
	@echo "✓ CometVisu submodule present"
	@echo ""
	@echo "All dependencies OK!"

# Prepare the CometVisu demo (install dependencies)
.PHONY: prepare-demo
prepare-demo: ${DEMO_SOURCE}
${DEMO_SOURCE}:
	@echo "Preparing CometVisu demo..."
	@cd $(DEMO_SOURCE) && $(NPM) ci --prefer-offline --silent
	@cd $(DEMO_SOURCE) && npx qx pkg update --quiet

# Build the CometVisu demo
.PHONY: demo
demo: prepare-demo
	@echo "Building CometVisu demo..."
	@cd $(DEMO_SOURCE) && npx qx deploy --target=build --out=../$(DEMO_TARGET) --source-maps --save-source-in-map --set-env 'qx.globalErrorHandling=false'
	@cd $(DEMO_TARGET) && cp resource/demo/visu_config_demo-tile.xml resource/config/visu_config.xml
	@echo "✓ Demo built successfully"

# Build the CometVisu demo (source version)
.PHONY: demo-source
demo-source: prepare-demo
	@echo "Building CometVisu demo..."
	@cd $(DEMO_SOURCE) && npx qx compile
	@rm -rf $(DEMO_TARGET)
	@cp -r $(DEMO_SOURCE)/compiled/source $(DEMO_TARGET)
	@cd $(DEMO_TARGET) && cp resource/demo/visu_config_demo-tile.xml resource/config/visu_config.xml
	@echo "✓ Demo built successfully"	

# Build the CometVisu documentation
.PHONY: docs
docs: prepare-demo
	@echo "Building CometVisu documentation..."
	@cd $(DEMO_SOURCE) && ./cv doc -l de --target-version=${VERSION_PATH} -f --doc-dir ../$(DOCS_TARGET)
	@cd $(DEMO_SOURCE) && ./cv doc -l en --target-version=${VERSION_PATH} -f --doc-dir ../$(DOCS_TARGET)
	@cd $(DEMO_SOURCE) && ./cv doc --process-versions --doc-dir ../$(DOCS_TARGET)
	@echo "✓ Documentation built successfully"

# Build the Hugo website
.PHONY: build
build:
	@echo "Building Hugo website..."
	$(HUGO) --gc --minify
	@echo "✓ Website built successfully"

# Start development server
.PHONY: serve
serve:
	@echo "Starting Hugo development server..."
	$(HUGO) server --port 1313 --bind 0.0.0.0

# Start development server with drafts
.PHONY: serve-drafts
serve-drafts:
	@echo "Starting Hugo development server (with drafts)..."
	$(HUGO) server --port 1313 --bind 0.0.0.0 --buildDrafts

# Clean all generated files
.PHONY: clean
clean: clean-demo clean-docs
	@echo "Cleaning website build..."
	rm -rf public/
	@echo "✓ Clean complete"

# Clean demo only
.PHONY: clean-demo
clean-demo:
	@echo "Cleaning demo build..."
	rm -rf $(DEMO_TARGET)/
	@echo "✓ Demo cleaned"

# Clean docs only
.PHONY: clean-docs
clean-docs:
	@echo "Cleaning docs build..."
	rm -rf $(DOCS_TARGET)/
	@echo "✓ Docs cleaned"

# Update CometVisu submodule
.PHONY: update-submodule
update-submodule:
	@echo "Updating CometVisu submodule..."
	git submodule update --remote $(DEMO_SOURCE)
	@echo "✓ Submodule updated"

# Install npm dependencies in submodule
.PHONY: install-deps
install-deps:
	@echo "Installing npm dependencies..."
	cd $(DEMO_SOURCE) && $(NPM) ci --prefer-offline
	@echo "✓ Dependencies installed"

# Production build (clean + all)
.PHONY: production
production: clean all
	@echo ""
	@echo "✓ Production build complete!"
	@echo "  Output: public/"
