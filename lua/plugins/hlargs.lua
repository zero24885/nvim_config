-- 安全加载 hlargs.nvim 插件
local status, hlargs = pcall(require, "hlargs")
if not status then
    vim.notify("hlargs.nvim 插件未找到") -- 如果插件未找到，发送通知
    return
end

-- 配置 hlargs
hlargs.setup({
})
