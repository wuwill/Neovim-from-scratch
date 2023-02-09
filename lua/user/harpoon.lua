local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")
local cmdui = require("harpoon.cmd-ui")
local tmux = require("harpoon.tmux")


vim.keymap.set("n", "<leader>r", mark.add_file)
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>o", function() ui.nav_next() end)
vim.keymap.set("n", "<leader>i", function() ui.nav_prev() end)
vim.keymap.set("n", "<leader>0", function() term.gotoTerminal(1) end)
-- vim.keymap.set("n", "<leader>c", function() cmdui.toggle_quick_menu() end)
vim.keymap.set("n", "<leader>4", function() tmux.gotoTerminal(1) end)
vim.keymap.set("n", "<leader>5", function() tmux.gotoTerminal(2) end)


