-- 安全加载 fidget.nvim 插件
local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
    vim.notify("fidget.nvim not found")
    return  -- 如果插件加载失败，则返回
end

-- 配置 fidget.nvim
fidget.setup({
    window = {
        blend = 0,  -- 窗口的透明度，0 为不透明，100 为完全透明
    },
    text = {
        spinner = "dots",  -- 选择进度指示器样式
        done = "✔️",  -- 完成时的文本
        commenced = "🔄",  -- 开始时的文本
        released = "🔹",  -- 释放时的文本
    },
    timer = {
        spinner_interval = 100,  -- 旋转动画的更新间隔（毫秒）
        fidget_interval = 1000,  -- fidget 窗口的更新间隔（毫秒）
    },
    sources = {  -- 配置 LSP 来源
        ["null-ls"] = {
            ignore = true,  -- 忽略 null-ls 的状态
        },
    },
})

-- vim.notify("fidget加载完成")
-- 这里可以添加更多相关的配置，例如按键绑定等

