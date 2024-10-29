-- 安全加载 gitsigns 插件
local status, gitsigns = pcall(require, "gitsigns")
if not status then
    vim.notify("gitsigns not found")
    return
end

gitsigns.setup()
