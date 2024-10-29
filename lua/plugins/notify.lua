local status_ok, notify = pcall(require, "notify")
if not status_ok then
    print("Notify plugin is not installed!")
    return
end

-- 配置 notify
notify.setup({
    stages = "fade_in_slide_out",
    timeout = 500,
    render = "default",
    -- 其他配置选项
})

-- 使用 notify 发送通知
vim.notify = notify
