if vim.g.neovide then  -- 检查是否在 Neovide 中运行
    vim.o.pumblend = 45  -- 设置弹出菜单的透明度

    local home = vim.fn.expand("~")  -- 获取用户主目录路径
    vim.fn.chdir(home)  -- 切换当前工作目录到用户主目录

    -- vim.o.guifont = "Maple Mono SC NF:h15"  -- 设置字体和字号
    vim.o.guifont = "JetBrainsMono Nerd Font:h15" -- 设置字体为 JetBrains Mono Nerd Font，字号为 15

    vim.g.neovide_input_ime = false  -- 初始化 IME 输入状态

    -- 定义函数以设置 IME 输入状态
    local function set_ime(args)
        if args.event:match("Enter$") then  -- 如果事件为 "Enter"
            vim.g.neovide_input_ime = true  -- 允许 IME 输入
        else
            vim.g.neovide_input_ime = false  -- 关闭 IME 输入
        end
    end

    -- 创建一个自动命令组以管理 IME 输入状态
    local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

    -- 在插入模式进入和离开时设置 IME 状态
    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = set_ime,
    })

    -- 在命令行进入和离开时设置 IME 状态
    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
        group = ime_input,
        pattern = "[/\\?]",
        callback = set_ime,
    })

    -- 设置 Neovide 窗口的边距
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    -- 设置浮动窗口模糊效果
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    -- 设置透明度
    vim.g.neovide_transparency = 0.9

    -- 输入时隐藏鼠标
    vim.g.neovide_hide_mouse_when_typing = true

    -- 设置刷新率
    vim.g.neovide_refresh_rate = 144  -- 刷新率
    vim.g.neovide_refresh_rate_idle = 5  -- 空闲时刷新率
    vim.g.neovide_no_idle = true  -- 关闭空闲状态

    -- 设置全屏模式
    vim.g.neovide_fullscreen = false

    -- 记住窗口大小
    vim.g.neovide_remember_window_size = true

    -- 启用光标抗锯齿
    vim.g.neovide_cursor_antialiasing = true

    -- 设置光标动画长度
    vim.g.neovide_cursor_animation_length = 0

    -- 禁用浮动窗口阴影
    vim.g.neovide_floating_shadow = false
end
