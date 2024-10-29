local tool = require("tool")  -- 引入工具模块
local map = tool.map  -- 获取映射函数
vim.g.mapleader = " "  -- 设置全局 leader 键为空格
vim.g.maplocalleader = " "  -- 设置本地 leader 键为空格

-- 取消默认的 's' 功能
map("n", "s", "")  -- 在普通模式下将 's' 的功能置为空

-- 窗口分屏快捷键
map("n", "sv", "<CMD>vsp<CR>")  -- 在普通模式下使用 'sv' 创建垂直分屏
map("n", "sh", "<CMD>sp<CR>")  -- 在普通模式下使用 'sh' 创建水平分屏
map("n", "sc", "<C-w>c")  -- 在普通模式下使用 'sc' 关闭当前窗口
map("n", "so", "<C-w>o")  -- 在普通模式下使用 'so' 关闭其他窗口

-- 使用 Alt + hjkl 在窗口间跳转
map("n", "wh", "<C-w>h")  -- 使用 'wh' 向左跳转窗口
map("n", "wj", "<C-w>j")  -- 使用 'wj' 向下跳转窗口
map("n", "wk", "<C-w>k")  -- 使用 'wk' 向上跳转窗口
map("n", "wl", "<C-w>l")  -- 使用 'wl' 向右跳转窗口

-- 在可视模式中缩进代码
map("v", "<", "<gv")  -- 使用 '<' 缩进选中的代码
map("v", ">", ">gv")  -- 使用 '>' 增加选中的代码缩进

-- 在可视模式中上下移动选中的文本
map("v", "K", "<CMD>move '<-2<CR>gv-gv")  -- 使用 'K' 向上移动选中的文本
map("v", "J", "<CMD>move '>+1<CR>gv-gv")  -- 使用 'J' 向下移动选中的文本

-- 退出设置（被注释掉）
map("n", "q", ":q<CR>")  -- 使用 'q' 退出当前窗口
-- map("n", "qq", ":q!<CR>")  -- 使用 'qq' 强制退出当前窗口
-- map("n", "Q", ":qa!<CR>")  -- 使用 'Q' 强制退出所有窗口

-- 保存设置
map("n", "<C-s>", "<CMD>w<CR>")  -- 在普通模式下使用 Ctrl + s 保存文件
map("i", "<C-s>", "<ESC><CMD>w<CR>")  -- 在插入模式下使用 Ctrl + s 保存文件并返回普通模式

-- 配置复制快捷键
-- map("v", "<C-c>", '"+y')  -- 使用 Ctrl + c 复制选中的文本到系统剪贴板
-- map("v", "<C-x>", '"+d')  -- 使用 Ctrl + x 剪切选中的文本到系统剪贴板
-- map("n", "<C-v>", '"+p')  -- 使用 Ctrl + v 粘贴系统剪贴板的内容（被注释掉）
-- map("i", "<C-v>", '<ESC>"+pa')  -- 在插入模式下使用 Ctrl + v 粘贴系统剪贴板的内容
