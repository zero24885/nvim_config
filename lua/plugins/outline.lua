-- 确保插件已安装
local status_ok, outline = pcall(require, "outline")
if not status_ok then
    print("Outline plugin is not installed!")
    return
end

-- 配置 outline.nvim 插件
outline.setup({
    -- 在打开文件时自动打开大纲
    auto_open = true,         -- 如果设置为 true，打开文件时会自动显示大纲
    auto_close = false,       -- 如果设置为 true，关闭最后一个大纲窗口时会自动关闭
    position = "right",       -- 大纲窗口的位置，选项为 "left", "right", "top", "bottom"
    width = 30,               -- 侧边栏的宽度
    height = 10,              -- 顶部或底部大纲窗口的高度
    show_icons = true,        -- 是否显示图标，便于识别
    highlight_on_select = true, -- 选中项是否高亮显示

    -- 其他配置选项可以在此处添加
})

-- 设置键映射，用于切换大纲
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>Outline<CR>", { noremap = true, silent = true, desc = "Toggle outline" })
