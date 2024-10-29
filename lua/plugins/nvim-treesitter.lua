-- 安全加载 nvim-treesitter 插件
local status, ts = pcall(require, "nvim-treesitter")
if not status then
    vim.notify("nvim-treesitter 插件未找到", vim.log.levels.ERROR)
    return
end

-- 插件设置
ts.setup {
    -- 指定要安装的语言解析器
    ensure_installed = {
        "c",
        "cpp",
        "python",
        "lua",
        "bash",
        -- 其他你需要的语言
        "vim",
        "cmake",
        "json",
        "markdown",
        "sql",
        "yaml",
        "ini",
        "javascript",
    },

    -- 启用增量高亮
    highlight = {
        enable = true,  -- 启用高亮
        additional_vim_regex_highlighting = false,  -- 禁用额外的 Vim 正则高亮
    },

    -- 启用代码折叠
    fold = {
        enable = false,  -- 禁用折叠
        disable = {},  -- 可在此处禁用特定语言的折叠
    },

    -- 启用增量语法解析
    incremental_selection = {
        enable = true,  -- 启用增量选择
        keymaps = {
            init_selection = "<CR>",  -- 开始增量选择
            node_incremental = "<CR>",  -- 选择下一个节点
            node_decremental = "<BS>",  -- 选择上一个节点
            scope_incremental = "<TABS>",  -- 选择当前范围
        },
    },

    -- 启用代码改进
    -- rainbow = {
    --     enable = true,  -- 启用彩虹括号
    --     extended_mode = true,  -- 允许多种括号
    --     max_file_lines = nil,  -- 不限制文件行数
    -- },
}

-- vim.notify("nvim-treesitter加载完成")
