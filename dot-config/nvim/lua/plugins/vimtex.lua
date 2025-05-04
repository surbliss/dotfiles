return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_compiler_method = "latexmk"
    -- vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "aux",
      out_dir = "out",
    }
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-lualatex",
      pdfdvi = "-pdfdvi",
      pdfps = "-pdfps",
      pdflatex = "-pdf",
      luatex = "-lualatex",
      lualatex = "-lualatex",
      xelatex = "-xelatex",
      ["context (pdftex)"] = "-pdf -pdflatex=texexec",
      ["context (luatex)"] = "-pdf -pdflatex=context",
      ["context (xetex)"] = "-pdf -pdflatex=''texexec --xtx''",
    }
  end,
}
