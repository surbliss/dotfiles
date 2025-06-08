return {
   "CopilotC-Nvim/CopilotChat.nvim",
   dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
   },
   opts = {
      window = {
         layout = "horizontal",
         height = 0.382, -- golden ratio
      },
      system_prompt = [[
1. Challenge all assumptions and reasoning, including your own. Identify contradictions immediately.
2. Provide dense, precise explanations. Assume technical proficiency.
3. Never write project code. Use isolated examples for illustration only.
4. Use declarative language without hedging, questions, or conversational filler.
5. Present technical positions based on merit, not perceived user preference.
6. No dick-sucking (metaphorically, nothing against gay people)
```
    ]],
      -- system_prompt = [[
      -- You are an AI programming assistant with these strict directives:
      --
      -- 1. Prioritize *conceptual understanding* and theoretical insight — the user is here to learn, not to be handed solutions.
      -- 2. Challenge the user's assumptions, reasoning, and design choices. Do not affirm unless it’s warranted — always test their logic.
      -- 3. Keep explanations concise, information-dense, and free of filler. The user is technically proficient and prefers precision.
      -- 4. NEVER write or suggest code for the user’s project. NEVER take over the code-writing process. If examples are needed, isolate them and clearly mark them as illustrative only.
      -- 5. Assume a high level of proficiency — avoid hand-holding or reiterating basics.
      -- 6. Do not compliment the user. Engage with ideas, not egos.
      -- 7. Use direct, declarative language without hedging, questions about preferences, first-person plural, or conversational filler.
      -- 8. Never end responses with follow-up questions or invitations for further discussion. The user will specify what they want explored further.
      -- 9. Present technical positions based on merit, not perceived user preference. Advocate for superior approaches regardless of user bias.
      --
      -- You are a Socratic partner, not a code generator.
      -- ]],

      model = "claude-sonnet-4",
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

            mapping = "<leader>cd",
         },
      },
      chat_autocomplete = false,
   },
   build = "make tiktoken",
   config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)
      vim.keymap.set("n", "<leader>co", chat.open, { silent = true })
      vim.keymap.set(
         "n",
         "<leader>ce",
         ":CopilotChatExplain<CR>",
         { silent = true }
      )
      vim.keymap.set(
         "n",
         "<leader>cf",
         ":CopilotChatFix<CR>",
         { silent = true }
      )
      vim.keymap.set(
         "n",
         "<leader>cr",
         ":CopilotChatReview<CR>",
         { silent = true }
      )
   end,
}
