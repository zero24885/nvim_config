-- 基本配置

-- 设置编码
vim.o.encoding = "utf-8"  -- Vim内部使用的字符编码
vim.o.fileencoding = "utf-8"  -- 文件保存时的编码

-- 滚动设置
vim.o.scrolloff = 5  -- 在光标上方和下方保持的行数
vim.o.sidescroll = 5  -- 在光标左右两侧保持的列数


-- 自动切换目录
-- 无论你用 Vim 打开哪个文件，
-- Vim 的当前工作目录都会保持在你启动 Vim 时所在的目录，而不会改变
vim.o.autochdir = false  -- 禁用自动切换到当前文件目录

-- 行号设置
vim.o.number = true  -- 显示行号
-- vim.o.relativenumber = true  -- 显示相对行号

-- 高亮当前行
vim.o.cursorline = true  -- 高亮当前行

-- 其他显示设置
vim.o.signcolumn = "yes"  -- 始终显示标记列
-- vim.o.colorcolumn = "80"  -- 在第80列处显示一条垂直线

-- 缩进设置
vim.o.tabstop = 4  -- 制表符宽度
vim.o.softtabstop = 4  -- 在插入模式下按退格的制表符宽度
vim.o.shiftround = true  -- 调整缩进时四舍五入

vim.o.shiftwidth = 4  -- 自动缩进宽度
vim.o.expandtab = true  -- 用空格替代制表符

-- 自动缩进设置
vim.o.autoindent = true  -- 启用自动缩进
vim.o.smartindent = true  -- 启用智能缩进

-- 搜索设置
vim.o.ignorecase = true  -- 忽略大小写
vim.o.smartcase = true  -- 如果搜索中有大写字母则区分大小写
vim.o.hlsearch = true  -- 高亮搜索结果
vim.o.incsearch = true  -- 实时搜索

-- 窗口设置
vim.o.cmdheight = 1  -- 命令行高度
vim.o.autoread = true  -- 自动读取文件变化

-- 文本包裹设置
vim.o.wrap = false  -- 不自动换行
-- vim.o.whichwrap = "b,s,<,>,[,"  -- 控制换行时的光标移动

-- 隐藏缓冲区设置
vim.o.hidden = true  -- 允许隐藏未保存的缓冲区

-- 鼠标支持
vim.o.mouse = "a"  -- 启用所有模式下的鼠标支持

-- 备份设置
vim.o.backup = false  -- 禁用备份文件
vim.o.writebackup = false  -- 禁用写入备份
vim.o.swapfile = false  -- 禁用交换文件

-- 更新和超时设置
vim.o.updatetime = 300  -- 更新间隔
vim.o.timeoutlen = 400  -- 超时等待时间

-- 分屏设置
vim.o.splitbelow = true  -- 新分屏在下方
vim.o.splitright = true  -- 新分屏在右侧

-- 完成选项
vim.o.completeopt = "menu,menuone,noselect,noinsert"  -- 完成菜单选项

-- 主题和颜色设置
vim.o.background = "dark"  -- 背景颜色
vim.o.termguicolors = true  -- 支持24位真彩色

-- 列表显示设置
-- vim.o.list = true  -- 显示不可见字符
-- vim.o.listchars = "space:·,tab:··,eol:↴"  -- 自定义不可见字符的显示

-- Wildmenu 设置
vim.o.wildmenu = true  -- 启用 wildmenu

-- 补全菜单高度
vim.o.pumheight = 10  -- 补全菜单高度

-- 标签页和模式设置
-- vim.o.showtabline = 1  -- 始终显示标签页
vim.o.showmode = false  -- 不显示当前模式

-- 折叠设置
vim.o.foldcolumn = "1"  -- 折叠列的宽度
vim.o.foldlevel = 99  -- 默认折叠级别
vim.o.foldlevelstart = 99  -- 启动时折叠的级别
vim.o.foldenable = true  -- 启用折叠功能
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]  -- 自定义折叠字符

-- Zig 自动保存设置
vim.g.zig_fmt_autosave = false  -- 禁用 Zig 文件的自动保存

-- Perl 提供程序禁用设置
vim.g.loaded_perl_provider = false  -- 禁用 Perl 提供程序


-- 重新定义默认的诊断标志（signs）
-- 更多信息参考：https://neovim.io/doc/user/diagnostic.html#diagnostic-signs

-- 定义每种诊断类型对应的图标（注释掉的是旧版配置方法）
-- local signs = { 
--     Error = "󰅚",  -- 错误的图标
--     Warn = "",   -- 警告的图标
--     Hint = "",   -- 提示的图标
--     Info = ""    -- 信息的图标
-- }
-- 对每种类型的图标进行定义
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type -- 生成高亮组名称
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl }) -- 定义标志图标及其高亮
-- end

-- 使用新方法配置诊断显示
vim.diagnostic.config({
    signs = {
        text = {  -- 定义不同严重性级别的诊断标志图标
            [vim.diagnostic.severity.ERROR] = "󰅚",  -- 错误标志
            [vim.diagnostic.severity.WARN] = "",   -- 警告标志
            [vim.diagnostic.severity.HINT] = "",   -- 提示标志
            [vim.diagnostic.severity.INFO] = "",   -- 信息标志
        },
        linehl = {  -- 行高亮配置，当前未使用（注释掉）
            -- [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            -- [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            -- [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            -- [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            -- [vim.diagnostic.severity.ERROR] = "DiagnosticSign",
            -- [vim.diagnostic.severity.WARN] = "DiagnosticSign",
            -- [vim.diagnostic.severity.HINT] = "DiagnosticSign",
            -- [vim.diagnostic.severity.INFO] = "DiagnosticSign",
            
        },
        numhl = {  -- 行号高亮配置
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",  -- 错误行号高亮
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",    -- 警告行号高亮
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",    -- 提示行号高亮
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",    -- 信息行号高亮
        },
    },
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.ERROR,  -- 只显示错误，不显示警告
        -- 设置为波浪线
        -- prefix = "✗",  -- 可以选择一个图标作为波浪线的前缀
        -- spacing = 4,  -- 调整文本与波浪线的间距
        },
    },
})
