local status_ok, mini = pcall(require, "mini")
if not status_ok then
  return
end

local spec_pair = require('mini.ai').gen_spec.pair
vim.b.miniai_config = {
  custom_textobjects = {
    ['l'] = spec_pair('^', '$', { type = 'greedy' }),
  },
}

