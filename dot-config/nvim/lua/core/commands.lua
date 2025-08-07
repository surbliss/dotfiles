-- [[ Basic Autocommands ]]
-- See ':help lua-guide-autocommands'
vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking (copying text)",
   group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
   callback = function() vim.highlight.on_yank() end,
})

-- Toogle checkboxes, from https://github.com/opdavies/toggle-checkbox.nvim/blob/main/lua/toggle-checkbox.lua
local checked_character = "x"

local checked_checkbox = "%[" .. checked_character .. "%]"
local unchecked_checkbox = "%[ %]"

local line_contains_unchecked = function(line)
   return line:find(unchecked_checkbox)
end

local line_contains_checked = function(line) return line:find(checked_checkbox) end

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
         return line
            :gsub("(%s*- )(.*)", "%1[ ] %2", 1)
            :gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1)
      end
   end,
}

local toggle = function()
   local bufnr = vim.api.nvim_buf_get_number(0)
   local cursor = vim.api.nvim_win_get_cursor(0)
   local start_line = cursor[1] - 1
   local current_line = vim.api.nvim_buf_get_lines(
      bufnr,
      start_line,
      start_line + 1,
      false
   )[1] or ""

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

   vim.api.nvim_buf_set_lines(
      bufnr,
      start_line,
      start_line + 1,
      false,
      { new_line }
   )
   vim.api.nvim_win_set_cursor(0, cursor)
end

vim.cmd("cnoreabbrev template Template")

-- vim.api.nvim_create_user_command("template", function(opts)
--   vim.cmd("Template " .. (opts.args or ""))
-- end, { nargs = "*" })

-- vim.api.nvim_create_user_command("ToggleCheckbox", toggle, {})
-- vim.keymap.set("n", "<leader>tc", ":ToggleCheckbox<CR>")

vim.api.nvim_create_user_command("Tpdf", function()
   local Path = require("pathlib")
   local filepath = vim.api.nvim_buf_get_name(0)
   filepath = Path(filepath)
   local pdfpath = filepath:parent() / "out" / (filepath:stem() .. ".pdf")
   -- if not pdfpath:exists() then
   --    print("No such path: " .. pdfpath)
   --    return
   -- end
   --
   vim.system { "zathura", pdfpath:tostring() }

   -- if filepath:match("%.typ$") then
   --    local pdf_path, count = filepath:gsub("%/%.typ$", "%1/out/%2.pdf")
   --    if count == 0 then
   --       print(pdf_path)
   --       return
   --    end
   --
   --    vim.system { "sioyek", pdf_path }
   -- end
end, {})

local dj_active = false
vim.api.nvim_create_user_command("Dj", function()
   if dj_active then
      vim.keymap.del("", "j")
      vim.keymap.del("", "d")
   else
      vim.keymap.set("", "d", "j", { noremap = true, nowait = true })
      vim.keymap.set("", "j", "d", { noremap = true })
   end
   dj_active = not dj_active
end, {})

----------------------------------------------------------------------
-- Custom filetypes
----------------------------------------------------------------------
vim.filetype.add {
   extension = {
      fsl = "ocaml",
      fsp = "menhir",
      fo = "fasto",
      ispc = "ispc",
      xkb = "c",
   },
}
