-- 使用效果一般 后面可替换

-- 尝试加载 windows.nvim 插件
local status, windows = pcall(require, "windows")
if not status then
    -- 如果插件未找到，发送通知
    vim.notify("not found windows")
    return
end

-- 设置窗口选项
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false

-- 设置 windows.nvim 插件的配置
windows.setup({
    autowidth = {
        enable = false,  -- 启用自动宽度调整
        winwidth = 10,  -- 窗口宽度
        filetype = {    -- 针对特定文件类型的窗口宽度设置
            help = 2,
        },
    },

    -- 忽略指定类型的文件窗口
    ignore = {
        filetype = { "NvimTree", "undotree", "Outline" }, -- 忽略这些文件类型的窗口，不进行管理
    },
})

-- vim.notify("窗口插件加载完成")

vim.keymap.set('n', '<C-w>z',  '<CMD>WindowsMaximize')  -- 最大化窗口
vim.keymap.set('n', '<C-w>_',  '<CMD>WindowsMaximizeVertically')  -- 垂直最大化
vim.keymap.set('n', '<C-w>|',  '<CND>WindowsMaximizeHorizontally')  -- 水平最大化
vim.keymap.set('n', '<C-w>=',  '<CMD>WindowsEqualize')  -- 平衡所有窗口
