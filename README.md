# Neovim Configuration

A personal [Neovim](https://neovim.io/) setup built on top of **[LazyVim](https://github.com/LazyVim/LazyVim)**, a plugin distribution that gives you sensible defaults out of the box. This configuration layers a curated set of language servers, formatting, debugging, and UI plugins on top of LazyVim, all managed with the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

---

## Overview

Everything is bootstrapped from `init.lua`, which simply delegates to `lua/config/lazy.lua`. That file installs `lazy.nvim` automatically if it isn't present, then loads LazyVim plus every spec file found in `lua/plugins/`.

```
~/.config/nvim/
├── init.lua                  # entry point -> requires config.lazy
├── lazy-lock.json            # (generated) pinned plugin versions
└── lua/
    ├── config/
    │   ├── lazy.lua          # lazy.nvim bootstrap + LazyVim import
    │   ├── options.lua       # Neovim base options
    │   ├── keymaps.lua       # Leader/custom keybindings
    │   └── autocmds.lua      # (empty) custom autocommands
    └── plugins/              # plugin specs, auto-imported by lazy.nvim
        ├── blink-tabconfirm.lua
        ├── colorscheme.lua
        ├── conform.lua
        ├── dap.lua
        ├── disable-bufferline.lua
        ├── emmet-ls.lua
        ├── example.lua
        ├── git-signs.lua
        ├── go.lua
        ├── harpoon.lua
        ├── jdtls.lua
        ├── lsp.lua
        ├── noice.lua
        ├── snacks.lua
        └── ts-comments.lua
```

LazyVim also ships its **own** set of plugins (over 100: treesitter, telescope/snacks, oil, mini.nvim, ts-autotag, etc.). This config mostly _customizes_ those defaults rather than replacing them. Use `:Lazy` to inspect which plugins are loaded, their status, and any pending updates.

### Key components

- **Plugin manager:** `lazy.nvim` — installs, lazy-loads, and updates plugins.
- **Base distribution:** `LazyVim` — bundles defaults for completion, LSP, format-on-save, treesitter, diagnostics, UI, etc.
- **Completion:** `blink.cmp` — the default LazyVim completion engine.
- **LSP:** `nvim-lspconfig` + `mason.nvim` — language server discovery and installation.
- **Formatting:** `conform.nvim` — format-on-save via Prettier.
- **Debugging:** `nvim-dap` + `nvim-dap-ui` + `mason-nvim-dap` — debug adapter protocol support.
- **File navigation:** Harpoon 2, Snacks (explorer/picker), Telescope integrations.

---

## Installation

Requires Neovim **0.9+** and `git`. Plugins install automatically on first launch.

```bash
# Clone the config into place, then run nvim
git clone https://github.com/<you>/nvim ~/.config/nvim
nvim
```

On first start, lazy.nvim is cloned and all plugins are installed. After that, run `:Lazy sync` to update plugins and `:Mason` to manage LSP/DAP binaries.

---

## Getting Started / Daily Commands

| Command                                                      | Action                                   |
| ------------------------------------------------------------ | ---------------------------------------- |
| `:Lazy`                                                      | Open the lazy.nvim plugin manager UI     |
| `:Lazy sync`                                                 | Install/update plugins                   |
| `:Mason`                                                     | Install/manage LSP, DAP, formatter tools |
| `:LspInfo`                                                   | Show active language servers             |
| `:Format` / `:ConformInfo`                                   | Format current file / inspect formatters |
| `:DapContinue` / `:DapStepOver` (plus the leader maps below) | Start / control a debug session          |
| `:che`                                                       | Browse Neovim helptags                   |

---

## Plugin Files Explained

All specs live in `lua/plugins/`. Each file returns a Lua table (or list of tables) that `lazy.nvim` merges with the LazyVim defaults.

### `blink-tabconfirm.lua`

Customizes **[blink.cmp](https://github.com/saghen/blink.cmp)**, LazyVim's completion engine.

- Overrides the completion keymap preset so `<Tab>` selects the **next** item and accepts it, `<S-Tab>` selects the previous item, and `<CR>` accepts the highlighted item (with a `<fallback>` to normal behavior when the menu isn't open).
- Enables `auto_brackets`, so accepting a function/object completion automatically inserts matching `()` / `{}` brackets.

### `colorscheme.lua`

Adds three color schemes and sets the active one:

- `ellisonleao/gruvbox.nvim`
- `sainnhe/gruvbox-material`
- `catppuccin/nvim`
- Overrides the LazyVim `colorscheme` option to **`catppuccin`** (the active theme).

Switch themes at any time with `:colorscheme <name>`.

### `conform.lua`

Configures **[conform.nvim](https://github.com/stevearc/conform.nvim)**, which powers LazyVim's format-on-save.

- Maps formatters per filetype, using **Prettier** for: `html`, `css`, `javascript`, `javascriptreact`, `typescript`, `typescriptreact`, `json`, `markdown`, and `yaml`.
- PHP formatting (`php-cs-fixer`) is present but commented out.

### `dap.lua`

Sets up full debugging support via **[nvim-dap](https://github.com/mfussenegger/nvim-dap)**.

- **dependencies** pull in:
  - `rcarriga/nvim-dap-ui` — floating UI for the debug session.
  - `leoluz/nvim-dap-go` — Go debugging with Delve.
  - `nvim-neotest/nvim-nio` — async library used by the UI.
  - `jay-babu/mason-nvim-dap.nvim` — automatic DAP adapter install via Mason.
- `mason-nvim-dap` ensures **codelldb** is auto-installed.
- Registers a `gdb` fallback adapter and C++/C/Rust launch configurations (prompts for the executable path).
- Debug sessions open in a Neovim terminal split and auto-open/close `nvim-dap-ui`.
- Defines the `<Leader>d*` keybindings (see the Keybindings section).

### `disable-bufferline.lua`

Disables the default **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** tab bar by setting `enabled = false` — a common choice when relying on the Snacks explorer / Harpoon for file switching instead.

### `emmet-ls.lua`

Configures the **emmet_ls** language server (via `nvim-lspconfig`) to provide [Emmet](https://emmet.io/) HTML/CSS expansion. It is enabled only for `html` filetypes (CSS/React/JS filetypes are commented out to keep it scoped).

### `example.lua`

A **disabled example spec** (`if true then return {} end`) documenting how to write LazyVim plugin specs. It showcases overriding built-in plugins, adding new ones, extending `nvim-cmp`, custom telescope layouts, pyright/tsserver setup, and treesitter parser installs. It is intentionally not loaded.

### `git-signs.lua`

Enables **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**'s `current_line_blame`, which shows the author/commit of the current line in the lines/blame popup.

### `go.lua`

Adds **[goimpl.nvim](https://github.com/edolphin-ydf/goimpl.nvim)**, a tool to generate Go `func` stubs for implementing an interface. It depends on Telescope and treesitter and registers the `goimpl` Telescope extension (searchable with `:Telescope goimpl`).

### `harpoon.lua`

Sets up **[Harpoon 2](https://github.com/ThePrimeagen/harpoon)** (the `harpoon2` branch) for quick file switching.

- Depends on `plenary.nvim` and `telescope.nvim`.
- Enables `save_on_change` and `save_on_toggle` so the file list persists.
- Provides the `<Leader>h*` keybindings (add, open menu, jump 1–4, cycle, and a Telescope picker).

### `jdtls.lua`

Adds **[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)**, the Java language server client (works with the Eclipse JDT language server). Fine-tuned integration with the noice progress filter — see `noice.lua` and `lsp.lua`.

### `lsp.lua`

Customizes `nvim-lspconfig` for the **gopls** Go language server. After attach, it disables gopls **semantic tokens** so tree-sitter highlighting is used instead of the LSP provider.

### `noice.lua`

Configures **[noice.nvim](https://github.com/folke/noice.nvim)** to route/skip messages. Adds a route that **skips** jdtls progress notifications matching "Validate"/"Publish", suppressing the distracting popups Java emits on every keystroke.

### `snacks.lua`

Configures **[snacks.nvim](https://github.com/folke/snacks.nvim)** (LazyVim's default picker/explorer/notifications kit).

- The picker's `files` source shows hidden (dot) files and follows symlinks.

### `ts-comments.lua`

Loads **[ts-comments.nvim](https://github.com/folke/ts-comments.nvim)** at startup (`lazy = false`), enabling tree-sitter-aware comment toggling across many filetypes (used by the gc/gb mappings).

---

## Keybindings

<Leader> is the space bar. LazyVim ships many default mappings (save, search, window/resession, git, LSP) — see `:help lazyvim-keymaps` and `:LazyExtras`. The bindings below are the ones this config adds or overrides.

### Custom / Overridden (from `lua/config/keymaps.lua`)

| Key                | Mode | Action                                               |
| ------------------ | ---- | ---------------------------------------------------- |
| `<Leader><Leader>` | n    | Open the Snacks **file explorer** (swapped)          |
| `<Leader>e`        | n    | Find files via the Snacks picker (swapped)           |
| `J`                | v    | Move selection down and keep it selected             |
| `K`                | v    | Move selection up and keep it selected               |
| `<C-d>`            | n    | Scroll down half a page, keep cursor centered (`zz`) |
| `<C-u>`            | n    | Scroll up half a page, keep cursor centered (`zz`)   |

> Note: `<Leader>e` was swapped with `<Leader><Leader>` vs. the LazyVim defaults: explorer now lives on the double-leader, find-files on `<Leader>e`.

### Harpoon (from `lua/plugins/harpoon.lua`)

| Key               | Action                       |
| ----------------- | ---------------------------- |
| `<Leader>ha`      | Add current file to the list |
| `<Leader>hh`      | Toggle the Harpoon menu      |
| `<Leader>h1`–`h4` | Jump to marked file 1–4      |
| `<Leader>hn`      | Jump to the next file        |
| `<Leader>hp`      | Jump to the previous file    |
| `<Leader>ht`      | Pick a file with Telescope   |

### Debugging (from `lua/plugins/dap.lua`)

| Key          | Action                     |
| ------------ | -------------------------- |
| `<Leader>db` | Toggle breakpoint          |
| `<Leader>dB` | Set conditional breakpoint |
| `<Leader>dc` | Continue / start a session |
| `<Leader>dg` | Run to cursor              |
| `<Leader>dn` | Step into                  |
| `<Leader>do` | Step over                  |
| `<Leader>dO` | Step out                   |
| `<Leader>dr` | Restart session            |
| `<Leader>dt` | Terminate session          |

---

## Customization

- **Options:** edit `lua/config/options.lua` (loaded before lazy.nvim).
- **Keymaps:** add mappings to `lua/config/keymaps.lua`.
- **Autocmds:** add them to `lua/config/autocmds.lua`.
- **Plugins:** add/override specs in new files under `lua/plugins/` — every `.lua` file there is auto-loaded. Use `lua/plugins/example.lua` as a template (it documents disabling plugins, adding dependencies, overriding `opts`, and importing LazyVim extras).

---

## License / Attribution

This config builds on the [LazyVim starter template](https://github.com/LazyVim/starter). All bundled plugins are the work of their respective authors, distributed under their own licenses.
