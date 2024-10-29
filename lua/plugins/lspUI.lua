-- 安全加载 LspUI 插件
local status, LspUI = pcall(require, "LspUI")
if not status then
    vim.notify("LspUI not found")  -- 插件未找到时显示通知
    return
end

-- 选择透明度，支持 Neovide
local transparency = vim.g.neovide and 45 or 0  -- 如果使用 Neovide，设置透明度为 45，否则为 0

-- 配置 LspUI
LspUI.setup({
    hover = {
        transparency = transparency,  -- 悬浮窗口透明度
    },
    rename = {
        transparency = transparency,  -- 重命名窗口透明度
    },
    code_action = {
        transparency = transparency,  -- 代码行动窗口透明度
    },
    diagnostic = {
        transparency = transparency,  -- 诊断信息窗口透明度
    },
    pos_keybind = {
        transparency = transparency,  -- 位置绑定窗口透明度
    },
    signature = {
        enable = true,  -- 启用签名提示
    },
    inlay_hnnt = {
        enable = false,  -- 禁用内嵌提示
    },
})
-- vim.notify("lspUI加载完成")
-- 定义按键映射
local tool = require("tool")  -- 引入工具模块

-- 使用 <leader> 进行快捷键映射
tool.map("n", "<leader>rn", "<CMD>LspUI rename<CR>")  -- 重命名
tool.map("n", "<leader>ca", "<CMD>LspUI code_action<CR>")  -- 代码行动
tool.map("n", "gd", "<CMD>LspUI definition<CR>")  -- 跳转到定义
tool.map("n", "K", "<CMD>LspUI hover<CR>")  -- 悬浮提示
tool.map("n", "gD", "<CMD>LspUI declaration<CR>")  -- 跳转到声明
tool.map("n", "gi", "<CMD>LspUI implementation<CR>")  -- 跳转到实现
tool.map("n", "gr", "<CMD>LspUI reference<CR>")  -- 跳转到引用
tool.map("n", "gk", "<CMD>LspUI diagnostic prev<CR>")  -- 跳转到上一个诊断
tool.map("n", "gj", "<CMD>LspUI diagnostic next<CR>")  -- 跳转到下一个诊断
tool.map("n", "gy", "<CMD>LspUI type_definition<CR>")  -- 跳转到类型定义

