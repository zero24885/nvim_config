require("toggleterm").setup({
  size = 10, -- 终端的高度（以行数为单位）
  open_mapping = [[<c-\>]], -- 打开终端的快捷键
  shade_terminals = true, -- 是否给终端添加阴影
  start_in_insert = true, -- 启动时是否进入插入模式
  -- direction = 'horizontal', -- 设置终端方向为下方
  close_on_exit = true, -- 关闭终端时是否退出
  float_opts = {
    border = 'curved', -- 浮动窗口的边框样式
    winblend = 10, -- 窗口透明度
    height = 20, -- 浮动窗口的高度
    width = 80, -- 浮动窗口的宽度
  },
})

-- 创建一个下方终端
local bottom_terminal = require('toggleterm.terminal').Terminal:new({
  cmd = "bash", -- 你可以替换为其他命令
  hidden = true, -- 初始化时隐藏终端
  direction = 'horizontal', -- 设置为水平终端
})

function _bottom_terminal_toggle()
  bottom_terminal:toggle()
end

-- 创建浮动终端
local float_terminal = require('toggleterm.terminal').Terminal:new({
  cmd = "bash", -- 你可以替换为其他命令
  hidden = true, -- 初始化时隐藏终端
  direction = 'float', -- 浮动终端
})

function _float_terminal_toggle()
  float_terminal:toggle()
end

-- 自动进入插入模式
function _G.on_terminal_open()
  vim.cmd("startinsert")
end

-- 在打开终端时调用 on_terminal_open 函数
vim.cmd([[autocmd! TermOpen * lua _G.on_terminal_open()]])

vim.api.nvim_set_keymap('n', '<leader>tb', ':lua _bottom_terminal_toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':lua _float_terminal_toggle()<CR>', { noremap = true, silent = true })

