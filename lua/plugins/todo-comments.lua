-- 尝试加载 todo-comments 插件
local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
    print("Todo Comments plugin is not installed!") -- 如果未安装，输出提示
    return
end

-- 配置 todo-comments
todo_comments.setup({
    signs = true, -- 是否在标志列显示图标
    sign_priority = 8, -- 图标的优先级

    -- 识别的关键词及其图标和颜色
    keywords = {
        FIX = {
            icon = " ", -- 图标
            color = "error", -- 颜色类型
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- 其他映射到该关键词的替代名称
        },
        TODO = { icon = " ", color = "info" }, -- TODO关键词的图标和颜色
        HACK = { icon = " ", color = "warning" }, -- HACK关键词的图标和颜色
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } }, -- WARN关键词及替代名称
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } }, -- 性能相关的关键词
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } }, -- NOTE关键词的图标和颜色
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } }, -- 测试相关关键词
    },
    
    gui_style = {
        fg = "NONE", -- 前景色样式
        bg = "BOLD", -- 背景色样式
    },

    merge_keywords = true, -- 是否合并自定义关键词与默认关键词

    -- 高亮配置
    highlight = {
        multiline = true, -- 启用多行 todo 注释
        multiline_pattern = "^.", -- 匹配多行注释的模式
        multiline_context = 10, -- 改变行时重新评估的额外行数
        before = "", -- 在关键词之前的高亮
        keyword = "wide", -- 关键词的高亮样式
        after = "fg", -- 关键词后面的高亮样式
        pattern = [[.*<(KEYWORDS)\s*:]], -- 用于高亮的正则模式
        comments_only = true, -- 只在注释中匹配关键词
        max_line_len = 400, -- 忽略长度超过此值的行
        exclude = {}, -- 排除高亮的文件类型
    },

    -- 颜色配置
    colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" }, -- 错误颜色配置
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- 警告颜色配置
        info = { "DiagnosticInfo", "#2563EB" }, -- 信息颜色配置
        hint = { "DiagnosticHint", "#10B981" }, -- 提示颜色配置
        default = { "Identifier", "#7C3AED" }, -- 默认颜色配置
        test = { "Identifier", "#FF00FF" }, -- 测试颜色配置
    },

    -- 搜索配置
    search = {
        command = "rg", -- 使用 ripgrep 作为搜索命令
        args = {
            "--color=never", -- 禁用颜色
            "--no-heading", -- 不显示文件标题
            "--with-filename", -- 显示文件名
            "--line-number", -- 显示行号
            "--column", -- 显示列号
        },
        pattern = [[\b(KEYWORDS):]], -- 匹配关键词的正则模式
    },
})

