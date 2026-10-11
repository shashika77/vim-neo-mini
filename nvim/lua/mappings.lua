require "nvchad.mappings"

local map = vim.keymap.set

-- Your custom mappings
map("n", ";", ":", { desc = "CMD enter command mode", nowait = true })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>o", "<cmd>Telescope find_files<CR>", { desc = "Open file" })
map("n", "<leader>rn", "<cmd>set norelativenumber<CR>", { desc = "Use normal line numbers" })
map("n", "<leader>q", "<cmd>confirm bdelete<CR>", { desc = "Close buffer safely" })
map("n", "<leader>Q", "<cmd>confirm qall<CR>", { desc = "Quit all safely" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map("n", "<leader>y", '"+yy', { desc = "Copy line to system clipboard" })
map("x", "<leader>y", '"+y', { desc = "Copy selection to system clipboard" })
map("n", "<leader>u", "u", { desc = "Undo" })
map("n", "<leader>U", "<C-r>", { desc = "Redo" })
map("n", "<leader><Left>", "<cmd>wincmd h<CR>", { desc = "Focus pane to the left" })
map("n", "<leader><Down>", "<cmd>wincmd j<CR>", { desc = "Focus pane below" })
map("n", "<leader><Up>", "<cmd>wincmd k<CR>", { desc = "Focus pane above" })
map("n", "<leader><Right>", "<cmd>wincmd l<CR>", { desc = "Focus pane to the right" })
map("n", "<leader><Tab>", function() require("nvchad.tabufline").next() end, { desc = "Next open file" })
map("n", "<leader><S-Tab>", function() require("nvchad.tabufline").prev() end, { desc = "Previous open file" })

-- Start the current JavaScript project's dev server in a terminal split.
local function start_web_dev()
  local package_file = vim.fs.find("package.json", { upward = true, path = vim.fn.getcwd() })[1]
  if not package_file then
    vim.notify("No package.json found. Open Neovim from a web project.", vim.log.levels.WARN)
    return
  end

  local ok, package = pcall(vim.json.decode, table.concat(vim.fn.readfile(package_file), "\n"))
  if not ok or type(package) ~= "table" then
    vim.notify("Could not read the project's package.json.", vim.log.levels.ERROR)
    return
  end

  local scripts = package.scripts or {}
  local script = scripts.dev and "dev" or (scripts.start and "start")
  if not script then
    vim.notify("No 'dev' or 'start' script found in package.json.", vim.log.levels.WARN)
    return
  end

  local root = vim.fs.dirname(package_file)
  local manager = "npm"
  local lockfiles = {
    { "pnpm-lock.yaml", "pnpm" },
    { "yarn.lock", "yarn" },
    { "bun.lock", "bun" },
    { "bun.lockb", "bun" },
  }
  for _, entry in ipairs(lockfiles) do
    if vim.fn.filereadable(root .. "/" .. entry[1]) == 1 and vim.fn.executable(entry[2]) == 1 then
      manager = entry[2]
      break
    end
  end

  if vim.fn.executable(manager) ~= 1 then
    vim.notify("Package manager '" .. manager .. "' is not installed.", vim.log.levels.ERROR)
    return
  end

  vim.cmd("botright 12new")
  vim.fn.termopen({ manager, "run", script }, { cwd = root })
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("WebDev", start_web_dev, { desc = "Start the project web dev server" })
map("n", "<leader>tp", start_web_dev, { desc = "Start web preview server" })
map("n", "<leader>gg", "<cmd>!golines . -w<CR>", { desc = "Run golines" })
map("n", "<leader>bb", "<cmd>!black .<CR>", { desc = "Run black" })

-- ============================================
-- WINDOW NAVIGATION
-- ============================================
-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Split windows
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })

-- ============================================
-- LINE MOVEMENT & EDITING
-- ============================================
-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })

-- Better paste (don't overwrite register)
map("x", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- ============================================
-- QUICK ACTIONS
-- ============================================
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy file path" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Quick formatting
map("n", "<leader>fm", function() require("conform").format() end, { desc = "Format buffer" })

-- ============================================
-- FOLDING (nvim-ufo)
-- ============================================
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
map("n", "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, { desc = "Peek fold" })

-- ============================================
-- TODO COMMENTS
-- ============================================
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next TODO" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev TODO" })
map("n", "<leader>td", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })

-- ============================================
-- TELESCOPE
-- ============================================
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
