-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

-- Disabled because it caused an error and I don't know if i need it
lvim.builtin.bufferline.active = false

lvim.builtin.project.patterns = { ".git" }

lvim.builtin.nvimtree.setup.view.float.quit_on_focus_loss = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.float.enable = true

lvim.builtin.nvimtree.setup.view.width = 80
lvim.builtin.nvimtree.setup.view.float.open_win_config.width = 80
lvim.builtin.nvimtree.setup.view.float.open_win_config.height = 25

lvim.builtin.nvimtree.setup.filters.git_ignored = true
lvim.builtin.nvimtree.setup.filters.dotfiles = true

lvim.builtin.nvimtree.setup.renderer.indent_width = 4
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true



lvim.plugins = {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      nvim_tmux_nav.setup {
        disable_when_zoomed = true -- defaults to false
      }

      vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end

  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-pack/nvim-spectre' },
  {
    "BrunoMollo/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-l>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        log_level = "info",                -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in key maps for more manual control
        condition = function()
          return false
        end -- condition to check for stopping SuperMaven, `true` means to stop SuperMaven when the condition is true.
      })
    end,

  },
  {
    "epwalsh/obsidian.nvim",
    config = function()
      vim.opt.conceallevel = 1
      require("obsidian").setup({
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },

        workspaces = {
          {
            name = "iboux",
            path = "~/vaults/iboux",
            template_dir = "~/vaults/templates/note.md",
          },
        },
        templates = {
          folder = "~/vaults/templates",
          date_format = "%Y-%m-%d-%a",
          time_format = "%H:%M",
        },
        ui = {
          enable = true,          -- set to false to disable all additional syntax features
          update_debounce = 200,  -- update delay after a text change (in milliseconds)
          max_file_length = 5000, -- disable UI features for files with more than this many lines
          -- Define how various check-boxes are displayed
          checkboxes = {
            -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            ["!"] = { char = "", hl_group = "ObsidianImportant" },

            -- You can also add more custom ones...
          },
          -- Use bullet marks for non-checkbox lists.
          bullets = { char = "•", hl_group = "ObsidianBullet" },
          external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
          -- Replace the above with this if you don't have a patched font:
          reference_text = { hl_group = "ObsidianRefText" },
          highlight_text = { hl_group = "ObsidianHighlightText" },
          tags = { hl_group = "ObsidianTag" },
          block_ids = { hl_group = "ObsidianBlockID" },
          hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianImportant = { bold = true, fg = "#d73128" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
          },
        },
        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local prefix = ""
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            prefix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              prefix = prefix .. string.char(math.random(65, 90))
            end
          end
          return prefix .. "-" .. tostring(os.time())
        end,

      })

      lvim.builtin.which_key.mappings["o"] = {
        name = "Obsidian",
        s = { "<cmd>ObsidianSearch<CR>", "Search" },
        n = { "<cmd>ObsidianNew<CR>", "New" },
        t = { ':lua vim.cmd("vsp ~/vaults/iboux/todos.md")<CR>', "See todos" }
      }
    end

  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      local function goto_harpoon(index)
        return '<cmd>lua require("harpoon.mark").set_current_at(' ..
            index .. ')<CR><cmd>lua print("File added to list ⇁ ' .. index .. '")<CR>'
      end

      vim.keymap.set('n', '<leader>hh', goto_harpoon(1))
      vim.keymap.set('n', '<leader>hj', goto_harpoon(2))
      vim.keymap.set('n', '<leader>hk', goto_harpoon(3))
      vim.keymap.set('n', '<leader>hl', goto_harpoon(4))

      vim.keymap.set('n', '<leader><leader>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
      vim.keymap.set('n', '1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
      vim.keymap.set('n', '2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
      vim.keymap.set('n', '3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
      vim.keymap.set('n', '4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
    end
  },
  {
    'tpope/vim-surround'
  }
}

lvim.keys.normal_mode["<leader>q"] = false

lvim.builtin.which_key.mappings[";"] = {}
lvim.builtin.which_key.mappings["/"] = {}
lvim.builtin.which_key.mappings["h"] = {}
lvim.builtin.which_key.mappings["T"] = {}



lvim.builtin.which_key.mappings["q"] = {
  name = "Fixlist",
  c = { "<cmd>copen<CR>", "Open" },
  n = { "<cmd>cnext<CR>", "Next" },
  p = { "<cmd>cprev<CR>", "Prev" },
}




-- Formatters
lvim.format_on_save.enabled = true
require("lvim.lsp.null-ls.formatters").setup {
  {
    name = "prettierd",
    ---@usage only start in these file types, by default it will attach to all file types it supports
    filetypes = { "typescript", "typescriptreact", "javascript", "svelte" },
  },
}


vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  command = ":silent! !rm '\\'"
})


-- Spell checking (to download the es spelllang I had to run :setlocal spelllang=es,en)
lvim.builtin.nvimtree.setup.disable_netrw = false
vim.opt.spelllang = 'en_us,es'
vim.opt.spell = true
vim.api.nvim_set_keymap('n', 'zg', '', {
  noremap = true,
  silent = true,
  callback = function()
    local word = vim.fn.expand('<cword>') -- Get the current word
    local confirm = vim.fn.input("Add '" .. word .. "' to spell check? (y/n): ")
    if confirm:lower() == 'y' then
      vim.cmd('normal! zg')
      print("'" .. word .. "' added to spell checker.")
    else
      print("Cancelled adding '" .. word .. "' to spell checker.")
    end
  end
})


--- This is really important to work with python
lvim.keys.visual_mode["<Tab>"] = ">gv"
lvim.keys.visual_mode["<S-Tab>"] = "<gv"

lvim.builtin.treesitter.ensure_installed = {
  'javascript',
  'php',
  'html',
  'css',
  'json',
  'typescript',
  'lua',
  'markdown',
  'yaml',
  'toml',
  'bash',
  'dockerfile',
}


lvim.builtin.treesitter.on_config_done = function()
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = "https://github.com/EmranMR/tree-sitter-blade",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "blade",
  }
end

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})
