# greenforests.nvim Makefile
# Sets up Neovim configuration with symlinks

NVIM_CONFIG := $(HOME)/.config/nvim
REPO_DIR := $(shell pwd)
CLAUDE_PLUGIN := $(dir $(REPO_DIR))claude-code.nvim

.PHONY: install uninstall status deps claude-hooks help

install: deps ## Install Neovim config (symlink to ~/.config/nvim)
	@echo "Installing Neovim configuration..."
	@mkdir -p $(HOME)/.config

	@if [ -L "$(NVIM_CONFIG)" ]; then \
		echo "Removing existing symlink..."; \
		rm "$(NVIM_CONFIG)"; \
	elif [ -d "$(NVIM_CONFIG)" ]; then \
		echo "Backing up existing config to $(NVIM_CONFIG).bak"; \
		mv "$(NVIM_CONFIG)" "$(NVIM_CONFIG).bak"; \
	fi

	@ln -s "$(REPO_DIR)" "$(NVIM_CONFIG)"
	@echo "  ✓ Linked $(NVIM_CONFIG) -> $(REPO_DIR)"
	@echo ""
	@echo "Run 'make claude-hooks' to also install Claude Code hooks"

uninstall: ## Remove Neovim config symlink
	@if [ -L "$(NVIM_CONFIG)" ]; then \
		rm "$(NVIM_CONFIG)"; \
		echo "  ✓ Removed $(NVIM_CONFIG) symlink"; \
		if [ -d "$(NVIM_CONFIG).bak" ]; then \
			echo "  Note: Backup exists at $(NVIM_CONFIG).bak"; \
		fi \
	else \
		echo "  $(NVIM_CONFIG) is not a symlink, skipping"; \
	fi

claude-hooks: ## Install Claude Code hooks (from claude-code.nvim)
	@if [ -d "$(CLAUDE_PLUGIN)" ]; then \
		echo "Installing Claude Code hooks..."; \
		$(MAKE) -C "$(CLAUDE_PLUGIN)" install; \
	else \
		echo "Error: claude-code.nvim not found at $(CLAUDE_PLUGIN)"; \
		echo "Clone it with: git clone <repo> $(CLAUDE_PLUGIN)"; \
		exit 1; \
	fi

deps: ## Check for required dependencies
	@echo "Checking dependencies..."
	@command -v nvim >/dev/null 2>&1 || { echo "  ✗ nvim not found"; exit 1; }
	@echo "  ✓ nvim $$(nvim --version | head -1 | cut -d' ' -f2)"
	@command -v git >/dev/null 2>&1 || { echo "  ✗ git not found"; exit 1; }
	@echo "  ✓ git"
	@command -v jq >/dev/null 2>&1 || echo "  ! jq not found (needed for Claude hooks)"
	@echo ""

status: ## Show installation status
	@echo "Neovim config:"
	@if [ -L "$(NVIM_CONFIG)" ]; then \
		target=$$(readlink "$(NVIM_CONFIG)"); \
		if [ "$$target" = "$(REPO_DIR)" ]; then \
			echo "  ✓ $(NVIM_CONFIG) -> $$target"; \
		else \
			echo "  ! $(NVIM_CONFIG) -> $$target (different repo)"; \
		fi \
	elif [ -d "$(NVIM_CONFIG)" ]; then \
		echo "  ✗ $(NVIM_CONFIG) exists (not a symlink)"; \
	else \
		echo "  - $(NVIM_CONFIG) not installed"; \
	fi
	@echo ""
	@echo "Claude Code plugin:"
	@if [ -d "$(CLAUDE_PLUGIN)" ]; then \
		echo "  ✓ Found at $(CLAUDE_PLUGIN)"; \
		$(MAKE) -C "$(CLAUDE_PLUGIN)" status 2>/dev/null || echo "  (no status target)"; \
	else \
		echo "  - Not found at $(CLAUDE_PLUGIN)"; \
	fi

all: install claude-hooks ## Full installation (nvim + claude hooks)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
