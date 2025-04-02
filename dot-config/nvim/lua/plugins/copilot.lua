return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    -- { "zbirenbaum/copilot.lua", opts = {} }, -- or zbirenbaum/copilot.lua
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  opts = {
    -- debug = true,
    window = {
      -- layout = "vertical",
      -- height = 0.5, -- golden ratio
      layout = "horizontal",
      height = 0.382, -- golden ratio
      -- relative = 'editor',
      -- border = 'rounded',
    },
    system_prompt = [[You are an AI programming assistant following these guidelines:
1. Provide educational guidance, not code replacements - I want to learn concepts, not have work done for me
2. NEVER suggest direct changes to my code - instead, demonstrate concepts with separate examples when needed
3. Keep responses brief and focused on my specific question
4. Use proper markdown syntax for code examples (e.g., ```python)
5. When explaining concepts, prioritize clarity over comprehensiveness
]],
    --     system_prompt = [[You are an AI programming assistant, following the following tenets:
    --
    --
    --   1. Do **not** start taking over the code-writing process. I wan't to learn what I'm doing, no matter if it is fixing my configurations or coding. Suggesting changes or solutions to things I didn't ask about, without explanation, is not helpful.
    --
    --   2. I repeat -- NEVER suggest changes to my code. At best, do examples unrelated to my code of how to apply a concept.
    --
    --   2. Always be brief and concise in your responses. Keep answer closely related to the question asked, and only branch out if specifically asked to.
    --
    --   3. When showing code examples, always use proper markdown syntax highlighting with the appropriate language tag. For example, ```py for Python.
    -- ]],
    -- rest of your options...
    model = "claude-3.7-sonnet-thought",
    -- model = "claude-3.5-sonnet",
    auto_insert_mode = true,

    -- Disable reading buffer by default, to get more generic responses
    selection = function(_) end,

    prompts = {
      Documentation = {
        prompt = "", -- Empty prompt for custom input"
        system_prompt = [[Reply with ONLY:
1. Function: name(parameters) -> return_type
2. Example: one-line usage with typical arguments 
3. Purpose: Single sentence description
Nothing else.]],

        -- [[
        -- Provide only the name and parameters of a built-in function from the current language that matches the user's request, along with a simple example of usage.
        -- Format: functionName(param1, param2).
        --         Example usage.
        --         No explanations.
        -- ]],

        --     Give me a built in function from the language of the current buffer, that does the following. Do NOT comment on any of the code in the buffer, and do NOT insert it into the given code - only give the function name, and how to pass each parameter",
        mapping = "<leader>cd",
      },
    },
    chat_autocomplete = false,
  },
  build = "make tiktoken",
  -- event = "InsertEnter",
  config = function(_, opts)
    local chat = require("CopilotChat")
    chat.setup(opts)
    vim.keymap.set("n", "<leader>co", chat.open, { silent = true })
    vim.keymap.set("n", "<leader>ce", ":CopilotChatExplain<CR>", { silent = true })
    vim.keymap.set("n", "<leader>cf", ":CopilotChatFix<CR>", { silent = true })
    vim.keymap.set("n", "<leader>cr", ":CopilotChatReview<CR>", { silent = true })
    -- vim.keymap.set("n", "<leader>cd", function()
    --   chat.open({
    --     system_prompt =
    --     "Give me a built in function from the language of the current buffer, that does the following. Do NOT comment on any of the code in the buffer, and do NOT insert it into the given code - only give the function name, how to pass each paramater, and maybe a short enlightning example"
    --   })
    -- end, { silent = true })
    -- with argument:
    -- vim.keymap.set('n', '<leader>co', function() chat.open('your_argument') end)
    -- or
    -- vim.api.nvim_set_keymap('n', '<leader>co', ':lua chat.open('argument')<CR>)
  end,
}
