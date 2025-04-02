return {
  cmd = { "csharp-ls" },
  filetypes = { "cs" },
  root_markers = { "*.csproj", ".git/" },
  -- Messages not intrucive
  handlers = {
    ["window/showMessage"] = function(_, result, ctx)
      -- Don't show these messages in a way that requires input
      vim.notify(result.message, vim.log.levels.INFO)
      return nil
    end,
  },
}
