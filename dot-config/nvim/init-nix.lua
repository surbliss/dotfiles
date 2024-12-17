-- Pls fix
-- [[ Options ]]
-- See :help option-list
-- Must happen before plugins are required
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For custom functions later
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

-- Only mouse in [h]elp windows
-- Or [a]llways
vim.opt.mouse = "a"

-- statusline already shows mode
vim.opt.showmode = false

-- Copy from anywhere
vim.opt.clipboard = "unnamedplus"

-- Visual wrap keeps indentation
vim.opt.breakindent = true
vim.opt.textwidth = 80

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Text keeps moving, if not always on
vim.opt.signcolumn = "yes"

-- vim.opt.updatetime = 250
-- For which-key
-- vim.opt.timeoutlen = 500

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "nosplit"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

-- wrap between words
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 4

-- Don't keep buffer open when opening new file
vim.opt.hidden = false

-- Combined with mapping <Esc> to clear highlights
vim.opt.hlsearch = true

vim.filetype.add({
  extension = {
    ispc = "ispc"
  }
})

-- [[ Basic Autocommands ]]
-- See ':help lua-guide-autocommands'
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying text)",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toogle checkboxes, from https://github.com/opdavies/toggle-checkbox.nvim/blob/main/lua/toggle-checkbox.lua
local checked_character = "x"

local checked_checkbox = "%[" .. checked_character .. "%]"
local unchecked_checkbox = "%[ %]"

local line_contains_unchecked = function(line)
  return line:find(unchecked_checkbox)
end

local line_contains_checked = function(line)
  return line:find(checked_checkbox)
end

local line_with_checkbox = function(line)
  -- return not line_contains_a_checked_checkbox(line) and not line_contains_an_unchecked_checkbox(line)
  return line:find("^%s*- " .. checked_checkbox)
      or line:find("^%s*- " .. unchecked_checkbox)
      or line:find("^%s*%d%. " .. checked_checkbox)
      or line:find("^%s*%d%. " .. unchecked_checkbox)
end

local checkbox = {
  check = function(line)
    return line:gsub(unchecked_checkbox, checked_checkbox, 1)
  end,

  uncheck = function(line)
    return line:gsub(checked_checkbox, unchecked_checkbox, 1)
  end,

  make_checkbox = function(line)
    if not line:match("^%s*-%s.*$") and not line:match("^%s*%d%s.*$") then
      -- "xxx" -> "- [ ] xxx"
      return line:gsub("(%S+)", "- [ ] %1", 1)
    else
      -- "- xxx" -> "- [ ] xxx", "3. xxx" -> "3. [ ] xxx"
      return line:gsub("(%s*- )(.*)", "%1[ ] %2", 1):gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1)
    end
  end,
}


local toggle = function()
  local bufnr = vim.api.nvim_buf_get_number(0)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local start_line = cursor[1] - 1
  local current_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ""

  -- If the line contains a checked checkbox then uncheck it.
  -- Otherwise, if it contains an unchecked checkbox, check it.
  local new_line = ""

  if not line_with_checkbox(current_line) then
    new_line = checkbox.make_checkbox(current_line)
  elseif line_contains_unchecked(current_line) then
    new_line = checkbox.check(current_line)
  elseif line_contains_checked(current_line) then
    new_line = checkbox.uncheck(current_line)
  end

  vim.api.nvim_buf_set_lines(bufnr, start_line, start_line + 1, false, { new_line })
  vim.api.nvim_win_set_cursor(0, cursor)
end

vim.api.nvim_create_user_command("ToggleCheckbox", toggle, {})
vim.keymap.set("n", "<leader>tt", ":ToggleCheckbox<CR>")

-- stylua: ignore start

-- [[ Basic Keymaps ]]
-- mapleader = " " and maplocalleader = " " are set in init.lua

-- Combined with 'vim.opt.hlssearch = true'
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "gk", "v:count == 0 ? 'k' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "gj", "v:count == 0 ? 'j' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end,
  { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Easier window movement (but conflicts with Harpoon)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })


-- LSP-commands (see :help vim.lsp.buf)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "K", vim.lsp.buf.hover) -- KK to focus hover window
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>rf", vim.lsp.buf.rename)

require('nvim-surround').setup({ keymaps = { visual = false, }, })

vim.cmd.colorscheme 'catppuccin-mocha'
require('nvim-autopairs').setup({
  disable_filetype = { 'tex' }
})

local cmp = require("cmp")
local luasnip = require("luasnip")

vim.keymap.set(
  "n",
  "<Leader>L",
  -- "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/luasnippets/'})<CR>"
  -- To quickly reload snippets, without having to run home-manager switch.
  -- But do remember to run home-manager switch at end of session!
  "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '/etc/nixos/home-manager/nvim/luasnippets/'})<CR>"
)
luasnip.config.setup({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
  update_events = "TextChanged,TextChangedI",
})

-- HACK: Do this in terms of 'luasnip' variable instead?
require('luasnip.loaders.from_lua').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- old one: completeopt = "menuone,noselect",
  completion = { completeopt = "menu,menuone,noinsert" },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-b>"] = cmp.mapping.scroll_docs(-8),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(8),
    -- Accept ([y]es) the completion
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({ select = true })
        end
      else
        fallback()
      end
    end),
    -- Manually trigger a completion from nvim-cmp (normally not needed)
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "n", "i", "s" }),
    ["<C-k>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "n", "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    ["jk"] = cmp.mapping(function()
      if luasnip.locally_jumpable() then
        luasnip.jump(1)
      end
    end, { "i", "s" }),
    -- Better completions, especially for latex
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "neorg" },
    { name = "orgmode" },
  },
})

-- NOTE: Keymaps are in ../.../keymaps.lua, so all keymaps are in the same file

-- local on_attach = function(_, bufnr)
--   local bufmap = function(keys, func)
--     vim.keymap.set('n', keys, func, { buffer = bufnr })
--   end
--
--   bufmap('<leader>r', vim.lsp.buf.rename)
--   bufmap('<leader>a', vim.lsp.buf.code_action)
--
--   bufmap('gd', vim.lsp.buf.definition)
--   bufmap('gD', vim.lsp.buf.declaration)
--   bufmap('gI', vim.lsp.buf.implementation)
--   bufmap('<leader>D', vim.lsp.buf.type_definition)
--
--   -- bufmap('gr', require('telescope.builtin').lsp_references)
--   -- bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
--   -- bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
--
--   bufmap('K', vim.lsp.buf.hover)
--
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, {})
-- end
--
--
--

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    -- if client.supports_method('textDocument/implementation') then
    --   -- Create a keymap for vim.lsp.buf.implementation
    -- end

    -- if client.supports_method('textDocument/completion') then
    --   -- Enable auto-completion
    --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    -- end

    -- FIX:
    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    if client.supports_method('textDocument/formatting') then
      -- Format the current buffer on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})




local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  if client.name == 'ruff_lsp' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

-- 1
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     -- 2
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       -- 3
--       buffer = args.buf,
--       callback = function()
--         -- 4 + 5
--         vim.lsp.buf.format { async = false, id = args.data.client_id }
--       end,
--     })
--   end
-- })


-- Doesn't work, fix l8er
require('neodev').setup {
  override = function(root_dir, library)
    if root_dir:find("home/angryluck/.config/home-manager/nvim", 1, true) == 1 then
      library.enabled = true
      library.plugins = true
    end
  end,
}

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      workspace = { checkThirdparty = false },
      telemetry = { enable = false },
    }
  }
}

-- require('lspconfig').lua_ls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- 	root_dir = function()
--         return vim.loop.cwd()
--     end,
-- 	cmd = { "lua-lsp" },
--     settings = {
--         Lua = {
--             workspace = { checkThirdParty = false },
--             telemetry = { enable = false },
--         },
--     }
-- }

require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

-- require('lspconfig').nil_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     ['nil'] = {
--       formatting = {
--         -- Re-add when https://github.com/neovim/neovim/pull/29601 is merged!
--         command = { "nixfmt" },
--         -- command = { "alejandra" },
--       },
--     },
--   },
-- }
--
-- require("lspconfig").fsautocomplete.setup {}

-- require('lspconfig').ccls.setup {}
require('lspconfig').clangd.setup {}

require('lspconfig').ruff.setup {
  on_attach = on_attach
  -- capabilities = capabilities,
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    -- python = {
    --   analysis = {
    --     -- Ignore all files for analysis to exclusively use Ruff for linting
    --     ignore = { '*' },
    --   },
    -- },
  },
}

-- require("lspconfig").pylsp.setup {
--   settings = {
--     pylsp = {
--       plugins = {
--         yapf = {
--           enabled = true,
--         },
--       },
--     },
--   },
-- }

require("lspconfig").hls.setup({
  -- filetypes = { 'haskell', 'lhaskell', 'cabal' },
  haskell = {
    formattingProvider = "fourmolu",
  },
})

-- require('lspconfig').pyright.setup {
--   settings = {
--     ['pyright'] = {
--       formatting = {
--         command = { "black ." }
--       }
--     }
--   }
-- }

require("lspconfig").futhark_lsp.setup {}

require('nvim-treesitter.configs').setup({
  auto_install = false,
  -- highlight {
  --   enable = true,
  highlight = { enable = true, disable = { "latex" }, },
  -- },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- Defaults
      -- init_selection = "gnn",
      -- node_incremental = "grn",
      -- scope_incremental = "grc",
      -- node_decremental = "grm",

      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<m-space>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- automatically jump forward to textobj, see targets.vim
      lookahead = true,
      keymaps = {
        -- you can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "[a]round [f]unction" },
        ["if"] = { query = "@function.inner", desc = "[i]nner [f]unction" },
        -- [a/i]p is taken for "paragraph".
        ["aa"] = {
          query = "@parameter.outer",
          desc = "[a]round [a]rgument",
        },
        ["ia"] = { query = "@parameter.inner", desc = "[i]nner [a]rgument" },
        -- fucks up vimtex commands!
        -- ['ac'] = '@class.outer',
        -- ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader><"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = "none",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  refactor = {
    highlight_definitions = {
      -- enable = true,
      enable = false,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
      keymaps = {
        smart_rename = "<leader>rn",
      },
    },
  },
})

-- Tmp solution, while setting "highlight = {enable = true}" above doesn't work
vim.api.nvim_create_autocmd("VimEnter", {
  command = ":TSEnable highlight"
})

require('leap').create_default_mappings()
require('leap.user').set_repeat_keys('<enter>', '<backspace>')
vim.keymap.set('n', 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap-forward)')
vim.keymap.set({ 'x', 'o' }, 'S', '<Plug>(leap-backward)')

require('oil').setup()
require('todo-comments').setup()
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({
    keywords = { "TODO", "HACK", "WARN", "FIX", "PERF" }
  })
end, { desc = "Next error/warning todo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev({
    keywords = { "TODO", "HACK", "WARN", "FIX", "PERF" }
  })
end, { desc = "Next error/warning todo comment" })

vim.g.vimtex_view_method = 'zathura'
local chat = require('CopilotChat')
chat.setup({
  -- debug = true,
  window = {
    layout = 'horizontal',
    height = 0.382, -- golden ratio
    -- relative = 'editor',
    -- border = 'rounded',
  },
  model = 'claude-3.5-sonnet',
  auto_insert_mode = true,
  prompts = {
    Documentation = {
      system_prompt =
      "Give me a built in function from the language of the current buffer, that does the following. Do NOT comment on any of the code in the buffer, and do NOT insert it into the given code - only give the function name, and how to pass each parameter",
      mapping = "<leader>cd",
    }
  }
})
vim.keymap.set('n', '<leader>co', chat.open, { silent = true })
vim.keymap.set('n', '<leader>ce', ':CopilotChatExplain<CR>', { silent = true })
vim.keymap.set('n', '<leader>cf', ':CopilotChatFix<CR>', { silent = true })
vim.keymap.set('n', '<leader>cr', ':CopilotChatReview<CR>', { silent = true })
-- with argument:
-- vim.keymap.set('n', '<leader>co', function() chat.open('your_argument') end)
-- or
-- vim.api.nvim_set_keymap('n', '<leader>co', ':lua chat.open('argument')<CR>)


require('copilot').setup({})
require("telescope").setup({
  defaults = {
    mappings = {
      i = { ["<c-enter>"] = "to_fuzzy_refine" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
-- require("telescope").load_extension("emoji")

-- Mappings
-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
local nmap = function(key, cmd, desc)
  vim.keymap.set("n", key, cmd, { desc = desc })
end
nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
nmap("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
nmap("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
nmap("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
nmap("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
nmap("<leader>sr", builtin.resume, "[S]earch [R]esume")
nmap("<leader>s.", builtin.oldfiles, "[S]earch [.] (Recent Files)")
nmap("<leader>sg", builtin.git_files, "[S]earch [G]it Files")
nmap("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")
nmap("<leader>se", ":Telescope emoji<CR>", "[S]earch [E]mojis")

local fuzzy_find = function()
  builtin.current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    })
  )
end
nmap("<leader>/", fuzzy_find, "[/] Fuzzily search current buffer")

local live_grep = function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end
nmap("<leader>s/", live_grep, "[S]earch [/] in Open Files")

local find_files = function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end
nmap("<leader>sn", find_files, "[S]earch [N]eovim files")

require('colorizer').setup({
  user_default_options = { names = false }
})

require('tabout').setup {
  tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
  backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
  act_as_tab = true,            -- shift content if tab out is not possible
  act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  default_shift_tab = '<C-d>',  -- reverse shift default action,
  enable_backwards = true,      -- well ...
  completion = false,           -- if the tabkey is used in a completion pum
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' }
  },
  ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  exclude = {} -- tabout will ignore these filetypes
}
