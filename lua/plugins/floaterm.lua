-- 浮动终端 不如 toggleterm 不使用他了

-- 定义常用的 Floaterm 命令映射
local tool = require("tool")  -- 引入工具模块
local map = tool.map

-- 设置浮动终端的宽度和高度
vim.g.floaterm_width = 0.85  -- 设置浮动终端的宽度为屏幕宽度的85%
vim.g.floaterm_height = 0.8   -- 设置浮动终端的高度为屏幕高度的80%

-- 定义快捷键映射
-- 在普通模式下和插入模式下都能调用相同的命令
map("n", "ft", "<CMD>FloatermNew<CR>")  -- 新建一个浮动终端
map("t", "ft", "<CMD>FloatermNew<CR>")  -- 在终端模式中也可以新建浮动终端

map("n", "fj", "<CMD>FloatermPrev<CR>")  -- 切换到上一个浮动终端
map("t", "fj", "<CMD>FloatermPrev<CR>")  -- 在终端模式中切换到上一个浮动终端

map("n", "fk", "<CMD>FloatermNext<CR>")  -- 切换到下一个浮动终端
map("t", "fk", "<CMD>FloatermNext<CR>")  -- 在终端模式中切换到下一个浮动终端

map("n", "fs", "<CMD>FloatermToggle<CR>")  -- 切换浮动终端的显示状态
map("t", "fs", "<CMD>FloatermToggle<CR>")  -- 在终端模式中切换浮动终端的显示状态

map("n", "fc", "<CMD>FloatermKill<CR>")  -- 关闭当前浮动终端
map("t", "fc", "<CMD>FloatermKill<CR>")  -- 在终端模式中关闭当前浮动终端

-- vim.notify("浮动终端加载完成")
