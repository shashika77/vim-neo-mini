# Neovim setup backup

This package backs up the current Neovim configuration, including its plugin lockfile. It does not bundle Neovim itself or downloaded plugins/tools; those are installed on the destination computer.

## What this setup can do

- VS Code-like syntax colors, status line, absolute line numbers, a highlighted current line number, indent guides, and code folding without a fold-level number column. `Space n` toggles line numbers; `Space r n` restores regular sequential numbers and keeps relative numbers off.
- Automatic indentation: two spaces by default, four spaces for Python and Rust, tabs for Go, and literal tabs for Makefiles.
- Auto-format on save: Prettier for JavaScript/TypeScript, JSX/TSX, CSS, HTML, JSON, Markdown, Vue, Svelte, and related files; Black for Python; plus formatters for Lua, Go, Rust, and YAML.
- Regular non-AI completion from language servers, snippets, words in the current buffer, and file paths. In Insert mode, press Tab to accept a suggestion, or Ctrl-Space to open the suggestions menu. JavaScript/React/TypeScript completion can suggest project exports and add their import when accepted.
- Language-server diagnostics for supported languages, shown inline and in the sign column; hover documentation, go-to-definition, references, rename, and code actions. Mouse support lets you Ctrl-Click (or double-click) an imported component or code symbol to open its definition and file. Press Ctrl-o to jump back.
- File navigation, search, Git diff/history, TODO markers, folding, and debugging support.

Formatters and language servers only work for languages with the relevant tool installed and available. The first launch on a new computer installs the configured Neovim plugins and Mason tools.

## Install on macOS or Linux

1. Install Neovim first. On macOS, run `brew install neovim`. On Linux, install `neovim` with your distribution's package manager.
2. Extract this ZIP file.
3. In a terminal, enter the extracted `nvim-setup-backup` folder and run:

   ```sh
   ./install.sh
   ```

The script moves any existing `~/.config/nvim` to a timestamped backup, copies this configuration into place, and adds `vim`/`vi` aliases to `~/.zshrc` if they are not already present. Open a new terminal, then start the editor with `vim file.js` or `nvim file.js`. On first launch, allow plugin and language-tool installation to finish.

To install the configuration manually, copy the package's `nvim` folder to `~/.config/nvim`. On Windows, the Neovim config folder is usually `%LOCALAPPDATA%\nvim`; the included shell script targets macOS/Linux.

## Useful shortcuts

`<leader>` means Space. Most shortcuts are used in Normal mode; press Esc first if you are typing. For example, `Space f f` means press Space, then `f`, then `f`.

### Open files and search

| Keys | Action |
|---|---|
| `vim` | Open Neovim |
| `vim app.js` | Open a named file from the terminal |
| `:e path/to/file` | Open a file from inside Neovim |
| `Ctrl-n` | Toggle the file tree |
| `Space e` or `Ctrl-n` | Show or hide the file tree |
| `Space o` | Find and open a file |
| `Space f f` | Find a file by name; type a name and press Enter |
| `Space f w` | Search text across the project |
| `Space f b` | Find a file you already have open |
| `Space f o` | Reopen a recent file |

### Live web preview while coding

1. Open Neovim from your web project's folder (the folder with `package.json`).
2. Press `Space t p` to start its `dev` script in a terminal split. If there is no `dev` script, the shortcut tries `start`. It chooses pnpm, Yarn, or Bun when a matching lockfile and command are present; otherwise it uses npm.
3. Open the local URL printed in the terminal in your browser. Save code in Neovim; frameworks such as Vite, Astro, and Next.js refresh the browser when their dev server detects the change.
4. To stop the server, focus its terminal and press `Ctrl-c`. Press `Ctrl-x` to leave terminal input mode.

### Auto-import a React or project component

1. Open a JavaScript/TypeScript project from its root folder (the folder with `package.json`, `jsconfig.json`, or `tsconfig.json`). For example, run `cd my-project` and then `vim src/App.tsx`.
2. Make sure the component is exported from its file, then type its name in your `.js`, `.jsx`, `.ts`, or `.tsx` file.
3. When the project component appears in the completion menu, select it and press `Tab`. The TypeScript language server should insert the component and its import. Press `Ctrl-Space` if you want to open suggestions manually.
4. If the component has an error underline but no import suggestion, put the cursor on its name and press `Space c a` to look for an import code action.

This relies on the TypeScript language server seeing both files as part of the same project. For TypeScript server completion preferences, see the [official configuration guide](https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#preferences-options).

From the editor, press `Space` then Left Arrow to focus the file tree. From the file tree, press `Space` then Right Arrow to return to the editor. These pane shortcuts avoid Ctrl-W.

### Save and close

| Keys | Action |
|---|---|
| `Ctrl-s`, `Space w`, or `:w` | Save the current file (supported files format on save) |
| `Space q` | Close the current buffer safely; asks before losing unsaved work |
| `Space x` | Close the current buffer |
| `Space Q` | Quit all windows safely; asks before losing unsaved work |
| `:e` | Start editing a new, empty buffer |
| `:q` | Quit the current window when there are no unsaved changes |
| `:wq` | Save the current file and quit |
| `:qa` | Quit all windows; Neovim will stop if changes are unsaved |
| `:q!` | Quit without saving the current file's changes |
| `:qa!` | Quit everything and discard unsaved changes in all files |

### Select, copy, and paste

Use these in Normal mode (press Esc first if you are typing):

| Keys | Action |
|---|---|
| `v` | Start selecting text character by character; move with arrow keys or `h/j/k/l` |
| `V` | Select whole lines |
| `Ctrl-v` | Select a rectangular block of text |
| `Esc` | Cancel a selection |
| `Ctrl-a` | Select the entire file |
| `y` | Copy the selection inside Neovim |
| `d` | Delete the selection (the deleted text can be pasted) |
| `p` / `P` | Paste after / before the cursor from Neovim's copy register |
| `"+y` | Copy the selection to the computer's system clipboard |
| `"+p` | Paste from the system clipboard into Neovim |
| `Ctrl-c` | Copy the entire file to the system clipboard |
| `Space y` | Copy the current line, or selected text, to the system clipboard |
| `Space p` | Paste from the system clipboard at the cursor |

Example: press `Esc`, then `Ctrl-a`, then `"+y` to copy the whole file so you can paste it into another app. To copy just a few lines, press `V`, move up or down to select lines, then `"+y`. In another app, paste with that app's usual shortcut (on Mac, commonly `Cmd-v`).

### Edit and navigate

| Keys | Action |
|---|---|
| `i` | Start typing before the cursor; press Esc to return to Normal mode |
| `a` | Start typing after the cursor |
| `o` | Create a line below and start typing |
| `Space u` / `Space U` | Undo / redo (also shown in the Space key hints) |
| `u` / `Ctrl-r` | Standard Vim undo / redo |
| `/word` then Enter | Search for `word`; press `n` / `N` for next / previous match |
| `Space b` | Open a new empty buffer |
| `Space` + `Tab` / `Shift-Tab` | Next / previous open file |
| `Space s v` / `Space s h` | Create vertical / horizontal split |
| `Space` + arrow key | Move focus between the file tree, editor, and terminal panes |
| `Space t p` | Start the project web preview server |
| `Space fm` | Format the current buffer now |
| `zR` / `zM` | Open all / close all code folds |
| `Up` / `Down` while typing | Choose a completion suggestion |
| `Tab` or `Enter` while the menu is open | Accept the selected suggestion |
| `Ctrl-Space` in Insert mode | Open completion suggestions |
| `K` | Show documentation for the symbol under the cursor |
| Double-click a code symbol / `gd` | Go to its definition (including imported components when the language server resolves them) |
| `Ctrl-o` | Return to where you jumped from |
| `gr` | Show references |
| `Space ra` / `Space ca` | Rename symbol / show code actions |
| `Space xx` / `Space xd` | Show all diagnostics / current-file diagnostics |
| `F5`, `F10`, `F11`, `F12` | Start/continue, step over, step into, step out in a debug session |

You can press Space and pause to see available key hints, or use `Space f k` to search keymaps. `:Mason` manages language tools and `:Lazy` manages plugins.
