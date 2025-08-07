return {
   "nvim-telescope/telescope.nvim",
   tag = "0.1.8",
   -- or, branch = '0.1.x',
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
         "nvim-telescope/telescope-fzf-native.nvim",
         build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
   },
   config = function()
      require("telescope").setup {
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
      }

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "file-browser")
      -- require("telescope").load_extension("emoji")

      -- Mappings
      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      local nmap = function(key, cmd, desc)
         vim.keymap.set("n", key, cmd, { desc = desc })
      end
      nmap("<leader>fh", builtin.help_tags, "[F]ind [H]elp")
      nmap("<leader>fk", builtin.keymaps, "[F]ind [K]eymaps")
      nmap("<leader>ff", builtin.find_files, "[F]ind [F]iles")
      nmap("<leader>fs", builtin.builtin, "[F]ind [S]elect Telescope")
      nmap("<leader>fw", builtin.grep_string, "[F]ind current [W]ord")
      nmap("<leader>ft", builtin.live_grep, "[F]ind file-[T]ext by grep")
      nmap("<leader>fd", builtin.diagnostics, "[F]ind [D]iagnostics")
      nmap("<leader>fr", builtin.resume, "[F]ind [R]esume")
      nmap("<leader>f.", builtin.oldfiles, "[F]ind [.] (Recent Files)")
      nmap("<leader>fg", builtin.git_files, "[F]ind [G]it Files")
      nmap("<leader>fb>", builtin.buffers, "[F]ind existing [B]uffers")
      nmap("<leader>fe", ":Telescope emoji<CR>", "[F]ind [E]mojis")
      -- nmap(
      --    "<leader>fb",
      --    function() require("telescope").extensions.file_browser.file_browser() end,
      --    "[F]ile [B]rowser"
      -- )

      local fuzzy_find = function()
         builtin.current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown {
               winblend = 10,
               previewer = false,
            }
         )
      end
      nmap("<leader>/", fuzzy_find, "[/] Fuzzily search current buffer")

      local live_grep = function()
         builtin.live_grep {
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
         }
      end
      nmap("<leader>f/", live_grep, "[F]ind [/] in Open Files")

      -- local find_files = function()
      --   builtin.find_files({ cwd = vim.fn.stdpath("config") })
      -- end

      local find_neovim_files = function()
         -- builtin.find_files({ cwd = vim.fn.stdpath("config") })
         builtin.find_files { cwd = "~/dotfiles/dot-config/nvim/" }
      end

      nmap("<leader>fn", find_neovim_files, "[F]ind [N]eovim files")

      local find_config_files = function()
         builtin.find_files { cwd = "~/dotfiles/" }
      end

      nmap("<leader>fc", find_config_files, "[F]ind [C]onfig files")
   end,
}
