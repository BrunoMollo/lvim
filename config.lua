-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny



lvim.format_on_save.enabled = true


-- Disabled because it caused an error and I don't know if i need it
lvim.builtin.bufferline.active = false


-- Nvim Tree
lvim.builtin.nvimtree.setup.view.float.quit_on_focus_loss = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.float.enable = true

lvim.builtin.nvimtree.setup.view.width = 80
lvim.builtin.nvimtree.setup.view.float.open_win_config.width = 80
lvim.builtin.nvimtree.setup.view.float.open_win_config.height = 25

lvim.builtin.nvimtree.setup.filters.git_ignored = true

lvim.builtin.nvimtree.setup.renderer.indent_width = 4
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true
