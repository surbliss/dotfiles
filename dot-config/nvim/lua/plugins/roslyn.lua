return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      -- Specific for nixos
      exe = "Microsoft.CodeAnalysis.LanguageServer",
      broad_search = true,
    },
  },
}
