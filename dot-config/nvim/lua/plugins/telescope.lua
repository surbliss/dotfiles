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
    pcall(require("telescope").load_extension, "file-browser")
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
    nmap("<leader>st", builtin.live_grep, "[S]earch file-[T]ext by grep")
    nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
    nmap("<leader>sr", builtin.resume, "[S]earch [R]esume")
    nmap("<leader>s.", builtin.oldfiles, "[S]earch [.] (Recent Files)")
    nmap("<leader>sg", builtin.git_files, "[S]earch [G]it Files")
    nmap("<leader>sb>", builtin.buffers, "[S]earch existing [B]uffers")
    nmap("<leader>se", ":Telescope emoji<CR>", "[S]earch [E]mojis")
    nmap(
      "<leader>fb",
      function() require("telescope").extensions.file_browser.file_browser() end,
      "[F]ile [B]rowser"
    )

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

    -- local find_files = function()
    --   builtin.find_files({ cwd = vim.fn.stdpath("config") })
    -- end

    local find_neovim_files = function()
      -- builtin.find_files({ cwd = vim.fn.stdpath("config") })
      builtin.find_files({ cwd = "~/dotfiles/dot-config/nvim/" })
    end

    nmap("<leader>sn", find_neovim_files, "[S]earch [N]eovim files")

    local find_config_files = function()
      builtin.find_files({ cwd = "~/dotfiles/" })
    end

    nmap("<leader>sc", find_config_files, "[S]earch [C]onfig files")
  end,
}
